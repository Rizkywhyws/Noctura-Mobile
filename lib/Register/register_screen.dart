import 'package:flutter/material.dart';
import '../core/widgets/wavy_header.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            WavyHeader(),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}