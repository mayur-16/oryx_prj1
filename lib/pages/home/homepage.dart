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
        title:  const Text("ORYX ALUMINIUM"),
        centerTitle: true,
      ),
      drawer: const HomeDrawer(),
      body: const BodyWidget(),
    );

  }
}
