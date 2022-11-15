import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vsing/pages/login_screen.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _ConfirmPasswordController = TextEditingController();
  final _PasswordController = TextEditingController();
  bool visibilityPassword = true;
  bool _visibilityPassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              'assets/images/back.png',
              fit: BoxFit.cover,
              width: 28,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Image(
                  image: AssetImage("assets/images/reset_screen.png"),
                  height: size.height * 0.4,
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Reset \nPassword",
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
                          controller: _PasswordController,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                              color: Colors.black87),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outlined),
                            labelText: 'New Password',
                            labelStyle: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3),
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: visibilityPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    visibilityPassword = !visibilityPassword;
                                  },
                                );
                              },
                            ),
                          ),
                          obscureText: visibilityPassword,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _ConfirmPasswordController,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                              color: Colors.black87),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outlined),
                            labelText: 'Confirm New Password',
                            labelStyle: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3),
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: _visibilityPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _visibilityPassword = !_visibilityPassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _visibilityPassword,
                        ),
                        SizedBox(height: 40),
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
                            onPressed: null,
                            child: Text(
                              "Submit",
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
