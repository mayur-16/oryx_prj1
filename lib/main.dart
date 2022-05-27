import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oryx_prj1/pages/home/homepage.dart';
import 'package:oryx_prj1/pages/subpages/crm/billsNpayments.dart';
import 'package:oryx_prj1/pages/subpages/crm/complaintsNenqueries.dart';
import 'package:oryx_prj1/pages/subpages/hr/applyfordoc.dart';
import 'package:oryx_prj1/pages/subpages/hr/applyforleavehr.dart';
import 'package:oryx_prj1/pages/subpages/hr/wagesheetpage.dart';

import 'pages/subpages/crm/customer_profile.dart';
import 'pages/subpages/crm/ordersNschedules.dart';
import 'pages/subpages/eshowroom/Ecart.dart';
import 'pages/subpages/eshowroom/billsNpayments.dart';
import 'pages/subpages/eshowroom/delivery.dart';
import 'pages/subpages/eshowroom/productprofile.dart';
import 'pages/subpages/hr/jobwiseallocation.dart';
import 'pages/subpages/hr/loansNdeduction.dart';
import 'pages/subpages/hr/lossofpay.dart';
import 'pages/subpages/hr/payslip.dart';
import 'pages/subpages/hr/timeNattendance/timeNattendenceHr.dart';

void main(){
  runApp( GetMaterialApp(
    theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xffe75b5b)),
            )),
        appBarTheme:  AppBarTheme(
          backgroundColor: const Color(0xffFBFCFC),
          titleTextStyle: GoogleFonts.merriweather(color: Colors.blue.shade700,fontSize: 17,fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: Colors.black54),
          actionsIconTheme: const IconThemeData(color: Colors.black54),
          centerTitle: true,
          elevation: 0,
        ),
    ),
    debugShowCheckedModeBanner: false,
    home:  const HomePage(),
    getPages: [
      GetPage(name: "/BillsNpaymentCrm", page: ()=>const BillsNpaymentCrm()),
      GetPage(name: "/ComplaintsNenqueriesCrm", page: ()=>const ComplaintsNenqueriesCrm()),
      GetPage(name: "/CustomerProfileCrm", page: ()=>const CustomerProfileCrm()),
      GetPage(name: "/OrdersNschedulesCrm", page: ()=>const OrdersNschedulesCrm()),
      GetPage(name: "/ProductprofileEshowroom", page: ()=>const ProductprofileEshowroom()),
      GetPage(name: "/EcartPage", page: ()=>const EcartPage()),
      GetPage(name: "/Deliveryeshowroom", page: ()=>const Deliveryeshowroom()),
      GetPage(name: "/BillsNpaymentshowroom", page: ()=>const BillsNpaymentshowroom()),
      GetPage(name: "/TimeNattendenceHr", page: ()=>const TimeNattendenceHr()),
      GetPage(name: "/WageSheetHr", page: ()=>const WageSheetPageHr()),
      GetPage(name: "/JobwiseallocationHr", page: ()=>JobwiseallocationHr()),
      GetPage(name: "/LossofPayHr", page: ()=>LossofPayHr()),
      GetPage(name: "/PayslipHr", page: ()=>PayslipHr()),
      GetPage(name: "/LoansNdeductionHr", page: ()=>LoansNdeductionHr()),
      GetPage(name: "/ApplyforleaveHr", page: ()=>const ApplyforleaveHr()),
      GetPage(name: "/ApplyfordocHr", page: ()=>const ApplyfordocHr()),
    ],
  ));
}