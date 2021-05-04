import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateUsernameTextField extends StatelessWidget {
  const UpdateUsernameTextField(
    this.controller,
  );
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
          ),
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
      ),
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: TextFormField(
          controller: controller,
          style: GoogleFonts.lato(
            fontSize: 20,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: RequiredValidator(errorText: 'This is required'),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
