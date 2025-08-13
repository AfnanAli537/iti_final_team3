// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/login_bloc/login_bloc.dart';
import 'package:iti_final_team3/utils/app_colors.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/utils/form_validator.dart';
import 'package:iti_final_team3/widget/app_text_form_field.dart';
import 'package:iti_final_team3/widget/show_toast.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginResetPasswordState) {
          AppToast.showToast(
              error: AppStrings.successResetPassword, color: AppColors.border);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.lock_reset_outlined,
                      size: 100, color: AppColors.mainColor),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.resetPassword,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              AppTextField(
                                controller: emailController,
                                prefixIcon: const Icon(Icons.email),
                                textContent: AppStrings.email,
                                validator: FormValidator.validateEmail,
                              ),
                              (state is LoginLoadingState)
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(
                                            ForgetPasswordEvent(
                                              email:
                                                  emailController.text.trim(),
                                            ),
                                          );
                                        }
                                      },
                                      style: Theme.of(context)
                                          .elevatedButtonTheme
                                          .style!
                                          .copyWith(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                              AppColors.text,
                                            ),
                                          ),
                                      child: const Text(
                                        AppStrings.sendResetPassword,
                                        style: TextStyle(
                                          color: AppColors.darkText,
                                        ),
                                      ),
                                    ),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    AppStrings.or,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'back to',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(AppStrings.login),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
