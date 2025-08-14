// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/login_bloc/login_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Icon(Icons.account_circle_rounded),
            ),
            Text(
              'profile screen',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(LogoutEvent());
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
