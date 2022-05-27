import 'package:flutter/material.dart';
import 'package:oryx_prj1/pages/home/widget/body_gridview.dart';
import 'package:oryx_prj1/pages/home/widget/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/oryx_logo.jpeg",height:50,width: 120,fit: BoxFit.contain,) ,
        //centerTitle: true,
        //bottom: PreferredSize(child: Image.asset("assets/oryx_logo.jpeg",height: 70,width: 120), preferredSize: Size.fromHeight(70))
      ),
      drawer: const HomeDrawer(),
      body: const BodyWidget(),
    );

  }
}
