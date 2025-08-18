part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class PfpPickedEvent extends ProfileEvent {
  final File file;
  PfpPickedEvent(this.file);
}

class ClearFormEvent extends ProfileEvent {}

class UploadSubmittedEvent extends ProfileEvent {}

class FetchProfileImageEvent extends ProfileEvent {}
