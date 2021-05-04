import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
          )
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
      ),
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: MultiValidator([
          MinLengthValidator(6, errorText: 'Should be atleast 6 characters'),
          MaxLengthValidator(15,
              errorText: 'Should not be more than 15 characters'),
        ]),
        decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
      ),
    );
  }
}
