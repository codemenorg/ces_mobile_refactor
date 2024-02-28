// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    required this.validation,
    required this.labelText,
    required this.controller,
    super.key,
    this.validationCallBack,
  });

  final bool validation;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validationCallBack;
  //

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode:
          validation ? AutovalidateMode.always : AutovalidateMode.disabled,
      validator: validationCallBack,
      cursorColor: AppColors.primaryContainer,
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        letterSpacing: 1,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.blue,
      ),
      decoration: InputDecoration(
        fillColor: AppColors.grey.shade300,
        labelText: labelText,
        errorStyle: const TextStyle(
          letterSpacing: 1,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.red,
        ),
        contentPadding: const EdgeInsets.all(20),
        labelStyle: const TextStyle(
          letterSpacing: 1,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey.shade300,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey.shade300,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
