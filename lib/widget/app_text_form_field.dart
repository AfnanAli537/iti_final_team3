// app_text_form_field.dart
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? textContent;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    this.textContent,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        obscureText: obscureText,
        validator:validator,
        // (value) {
        //   // if (value == null || value.isEmpty) return 'please enter a value';
        //   switch (textContent) {
        //     case AppStrings.userName:
        //       if (value == null || value.isEmpty)
        //         return AppStrings.usernameRequired;
        //       break;
        //     case AppStrings.email:
        //       if (value == null || value.isEmpty)
        //         return AppStrings.emailRequired;
        //       break;
        //     case AppStrings.password:
        //       if (value == null || value.isEmpty)
        //         return AppStrings.passwordRequired;
        //       break;
        //     case AppStrings.confirmPassword:
        //       if (value == null || value.isEmpty)
        //         return AppStrings.confirmPasswordRequired;
        //       break;
        //     default:
        //   }
        // },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          hintText: textContent,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
