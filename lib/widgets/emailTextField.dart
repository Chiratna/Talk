import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({this.controller});
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: MultiValidator([
          RequiredValidator(errorText: 'This is required'),
          EmailValidator(errorText: 'Enter a valid email')
        ]),
        decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            labelText: 'Email',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
      ),
    );
  }
}
