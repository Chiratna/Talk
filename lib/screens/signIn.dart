import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk/constants/constants.dart';
import 'package:talk/provider/email_sign_in.dart';
import 'package:talk/widgets/alreadyUserBtn.dart';
import 'package:talk/widgets/emailTextField.dart';
import 'package:talk/widgets/googleSignInBtn.dart';
import 'package:talk/widgets/passwordTextField.dart';
import 'package:talk/widgets/registerUserBtn.dart';
import 'package:talk/widgets/signInBtn.dart';
import 'package:talk/widgets/signUpBtn.dart';
import 'package:talk/widgets/usernameTextField.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  File _image;
  bool isSigningIn = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  Mode m = Mode.SIGN_IN;
  double emailTopMargin = 8;
  void validate(BuildContext context) async {
    String x = fKey.currentState.validate() ? "validated" : null;

    if (x != null) {
      String email = emailController.text.trim();
      String pwd = pwdController.text.trim();
      String name = usernameController.text.trim();
      if (m == Mode.SIGN_IN) {
        setState(() {
          isSigningIn = true;
        });
        await signIn(
          email,
          pwd,
          context,
        );
      } else {
        if (_image != null) {
          setState(() {
            isSigningIn = true;
          });
          await signUp(
            email,
            pwd,
            name,
            _image,
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Please pick an image')));
        }
      }
    }
  }

  pickImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    emailTopMargin = m == Mode.SIGN_IN ? 16 : 8;
    return Scaffold(
      body: isSigningIn
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/image/bg.jpeg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                )),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                        left: 32,
                        top: 32,
                        bottom: 16,
                      ),
                      child: Text(
                        m == Mode.SIGN_IN
                            ? 'Welcome...\nDo You want to TALK...\n\nSign In'
                            : 'Let\'s \nGet Started...',
                        style: GoogleFonts.lato(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    m == Mode.SIGN_UP
                        ? Container(
                            height: 150,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.black,
                                    child: _image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.file(
                                              _image,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: 100,
                                            height: 100,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  child: Text(
                                    'Upload Your Photo',
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Form(
                      key: fKey,
                      child: Column(
                        children: [
                          m == Mode.SIGN_UP
                              ? Container(
                                  margin: EdgeInsets.only(
                                    top: 24,
                                  ),
                                  child: UsernameTextField(
                                    controller: usernameController,
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: EdgeInsets.only(
                              top: m == Mode.SIGN_UP ? 0 : 32,
                            ),
                            child: EmailTextField(
                              controller: emailController,
                            ),
                          ),
                          PasswordTextField(
                            controller: pwdController,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        validate(context);
                      },
                      child: m == Mode.SIGN_IN ? SignInBtn() : SignUpBtn(),
                    ),
                    GestureDetector(
                        onTap: () {
                          googlelogin();
                        },
                        child: GoogleSignInBtn(size: size)),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          if (m == Mode.SIGN_IN)
                            m = Mode.SIGN_UP;
                          else
                            m = Mode.SIGN_IN;
                        });
                      },
                      child: m == Mode.SIGN_IN
                          ? RegisterUserBtn()
                          : AlreadyUserBtn(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
