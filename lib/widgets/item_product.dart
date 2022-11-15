import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class item_card extends StatelessWidget {
  final foto;
  final nama;
  final deskripsi;
  const item_card(
      {super.key,
      required this.nama,
      required this.deskripsi,
      required this.foto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                foto,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  deskripsi,
                  // overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                      fontSize: 12, fontWeight: FontWeight.w400),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
