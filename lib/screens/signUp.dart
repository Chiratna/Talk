import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:talk/provider/email_sign_in.dart';
import 'package:talk/widgets/alreadyUserBtn.dart';
import 'package:talk/widgets/emailTextField.dart';
import 'package:talk/widgets/passwordTextField.dart';
import 'package:talk/widgets/signUpBtn.dart';
import 'package:talk/widgets/usernameTextField.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  void validate(BuildContext ctx) {
    String x = fKey.currentState.validate() ? "validated" : null;
    if (x != null) {
      print(emailController.text);
      print(pwdController.text);
      print(usernameController.text);
      // //signUp(emailController.text.trim(), pwdController.text.trim(),
      //         usernameController.text.trim())
      //     .whenComplete(() => Navigator.of(ctx).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                  left: 32,
                  top: 32,
                  bottom: 0,
                ),
                child: Text(
                  'Get Started...',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: fKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      child: UsernameTextField(
                        controller: usernameController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        left: 32,
                        right: 32,
                        bottom: 16,
                      ),
                      child: EmailTextField(
                        controller: emailController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 8,
                      ),
                      child: PasswordTextField(
                        controller: pwdController,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  validate(context);
                },
                child: SignUpBtn(),
              ),
              AlreadyUserBtn()
            ],
          ),
        ),
      ),
    );
  }
}
