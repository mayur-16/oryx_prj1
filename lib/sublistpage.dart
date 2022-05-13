import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: Text(sublistpageitems.elementAt(indexval).pagetitle),
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
              splashColor: Colors.grey.shade800,
              overlayColor: MaterialStateProperty.all(Colors.grey.shade500),
              child: ListTile(
                //tileColor: Colors.white,
                leading: Text(pageitemsnamesval.elementAt(pos-1),
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                trailing: const Icon(Icons.arrow_right),
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