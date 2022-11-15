import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:vsing/pages/barcode_screen.dart';

class Ticket_Widget extends StatelessWidget {
  final nama;
  final deskripsi;
  final foto;
  final bc;

  Ticket_Widget(
      {super.key,
      required this.nama,
      required this.deskripsi,
      required this.foto,
      required this.bc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BarcodeScreen(),
          ),
        );
      },
      child: TicketWidget(
        color: Colors.black.withOpacity(0.8),
        width: 350,
        height: 120,
        isCornerRounded: false,
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1 Menu " + nama,
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 0.3),
                ),
                Text(
                  deskripsi,
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 0.3),
                ),
              ],
            ),
            Container(
              height: 80,
              width: 80,
              child: Image.network(
                foto,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
