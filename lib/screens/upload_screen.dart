import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iti_final_team3/bloc/nav_bloc/nav_bloc.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/widget/show_toast.dart';
import '../bloc/upload_data/upload_bloc.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        context.read<UploadBloc>().add(ImagePicked(File(pickedFile.path)));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.uploadImage)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: AppStrings.title),
              onChanged: (value) =>
                  context.read<UploadBloc>().add(TitleChanged(value)),
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration:
                  const InputDecoration(labelText: AppStrings.description),
              onChanged: (value) =>
                  context.read<UploadBloc>().add(DescriptionChanged(value)),
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 20),
            BlocConsumer<UploadBloc, UploadState>(
              listener: (context, state) {
                if (state is UploadSuccess) {
                  AppToast.showToast(AppStrings.uploadSuccessful, Colors.green);
                  context.read<NavigationBloc>().add(NavigateTo(0));
                  context.read<UploadBloc>().add(ClearFormEvent());
                } else if (state is UploadFailure) {
                  AppToast.showToast(state.errorMessage, Colors.red);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    if (state.pickedImage != null)
                      Image.file(state.pickedImage!, height: 150)
                    else
                      const Text(AppStrings.noImageSelected),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: const Icon(Icons.add_a_photo),
                    ),
                    const SizedBox(height: 8),
                    if (state is UploadSubmitting)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          context.read<UploadBloc>().add(UploadSubmitted());
                        },
                        child: const Text(AppStrings.upload),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
