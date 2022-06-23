import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        label: "Customer relationship",
    pageroute: "CustomerlistCrmpage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/supplychain.png"),
            color: Colors.white),
        label: "Purchase &\nSupply chain",
        pageroute: "Supplierlistpage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/project.png"),
            color: Colors.white),
        label: "Fabrication projects",
        pageroute: "Fabricationpage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/showroom.png"),
            color: Colors.white),
        label: "Trading",
        pageroute: "Tradingpage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/warehouse.png"),
            color: Colors.white),
        label: "Materials &\nWarehouse",
        pageroute: "Warehousepage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/hr.png"),
            color: Colors.white),
        label: "Human resource",
        pageroute: "Humanresourcepage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/maintenance.png"),
            color: Colors.white),
        label: "Finance Reports",
        pageroute: "Financereportspage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Kitchen fittings",
        pageroute: "Kitchenfittingspage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Wooden coating",
        pageroute: "Woodencoatingpage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Powder coating",
        pageroute: "Powdercoatingpage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Management reports",
        pageroute: "Managementreportspage"),
    HomeIcon(
        icon: const ImageIcon(AssetImage("assets/icons/service.png"),
            color: Colors.white),
        label: "Other services",
        pageroute: "Otherservicespage"),
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
              Get.toNamed(homeIcons[index].pageroute);
              //Get.to(() => const SublistPage(), arguments: index);
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
