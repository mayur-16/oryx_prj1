import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/appdetails.dart';

class HumanResourcePage extends StatefulWidget {
  const HumanResourcePage({Key? key}) : super(key: key);

  @override
  State<HumanResourcePage> createState() => _HumanResourcePageState();
}

class _HumanResourcePageState extends State<HumanResourcePage> {

  List<String> listofsubpagetitles=[
    'Time & Attendence',
    'Wage Sheet',
    'Jobwise Allocation',
    'Loss of Pay',
    'Pay Slip',
    'Loans & Deduction',
    'Apply for Leave',
    'Apply for Document'];

  List<String> listofsubpagesroutes=['/TimeNattendenceHr',
    '/WageSheetHr',
    '/JobwiseallocationHr',
    '/LossofPayHr',
    '/PayslipHr',
    '/LoansNdeductionHr',
    '/ApplyforleaveHr',
    '/ApplyfordocHr'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Image.asset(AppDetails.logopath,fit: BoxFit.fitWidth,height: 35,),
            const Text("Human resource"),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: listofsubpagetitles.length + 2,
          itemBuilder: (context, pos) {
            if (pos == 0 || pos == listofsubpagetitles.length + 1) {
              return const SizedBox(height: 0);
            }
            return InkWell(
              onTap: (){
                Get.toNamed(listofsubpagesroutes.elementAt(pos-1));
              },
              splashColor: Colors.grey.shade800,
              overlayColor: MaterialStateProperty.all(Colors.grey.shade500),
              child: ListTile(
                //tileColor: Colors.white,
                leading: Text(listofsubpagetitles.elementAt(pos-1),
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
          }),

    );
  }
}
