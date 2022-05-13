import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oryx_prj1/sublistpage.dart';

import '../podos/homeicon.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  List<HomeIcon> homeIcons = [
  HomeIcon(
  icon: ImageIcon(const AssetImage("assets/icons/crm.png"),
  color: Colors.pinkAccent.shade400),
  label: "CRM"),
  HomeIcon(
  icon: ImageIcon(const AssetImage("assets/icons/supplychain.png"),
  color: Colors.green.shade900),
  label: "SUPPLY\nCHAIN"),
  HomeIcon(
  icon: ImageIcon(const AssetImage("assets/icons/project.png"),
  color: Colors.blue.shade900),
  label: "PROJECTS"),
  HomeIcon(
  icon: ImageIcon(const AssetImage("assets/icons/showroom.png"),
  color: Colors.amber.shade900),
  label: "E\nSHOWROOM"),
  HomeIcon(
  icon: ImageIcon(const AssetImage("assets/icons/warehouse.png"),
  color: Colors.red.shade900),
  label: "WMS"),
  HomeIcon(
  icon: ImageIcon(const AssetImage("assets/icons/hr.png"),
  color: Colors.teal.shade700),
  label: "HR"),
  HomeIcon(
  icon: ImageIcon(const AssetImage("assets/icons/maintenance.png"),
  color: Colors.deepPurple.shade400),
  label: "MMP"),
  HomeIcon(
  icon: ImageIcon(const AssetImage("assets/icons/service.png"),
  color: Colors.brown.shade400),
  label: "SMC"),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
    physics: const BouncingScrollPhysics(),
    crossAxisCount: 3,
    mainAxisSpacing: 8,
    padding: const EdgeInsets.all(5),
    children: List.generate(homeIcons.length, (index) {
    return Card(
    elevation: 2,
    color: const Color(0xff1aa6f6),
    child: InkWell(
    splashColor: Colors.white60,
    onTap: () {
Get.to(()=>const SublistPage(),arguments: index);
    },
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    homeIcons[index].icon,
    //ImageIcon(Image.asset("assets/icons/crm.png")),
    Text(homeIcons[index].label,style: const TextStyle(color: Colors.white),),
    ],
    ),
    ),
    );
    }),
    );
  }
}
