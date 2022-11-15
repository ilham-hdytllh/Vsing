import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vsing/main.dart';
import 'package:vsing/pages/detail_place.dart';
import 'package:vsing/widgets/place.dart';
import 'package:vsing/pages/settings_screen.dart';
import 'package:vsing/widgets/item_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  var db = FirebaseFirestore.instance;

  int _current = 0;

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 15),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey, " + user.email!,
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 14.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Today, 07 November",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 11.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 20),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: StreamBuilder(
                    stream: db.collectionGroup('carrousel').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("eror"),
                        );
                      }

                      //data
                      var data = snapshot.data!.docs;

                      return Stack(
                        children: [
                          CarouselSlider.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index,
                                int pageViewIndex) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    data[index].data()['foto'],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              // enableInfiniteScroll: true,
                              // reverse: false,
                              // enlargeCenterPage: true,
                              viewportFraction: 0.9,
                              initialPage: 0,
                              aspectRatio: 16 / 7,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 1000),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: AnimatedSmoothIndicator(
                                // onDotClicked: (index) {},
                                effect: WormEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.indigo,
                                ),
                                activeIndex: activeIndex,
                                count: data.length),
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Restaurant Places",
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        "See All",
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: StreamBuilder(
                    stream: db.collectionGroup('place').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("eror"),
                        );
                      }

                      //data
                      var data = snapshot.data!.docs;

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return place(
                              nama: data[index].data()['nama_tempat'],
                              lokasi: data[index].data()['lokasi'],
                              foto: data[index].data()['foto']);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "List Product",
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 500,
                              child: StreamBuilder(
                                stream: db
                                    .collectionGroup('foods_list')
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
                                      return item_card(
                                          nama:
                                              data[index].data()['nama_produk'],
                                          deskripsi:
                                              data[index].data()['deskripsi'],
                                          foto: data[index].data()['foto']);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        "See All",
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                        height: 450,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: StreamBuilder(
                          stream: db.collectionGroup('foods_list').snapshots(),
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
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return item_card(
                                    nama: data[index].data()['nama_produk'],
                                    deskripsi: data[index].data()['deskripsi'],
                                    foto: data[index].data()['foto']);
                              },
                            );
                          },
                        )),
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
