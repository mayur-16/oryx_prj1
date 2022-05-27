import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/sublistitems.dart';

class SublistPage extends StatefulWidget {
  const SublistPage({Key? key}) : super(key: key);

  @override
  State<SublistPage> createState() => _SublistPageState();
}

class _SublistPageState extends State<SublistPage> {

  int indexval=Get.arguments;
  List<String> pageitemsnamesval=[];
  @override
  Widget build(BuildContext context) {
    pageitemsnamesval=sublistpageitems.elementAt(indexval).pageitemsnames;

    return Scaffold(
      backgroundColor: Colors.white,

      //backgroundColor: Colors.pinkAccent.shade100,
      appBar: AppBar(
        title: Image.asset("assets/oryx_logo.jpeg",height: 80,width: 120),
        bottom: PreferredSize(child: Text(sublistpageitems.elementAt(indexval).pagetitle,
          style: GoogleFonts.merriweather(color: Colors.blue.shade700,fontSize: 17,fontWeight: FontWeight.bold),
        ), preferredSize: const Size.fromHeight(50)),
        centerTitle: true,
      ),
      body: pageitemsnamesval.isNotEmpty
          ? ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: pageitemsnamesval.length + 2,
          itemBuilder: (context, pos) {
            if (pos == 0 || pos == pageitemsnamesval.length + 1) {
              return const SizedBox(height: 0);
            }
            return InkWell(
              onTap: (){
                Get.toNamed(sublistpageitems.elementAt(indexval).redirectpages.elementAt(pos-1));
              },
              splashColor: Colors.redAccent.shade100,
              overlayColor: MaterialStateProperty.all(Colors.redAccent.shade100),
              child: ListTile(
                //tileColor: Colors.white,
                leading: Text(pageitemsnamesval.elementAt(pos-1),
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                trailing: const Icon(Icons.arrow_right,color: Colors.red,),
              ),
            );
          },
          separatorBuilder: (context, int index) {
            return const Divider(
              height: 18,
              color: Colors.grey,
            );
          })
          : const SizedBox(),
    );
  }
}