import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vsing/widgets/cuppon_list.dart';
import 'package:dotted_line/dotted_line.dart';

class DetailPlace extends StatelessWidget {
  final foto;
  final nama;
  final lokasi;
  const DetailPlace({
    super.key,
    required this.foto,
    required this.nama,
    required this.lokasi,
  });

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
        children: [
          Image(
            image: NetworkImage(foto),
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
              SizedBox(
                height: 600,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 600,
                // color: Colors.white,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            nama.toString(),
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 9, 24, 30),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            lokasi,
                            maxLines: 13,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                    DottedLine(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Promo',
                            maxLines: 13,
                            style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: StreamBuilder(
                              stream: db
                                  .collection('costumer')
                                  .doc(user.email)
                                  .collection('cuppon')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("eror"),
                                  );
                                }

                                // data
                                var data = snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return nama ==
                                            data[index].data()['nama_tempat']
                                        ? Ticket_Widget(
                                            nama: data[index]
                                                .data()['nama_cuppon'],
                                            deskripsi:
                                                data[index].data()['deskripsi'],
                                            foto: data[index].data()['foto'],
                                            bc: data[index].data()['bc'])
                                        : Container(
                                            height: 100,
                                            child: Center(
                                              child: Text(
                                                'Tidak Ada Promo Untuk Saat Ini',
                                                style: GoogleFonts.nunito(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
