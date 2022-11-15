import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vsing/auth/main_page.dart';
import 'package:vsing/pages/homepage.dart';
import 'package:vsing/pages/login_screen.dart';
import 'package:vsing/pages/reset_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "Settings",
          style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(255, 223, 220, 220),
                ),
                height: 100,
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset("assets/images/profile.png",
                          fit: BoxFit.cover, height: 60, width: 60),
                      radius: 40,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.email!,
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.7,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.blue, width: 1.0),
                            ),
                          ),
                          child: Text(
                            "Edit Account",
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.7,
                              // decoration: TextDecoration.underline,
                              // decorationThickness: 4,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ResetScreen(),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    child: Image.asset("assets/images/lock.png",
                        fit: BoxFit.cover, height: 18, width: 18),
                    backgroundColor: Color(0XFF3351DB),
                    radius: 18,
                  ),
                  title: Text(
                    'Change Password',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black87,
                    size: 14,
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Image.asset("assets/images/notifications.png",
                        fit: BoxFit.cover, height: 20, width: 20),
                    backgroundColor: Color(0XFFE29350),
                    radius: 18,
                    // backgroundImage: AssetImage("assets/images/locked.png"),
                  ),
                  title: Text(
                    'Notifications',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black87,
                    size: 14,
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Image.asset("assets/images/faq.png",
                        fit: BoxFit.cover, height: 17, width: 17),
                    backgroundColor: Color(0XFFAE69CF),
                    radius: 18,
                    // backgroundImage: AssetImage("assets/images/locked.png"),
                  ),
                  title: Text(
                    'FAQ',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black87,
                    size: 14,
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Image.asset("assets/images/contact.png",
                        fit: BoxFit.cover, height: 18, width: 18),
                    backgroundColor: Color(0XFF4FA57F),
                    radius: 18,
                  ),
                  title: Text(
                    'Contact Us',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black87,
                    size: 14,
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              height: 220,
                              width: 200,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/logout_alert.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Apakah yakin ingin keluar ?",
                                      style: GoogleFonts.nunito(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.4,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(
                                                  255, 238, 238, 241)),
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(vertical: 5),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Tidak",
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                        color: Color(0xff3865FF),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff3865FF)),
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(vertical: 5),
                                      ),
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      GoogleSignIn().signOut();

                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return mainPage();
                                      }), (r) {
                                        return false;
                                      });
                                      //   // _googleSignIn. signOut();
                                    },
                                    child: Text(
                                      "Ya",
                                      style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        });
                  },
                  leading: CircleAvatar(
                    child: Image.asset("assets/images/logout.png",
                        fit: BoxFit.cover, height: 20, width: 20),
                    backgroundColor: Color(0XFFEA7D69),
                    radius: 18,
                  ),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black87,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
