import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iti_final_team3/bloc/nav_bloc/nav_bloc.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/widget/show_toast.dart';
import '../bloc/upload_data/upload_bloc.dart';

class UploadPage extends StatelessWidget {
  final Map<String, dynamic>? post; 
  UploadPage({super.key, this.post});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    if (post != null) {
      titleController.text = post!['title'] ?? '';
      descriptionController.text = post!['description'] ?? '';
    }

    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        context.read<UploadBloc>().add(ImagePicked(File(pickedFile.path)));
      }
    }

    void discardImageInfo() {
      context.read<UploadBloc>().add(ClearFormEvent());
      titleController.text = '';
      descriptionController.text = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(post == null ? AppStrings.uploadImage : "Edit Post"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: AppStrings.title),
              onChanged: (value) =>
                  context.read<UploadBloc>().add(TitleChanged(value)),
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(labelText: AppStrings.description),
              onChanged: (value) =>
                  context.read<UploadBloc>().add(DescriptionChanged(value)),
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 20),

            BlocConsumer<UploadBloc, UploadState>(
              listener: (context, state) {
                if (state is UploadSuccess) {
                  AppToast.showToast(
                    post == null
                        ? AppStrings.uploadSuccessful
                        : "Update Successful",
                    Colors.green,
                  );
                  context.read<NavigationBloc>().add(NavigateTo(0));
                  discardImageInfo();
                } else if (state is UploadFailure) {
                  AppToast.showToast(state.errorMessage, Colors.red);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    if (state.pickedImage != null)
                      Image.file(state.pickedImage!, height: 150)
                    else if (post != null && post!['url'] != null)
                      Image.network(post!['url'], height: 150)
                    else
                      const Text(AppStrings.noImageSelected),

                    const SizedBox(height: 8),
                    FloatingActionButton(
                      onPressed: pickImage,
                      child: const Icon(Icons.add_a_photo),
                    ),
                    const SizedBox(height: 8),

                    if (state is UploadSubmitting)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          if (post == null) {
                            context.read<UploadBloc>().add(UploadSubmitted());
                          } else {
                            context.read<UploadBloc>().add(UpdateSubmitted(
                             post!['id'],
                            ));
                          }
                        },
                        child: Text(post == null ? "Upload" : "Update"),
                      ),
                    ElevatedButton(
                      onPressed: discardImageInfo,
                      child: const Text(AppStrings.discard),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


