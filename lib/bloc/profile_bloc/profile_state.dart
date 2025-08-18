part of 'profile_bloc.dart';

abstract class ProfileState {
  final File? pickedImage;
  final String? profileImageUrl;

  const ProfileState({this.pickedImage, this.profileImageUrl});
}

class ProfileInitialState extends ProfileState {
  const ProfileInitialState() : super();
}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState({super.pickedImage, super.profileImageUrl});
}
class ProfileUploadedState extends ProfileSuccessState {
  const ProfileUploadedState({super.profileImageUrl});
}

class ProfileImagePickedState extends ProfileState {
  const ProfileImagePickedState(File pickedImage, {super.profileImageUrl})
      : super(pickedImage: pickedImage);
}

class ProfileSubmittingState extends ProfileState {
  const ProfileSubmittingState({super.pickedImage, super.profileImageUrl});
}

class ProfileSuccessState extends ProfileState {
  const ProfileSuccessState({super.pickedImage, super.profileImageUrl});
}

class ProfileFailureState extends ProfileState {
  final String errorMessage;
  const ProfileFailureState(this.errorMessage,
      {super.pickedImage, super.profileImageUrl});
}
