import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/login_bloc/login_bloc.dart';
import 'package:iti_final_team3/utils/app_colors.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/utils/form_validator.dart';
import 'package:iti_final_team3/widget/form_feild.dart';
import 'package:iti_final_team3/widget/show_toast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                if (!FirebaseAuth.instance.currentUser!.emailVerified) {
                  AppToast.showToast(AppStrings.verifyEmail, Colors.red);
                } else {
                  AppToast.showToast(AppStrings.loginSucess, Colors.grey);
                  Navigator.pushReplacementNamed(context, '/main');
                }
              } else if (state is LoginFailureState) {
                AppToast.showToast(state.error, Colors.red);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Text(
                          AppStrings.openWord,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        spacing: 40,
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              spacing: 10,
                              children: [
                                AppTextField(
                                  controller: emailController,
                                  prefixIcon: const Icon(Icons.email),
                                  textContent: AppStrings.email,
                                  validator: FormValidator.validateEmail,
                                ),
                                AppTextField(
                                  controller: passwordController,
                                  prefixIcon: const Icon(Icons.lock),
                                  isPassword: true,
                                  textContent: AppStrings.password,
                                  validator: FormValidator.validatePassword,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/forgetPassword');
                                    },
                                    child: Text(
                                      AppStrings.forgetPassword,
                                      style: TextStyle(
                                        color: AppColors.textForgetBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                (state is LoginLoadingState)
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .add(
                                                LoginSubmittedEvent(
                                                  email: emailController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text(
                                            AppStrings.login,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Text(
                            AppStrings.or,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          // SizedBox(
                          //   height: 50,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       // BlocProvider.of<SignupBloc>(context).add(
                          //       //   SignupGoogleEvent(),
                          //       // );
                          //     },
                          //     style: Theme.of(context)
                          //         .elevatedButtonTheme
                          //         .style!
                          //         .copyWith(
                          //           backgroundColor: WidgetStateProperty.all(
                          //             Colors.grey[200],
                          //           ),
                          //         ),
                          //     child: Row(
                          //       mainAxisSize: MainAxisSize.min,
                          //       spacing: 10,
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           AppStrings.loginWithGoogle,
                          //           style: Theme.of(
                          //             context,
                          //           ).textTheme.bodyMedium,
                          //         ),
                          //         Icon(
                          //           MyFlutterAppIcons.google,
                          //           color: AppColors.mainColor,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          AppStrings.newAccount,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          child: const Text(AppStrings.signUp),
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
