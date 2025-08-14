import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/signup_bloc/signup_bloc.dart';
import 'package:iti_final_team3/utils/app_colors.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/utils/form_validator.dart';
import 'package:iti_final_team3/widget/app_text_form_field.dart';
import 'package:iti_final_team3/widget/show_toast.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccessState) {
                AppToast.showToast(
                    AppStrings.signUpSuccess, Colors.grey);
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                );
              } else if (state is SignUpFailureState) {
                AppToast.showToast(
                    AppStrings.verifyEmail, Colors.red);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.party_mode_rounded,
                            size: 100, color: AppColors.mainColor),
                        Text(
                          AppStrings.signUp,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          AppStrings.newAccount,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          spacing: 15,
                          children: [
                            AppTextField(
                              controller: userNameController,
                              prefixIcon: const Icon(Icons.person),
                              textContent: AppStrings.userName,
                              validator: FormValidator.validateName,
                            ),
                            AppTextField(
                              controller: emailController,
                              prefixIcon: const Icon(Icons.email),
                              textContent: AppStrings.email,
                              validator: FormValidator.validateEmail,
                            ),
                            AppTextField(
                              controller: passwordController,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<SignUpBloc>(context)
                                      .add(ToggleVisibilityEvent());
                                },
                                icon: Icon(
                                  state.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              textContent: AppStrings.password,
                              obscureText: !state.isPasswordVisible,
                              validator: FormValidator.validatePassword,
                            ),
                            AppTextField(
                              controller: confirmPasswordController,
                              textContent: AppStrings.confirmPassword,
                              obscureText: true,
                              prefixIcon: const Icon(Icons.lock),
                              validator: (value) =>
                                  FormValidator.validateConfirmPassword(
                                passwordController.text,
                                value,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpSubmittedEvent(
                                        name: userNameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        confirmPassword:
                                            confirmPasswordController.text
                                                .trim(),
                                      ),
                                    );
                                  }
                                },
                                child: (state is SignUpLoadingState)
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        AppStrings.signUp,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.oldAccount,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(AppStrings.login),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
