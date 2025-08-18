import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iti_final_team3/bloc/profile_bloc/profile_bloc.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/widget/show_toast.dart';

class ProfileAvatar extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    this.size = 155,
  });

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        context.read<ProfileBloc>().add(PfpPickedEvent(File(pickedFile.path)));
      }
    }

    return BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state is ProfileUploadedState) {
        AppToast.showToast(AppStrings.uploadSuccessful, Colors.green);
        context.read<ProfileBloc>().add(FetchProfileImageEvent());
      } else if (state is ProfileFailureState) {
        AppToast.showToast(state.errorMessage, Colors.red);
      }
    }, builder: (context, state) {
      final pickedImage = state.pickedImage;
      final profileImageUrl = state.profileImageUrl;
      final isLoading = state is ProfileLoadingState;
      final isSubmitting = state is ProfileSubmittingState;
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : pickedImage != null
                          ? Image.file(pickedImage, fit: BoxFit.cover)
                          : profileImageUrl != null
                              ? Image.network(profileImageUrl,
                                  fit: BoxFit.cover)
                              : Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/847/847969.png',
                                  fit: BoxFit.cover,
                                ),
                ),
              ),
              IconButton(
                onPressed: pickImage,
                icon: Icon(Icons.edit, color: iconColor),
              ),
            ],
          ),
          if (pickedImage != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(UploadSubmittedEvent());
                      },
                      child: const Text("Save Changes"),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProfileBloc>()
                    ..add(ClearFormEvent())
                    ..add(FetchProfileImageEvent());
                },
                child: const Text("Discard"),
              ),
            ),
          ],
        ],
      );
    });
  }
}
