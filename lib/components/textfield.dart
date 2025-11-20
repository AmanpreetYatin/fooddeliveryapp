import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FodaTextfield extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool? isPassword;
  const FodaTextfield({
    Key? key,
    required this.title,
    this.isPassword = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword!,
      decoration: InputDecoration(
        hintText: title,
      ),
    );
  }
}
