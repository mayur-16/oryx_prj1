import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oryx_prj1/models/appdetails.dart';
import 'package:oryx_prj1/pages/login/loginpage.dart';
import 'package:sqflite/sqflite.dart';

class HomeDrawer extends StatelessWidget {
  final Map data;
  const HomeDrawer({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width*0.80,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Expanded(child: Image.asset(AppDetails.logopath)),
                  /*Text(
                    "Profile",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),
                  ),*/
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 100,
                    color: Color(0xff126ea4),
                  )
                ],
              )),
          ListTile(leading: const Text("Emp name:"),title: Text("${data['empname']}"),),
          ListTile(leading: const Text("Cpr no:"),title: Text("${data['cprno']}"),),
          ListTile(leading: const Text("Ph no:"),title: Text("${data['officephoneno']}"),),

          ElevatedButton(onPressed: ()async{

            //get the database path
            String databasePath=await getDatabasesPath();
            String path="$databasePath/usercredentials.db";

            //open the database
            Database database=await openDatabase(path);

            await database.rawUpdate('UPDATE USER SET LOGGEDIN=?',[0]);

            //close database
            database.close();

            //navigate to login page
            Get.off(()=>const LoginPage());
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged Out Successfully!")));

          },
              child: const Text("log Out")),

        ],
      ),
    );
  }
}
