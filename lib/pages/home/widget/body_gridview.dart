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
        icon: const ImageIcon(AssetImage("assets/icons/crm.png"),
            color: Colors.white),
        label: "Customer relationship"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/supplychain.png"),
            color: Colors.white),
        label: "Purchase &\nSupply chain"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/project.png"),
            color: Colors.white),
        label: "Fabrication projects"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/showroom.png"),
            color: Colors.white),
        label: "Trading"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/warehouse.png"),
            color: Colors.white),
        label: "Materials &\nWarehouse"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/hr.png"),
            color: Colors.white),
        label: "Human resource"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/maintenance.png"),
            color: Colors.white),
        label: "Finance Reports"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Kitchen fittings"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Wooden coating"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Powder coating"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Management reports"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Other services"),
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
          color: const Color(0xff126ea4),
          child: InkWell(
            splashColor: Colors.white,
            onTap: () {
              Get.to(() => const SublistPage(), arguments: index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  homeIcons[index].icon,
                  //ImageIcon(Image.asset("assets/icons/crm.png")),
                  Text(
                    homeIcons[index].label,
                    style: const TextStyle(color: Colors.white,fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
