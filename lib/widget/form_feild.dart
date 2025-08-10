import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/form_bloc/form_bloc.dart';

class AppTextField extends StatelessWidget {
  final String? textContent;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final bool isSecured;
  final String? Function(String?)? validator;

  const AppTextField(
      {super.key,
      required this.controller,
      this.textContent,
      this.prefixIcon,
      this.isSecured = false,
      this.isPassword = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          obscureText: isPassword ? state.isoObscure : false,
          decoration: InputDecoration(
            hintText: textContent,
            prefixIcon: prefixIcon,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      state.isoObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      context
                          .read<PasswordVisibilityBloc>()
                          .add(TogglePasswordVisibilityEvent());
                    },
                  )
                : null,
          ),
          validator: validator,
        );
      },
    );
  }
}
