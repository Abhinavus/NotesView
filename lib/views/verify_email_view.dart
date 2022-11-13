
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mynotes/constants/routes.dart';

import '../services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(children: [
          const Text("we've send you an email verification"),
          const Text("If you haven't Please verify email"),
          TextButton(onPressed: () async {
          await AuthService.firebase().sendEmailVerification();
          }, child: const Text ('Send email verification')),
          TextButton(onPressed: () async {
           await  AuthService.firebase().logOut();
           Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }, child: const Text('Restart'),)
        ], 
      ),
    );
  }
  }