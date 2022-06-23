import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

import 'package:oryx_prj1/pages/home/homepage.dart';
import 'package:oryx_prj1/pages/login/loginpage.dart';
import 'package:oryx_prj1/pages/subpages/crm/billsNpayments.dart';
import 'package:oryx_prj1/pages/subpages/crm/complaintsNenqueries.dart';
import 'package:oryx_prj1/pages/subpages/crm/customerlistpage.dart';
import 'package:oryx_prj1/pages/subpages/fabrication/all_jobslist_page.dart';
import 'package:oryx_prj1/pages/subpages/finance_reports/finance_reports_page.dart';
import 'package:oryx_prj1/pages/subpages/hr/applyfordoc.dart';
import 'package:oryx_prj1/pages/subpages/hr/applyforleavehr.dart';
import 'package:oryx_prj1/pages/subpages/hr/hr_page.dart';
import 'package:oryx_prj1/pages/subpages/kitchen_fittings/kitchen_fittings_page.dart';
import 'package:oryx_prj1/pages/subpages/management_reports/management_reports_page.dart';
import 'package:oryx_prj1/pages/subpages/other_services/other_services_page.dart';
import 'package:oryx_prj1/pages/subpages/powder_coating/powder_coating_page.dart';
import 'package:oryx_prj1/pages/subpages/purchase&supply_chain/supplierlistpage.dart';
import 'package:oryx_prj1/pages/subpages/trading/trading_page.dart';
import 'package:oryx_prj1/pages/subpages/wms/warehouse_and_materials_page.dart';
import 'package:oryx_prj1/pages/subpages/wooden_coating/wooden_coating_page.dart';
import 'package:sqflite/sqflite.dart';

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
import 'pages/subpages/hr/wagesheetpage.dart';

void main(){
  dovalidation();
}


dovalidation() async {
  WidgetsFlutterBinding.ensureInitialized();

  //get database path
  String databasePath=await getDatabasesPath();
  String path="$databasePath/usercredentials.db";


   //deleteDatabase(path);  //for testing purpose

  //check whether database exists
  bool doesdatabaseExists=await databaseExists(path);
  log(doesdatabaseExists.toString(),name: "check");

  //initially assume your not logged In and logindata is empty
  bool isLoggedIn=false;
  List<Map> logindata=[{}];

  if(doesdatabaseExists)
  {
    //open the database
    Database database=await openDatabase(path);
    
    //await database.rawDelete('DELETE FROM USER;');

   //check whether already logged in
    List<Map> loggedIn=await database.rawQuery('SELECT LOGGEDIN FROM USER');

    log("logged in ${loggedIn.toString()}");

    if(loggedIn.isNotEmpty) {

      if (loggedIn.first['loggedin'] == 1) {
        logindata = await database.rawQuery('SELECT * FROM USER');
        isLoggedIn = true;
      }
    }
    database.close();
  }
  else{
    //create new database and create table
    Database database=await openDatabase(path,version: 1,
        onCreate: (Database db,int version)async{
          //when creating the db,create the table
          await db.execute('CREATE TABLE USER(empno TEXT,empname TEXT,contractorid TEXT,designationid TEXT,shiftid TEXT,dob TEXT,'
              'officephoneno TEXT ,cprno TEXT,attcardno TEXT,userid TEXT,loggedin INTEGER)');
        });


    database.close();
  }



  runApp(GetMaterialApp(
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
    home:  isLoggedIn?  HomePage(logindata: logindata.first,):const LoginPage(),
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
      GetPage(name: "/JobwiseallocationHr", page: ()=>JobwiseallocationHr()),
      GetPage(name: "/LossofPayHr", page: ()=>LossofPayHr()),
      GetPage(name: "/PayslipHr", page: ()=>PayslipHr()),
      GetPage(name: "/LoansNdeductionHr", page: ()=>LoansNdeductionHr()),
      GetPage(name: "/ApplyforleaveHr", page: ()=>const ApplyforleaveHr()),
      GetPage(name: "/ApplyfordocHr", page: ()=>const ApplyfordocHr()),
      GetPage(name: "/WageSheetHr", page: ()=>const WageSheetPageHr()),

      GetPage(name: "/CustomerlistCrmpage", page: ()=>const CustomerListPage()),
      GetPage(name: "/Supplierlistpage", page: ()=>const SupplierListPage()),
      GetPage(name: "/Fabricationpage", page: ()=>const AllJobsListPage()),
      GetPage(name: "/Tradingpage", page: ()=>const TradingPage()),
      GetPage(name: "/Warehousepage", page: ()=>const WarehousePage()),
      GetPage(name: "/Humanresourcepage", page: ()=>const HumanResourcePage()),
      GetPage(name: "/Financereportspage", page: ()=>const FinanceReportsPage()),
      GetPage(name: "/Kitchenfittingspage", page: ()=>const KitchenFittingsPage()),
      GetPage(name: "/Woodencoatingpage", page: ()=>const WoodenCoatingPage()),
      GetPage(name: "/Powdercoatingpage", page: ()=>const PowderCoatingPage()),
      GetPage(name: "/Managementreportspage", page: ()=>const ManagementReportsPage()),
      GetPage(name: "/Otherservicespage", page: ()=>const OtherServicesPage()),

    ],
  ));

}