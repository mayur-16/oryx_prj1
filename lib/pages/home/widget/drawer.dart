import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.80,
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    Text(
                      "Profile",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                      color: Colors.blue,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
