import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/appdetails.dart';
import 'package:oryx_prj1/models/usercredentials.dart';
import 'package:oryx_prj1/pages/home/widget/body_gridview.dart';
import 'package:oryx_prj1/pages/home/widget/drawer.dart';

class HomePage extends StatefulWidget {

  final Map logindata;
  const HomePage({Key? key,required this.logindata}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    ///insert frequently required data to static model class to avoid initialization in every page

    UserCredential.empno=widget.logindata['empno'];
    UserCredential.empname=widget.logindata['empname'];
    UserCredential.contractorid=widget.logindata['contractorid'];
    UserCredential.designationid=widget.logindata['designationid'];
    UserCredential.shiftid=widget.logindata['shiftid'];
    UserCredential.cprno=widget.logindata['cprno'];
    UserCredential.attCardno=widget.logindata['attcardno'];
    UserCredential.userid=widget.logindata['userid'];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/oryx_logo.jpeg",height:50,width: 120,fit: BoxFit.contain,) ,
        //centerTitle: true,
        //bottom: PreferredSize(child: Image.asset("assets/oryx_logo.jpeg",height: 70,width: 120), preferredSize: Size.fromHeight(70))
      ),
      drawer:  HomeDrawer(data: widget.logindata,),
      body: const BodyWidget(),
    );

  }


}
