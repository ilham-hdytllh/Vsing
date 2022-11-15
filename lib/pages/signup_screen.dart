import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vsing/pages/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpScreen({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _yourNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool visibilityPassword = true;
  bool confirmvisibilityPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _yourNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      // create user
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // add user details
        addUserDetails(
          _yourNameController.text.trim(),
          _emailController.text.trim(),
          int.parse(_phoneNumberController.text.trim()),
        );
      } on FirebaseAuthException catch (e) {
        showNotification(context, e.message.toString());
      }
    }
  }

  Future addUserDetails(String yourName, String email, int phoneNumber) async {
    await FirebaseFirestore.instance.collection('costumer').doc(email).set({
      'your name': yourName,
      'email': email,
      'phone number': phoneNumber,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage("assets/images/signup_screen.png"),
                  height: size.height * 0.3,
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.nunito(
                        fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                              color: Colors.black87),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email),
                            labelText: 'Email ID',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                              color: Colors.black87),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: 'Fullname',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _phoneNumberController,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                              color: Colors.black87),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone_outlined),
                            labelText: 'Mobile',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                              color: Colors.black87),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outlined),
                            labelText: 'Password',
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibilityPassword = !visibilityPassword;
                                });
                              },
                              icon: visibilityPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                          ),
                          obscureText: visibilityPassword,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _confirmPasswordController,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                              color: Colors.black87),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outlined),
                            labelText: 'Confirm Password',
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  confirmvisibilityPassword =
                                      !confirmvisibilityPassword;
                                });
                              },
                              icon: confirmvisibilityPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                          ),
                          obscureText: confirmvisibilityPassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "By signing up, you're agree to our Terms & Conditions and Privacy Policy",
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.3,
                                color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff3865FF)),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 15),
                              ),
                            ),
                            onPressed: signUp,
                            child: Text(
                              "Continue",
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.3,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Joined us before?',
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                              child: Text(
                                'Login',
                                style: GoogleFonts.nunito(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              onPressed: widget.showLoginPage,
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
