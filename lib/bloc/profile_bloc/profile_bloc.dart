// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iti_final_team3/data/repo/user_repository.dart';
// import 'package:iti_final_team3/utils/app_strings.dart';
// part 'profile_event.dart';
// part 'profile_state.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   final UserRepository repository;
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   ProfileBloc({required this.repository}) : super(ProfileState()) {
//     on<PfpPicked>((event, emit) {
//       emit(
//         state.copyWith(
//           pickedImage: event.file,
//           errorMessage: '',
//           isSuccess: false,
//         ),
//       );
//     });

//     on<ClearFormEvent>((event, emit) {
//       emit(ProfileState());
//     });

//     on<UploadSubmitted>((event, emit) async {
//       if (state.pickedImage == null) {
//         emit(state.copyWith(errorMessage: AppStrings.errorMessage));
//         return;
//       }
//       emit(state.copyWith(
//         isSubmitting: true,
//         errorMessage: '',
//         isSuccess: false,
//       ));

//       try {
//         // Upload the image to Cloudinary
//         final imageUrl = await repository.uploadProfileImage(state.pickedImage!);

//         // Update only the profile image in Firestore
//         await repository.updateUserProfile(
//           userId: auth.currentUser?.uid,
//           profileImageUrl: imageUrl,
//         );

//         emit(state.copyWith(
//           isSubmitting: false,
//           isSuccess: true,
//           profileImageUrl: imageUrl, // Update the state with new URL
//         ));
//       } catch (e) {
//         emit(state.copyWith(
//           isSubmitting: false,
//           errorMessage: e.toString(),
//         ));
//       }
//     });

//     on<FetchProfileImage>((event, emit) async {
//       emit(state.copyWith(isLoading: true));
//       try {
//         final url = await repository.getProfileImageUrl(
//           userId: auth.currentUser?.uid,
//         );

//         emit(state.copyWith(
//           isLoading: false,
//           profileImageUrl: url,
//         ));
//       } catch (e) {
//         emit(state.copyWith(
//           isLoading: false,
//           errorMessage: e.toString(),
//         ));
//       }
//     });
//   }
// }
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/data/repo/user_repository.dart';
import 'package:iti_final_team3/utils/app_strings.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository repository;
  final FirebaseAuth auth = FirebaseAuth.instance;

  ProfileBloc(this.repository) : super(ProfileInitialState()) {
    on<PfpPickedEvent>(_onPfpPicked);
    on<ClearFormEvent>(_onClearForm);
    on<UploadSubmittedEvent>(_onUploadSubmitted);
    on<FetchProfileImageEvent>(_onFetchProfileImage);
  }

  void _onPfpPicked(PfpPickedEvent event, Emitter<ProfileState> emit) {
    emit(ProfileImagePickedState(event.file,
        profileImageUrl: state.profileImageUrl));
  }

  void _onClearForm(ClearFormEvent event, Emitter<ProfileState> emit) {
    emit(ProfileInitialState());
  }

  Future<void> _onUploadSubmitted(
      UploadSubmittedEvent event, Emitter<ProfileState> emit) async {
    final currentState = state;

    if (currentState is! ProfileImagePickedState) {
      emit(ProfileFailureState(AppStrings.errorMessage));
      return;
    }

    emit(ProfileSubmittingState());

    try {
      final imageUrl =
          await repository.uploadProfileImage(currentState.pickedImage!);

      await repository.updateUserProfile(
        userId: auth.currentUser?.uid,
        profileImageUrl: imageUrl,
      );

      emit(ProfileSuccessState(profileImageUrl: imageUrl));
    } catch (e) {
      emit(ProfileFailureState(e.toString()));
    }
  }

  Future<void> _onFetchProfileImage(
      FetchProfileImageEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState(
        pickedImage: state.pickedImage,
        profileImageUrl: state.profileImageUrl));
    try {
      final url = await repository.getProfileImageUrl(
        userId: auth.currentUser?.uid,
      );
      debugPrint('Fetched profile image URL: $url');
      emit(ProfileSuccessState(profileImageUrl: url));
    } catch (e) {
      emit(ProfileFailureState(e.toString(),
          pickedImage: state.pickedImage,
          profileImageUrl: state.profileImageUrl));
    }
  }
}
