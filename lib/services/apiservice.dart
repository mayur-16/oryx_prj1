import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:oryx_prj1/models/alljobs.dart';
import 'package:oryx_prj1/models/customer.dart';
import 'package:oryx_prj1/models/customer_enqueries.dart';
import 'package:oryx_prj1/models/customer_orders.dart';
import 'package:oryx_prj1/models/customer_payments.dart';
import 'package:oryx_prj1/models/jobdetails.dart';
import 'package:oryx_prj1/models/jobslist.dart';
import 'package:oryx_prj1/models/supplier.dart';
import 'package:oryx_prj1/models/supplierdetails.dart';

import '../models/customer_bills.dart';
import '../models/customerdetails.dart';
import '../models/monthlytimecard.dart';
import '../models/usercredentials.dart';

abstract class MyApi{

  // GET USER DETAILS FOR LOGIN
  static Future<http.Response> getUserdetailsforLogin({required String empno})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/loginusers/$empno"))
        .timeout(const Duration(seconds: 10));

    return response;
  }


  //POST PUNCHED TIME AND DATE
  static Future<void> postPunchedTime(
      {required String premisisid, required bool checktype}) async {
    try {

      DateTime punchedDatetime=DateTime.now();

      String checktime="${punchedDatetime.day}/${punchedDatetime.month}/${punchedDatetime.year}";
      String ctime="${punchedDatetime.hour}:${punchedDatetime.minute}:${punchedDatetime.second}";

      final posttimeresponse = await http.post(
        Uri.parse('http://15.185.46.105:5005/api/employee/punch'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
            "userid":UserCredential.userid,
            "name": UserCredential.empname,
            "badgenumber": UserCredential.attCardno,
            "checktime": checktime,
            "ctime": ctime,
            "shiftid": UserCredential.shiftid,
            "premisisid":premisisid,
            "contractorid":UserCredential.contractorid,
          "checktype":checktype?"OUT":"IN",
        }),
      ).timeout(const Duration(seconds: 8));

      log(posttimeresponse.statusCode.toString(),name: "status code");

      if (posttimeresponse.statusCode == 200) {
        Get.snackbar('Punch', checktype?'Punch out Successful!':'Punch In Successful!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2));
      } else {
        Get.snackbar('Punch', checktype?'Punch out failed!':'Punch In failed!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2));
      }
    } on SocketException catch (_) {
      Get.snackbar('Warning', 'Internet is disabled\nplease turn it On',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.yellow.shade800,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));

    } on TimeoutException catch (_) {

      Get.snackbar('Issues!', 'ORYX server has gone down\nPlease try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));

    } catch (e) {

      log(e.toString(),name: "error");

      Get.snackbar('Issues!', 'Unknown Issue \n Please contact developer.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    }

  }

  //GET TIMECARD REPORT USINIG BADGENUMBER
  static Future<List<Recordsetoftimecard>> gettimecardDetailsfromBadgenum(
      {required String month, required String year, required String badgenum}) async {
    try {
      final response = await http.get(Uri
          .parse(
          'http://15.185.46.105:5005/api/employee/getEmpMonthlyAtt/$month/$year/$badgenum'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Timecard timecard = timecardFromJson(response.body);
        final List<Recordsetoftimecard> recordset = timecard.recordset;
        return recordset;
      }
      else {
        return <Recordsetoftimecard>[];
      }
    }
    on SocketException catch (_) {
      Get.snackbar('Warning', 'Internet is disabled\nplease turn it On',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.yellow.shade800,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));

      return <Recordsetoftimecard>[];
    } on TimeoutException catch (_) {

      Get.snackbar('Issues!', 'Oryx server has gone down\nPlease try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));

      return <Recordsetoftimecard>[];
    } catch (e) {

      log(e.toString(),name: "error");

      /* Get.snackbar('Issues!', 'Unknown Issue \n Please contact developer.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));*/

      return <Recordsetoftimecard>[];
    }

  }


  // GET ALL CUSTOMER DETAILS
  static Future<Customer> getAllCustomerDetails()async{

    String yearnow=DateTime.now().year.toString();
    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getallcustomers/$yearnow"))
        .timeout(const Duration(seconds: 10));

    Customer customer = customerFromJson(response.body);

    return customer;
  }


  // GET FULL CUSTOMER DETAILS FROM PCODE
  static Future<CustomerFullDetails> getFullCustomerDetails({required String pcode})async{

    String yearnow=DateTime.now().year.toString();
    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getcustomerdetails/$pcode/$yearnow"))
        .timeout(const Duration(seconds: 10));

    CustomerFullDetails customerDetails=customerFullDetailsFromJson(response.body);

    return customerDetails;
  }


  // GET ORDERS FROM PCODE
  static Future<CustomerOrders> getCustomerOrders({required String pcode})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getorders/$pcode"))
        .timeout(const Duration(seconds: 10));

    CustomerOrders customerOrders=customerOrdersFromJson(response.body);

    return customerOrders;
  }


  // GET BILLS FROM PCODE
  static Future<CustomerBills> getCustomerBills({required String pcode})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getbills/$pcode"))
        .timeout(const Duration(seconds: 10));

    CustomerBills customerBills=customerBillsFromJson(response.body);

    return customerBills;
  }


  // GET PAYMENTS FROM PCODE
  static Future<CustomerPayments> getCustomerPayments({required String pcode})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getpayments/$pcode"))
        .timeout(const Duration(seconds: 10));

    CustomerPayments customerPayments=customerPaymentsFromJson(response.body);

    return customerPayments;
  }


  // GET ENQUERIES FROM PCODE
  static Future<CustomerEnqueries> getCustomerEnqueries({required String pcode})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getenqueries/$pcode"))
        .timeout(const Duration(seconds: 10));

    CustomerEnqueries customerEnqueries= customerEnqueriesFromJson(response.body);

    return customerEnqueries;
  }


  // GET ALL SUPPLIER DETAILS
  static Future<Supplier> getAllSuppliersDetails()async{

    String yearnow=DateTime.now().year.toString();
    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getAllSuppliers/$yearnow"))
        .timeout(const Duration(seconds: 10));

    Supplier supplier = supplierFromJson(response.body);

    return supplier;
  }


  // GET FULL SUPPLIER DETAILS FROM PCODE
  static Future<SupplierFullDetails> getFullSupplierDetails({required String pcode})async{

    String yearnow=DateTime.now().year.toString();
    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getsupplierdetails/$pcode/$yearnow"))
        .timeout(const Duration(seconds: 10));

    SupplierFullDetails supplierFullDetails=supplierDetailsFromJson(response.body);


    return supplierFullDetails;
  }


  // GET ALL JOBS OF THE YEAR
  static Future<AllJobs> getAlljobsoftheyear()async{

    String yearnow=DateTime.now().year.toString();
    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getallJobs/$yearnow"))
        .timeout(const Duration(seconds: 10));

    AllJobs allJobs=allJobsFromJson(response.body);


    return allJobs;
  }


  // GET LIST OF JOBS FROM PCODE
  static Future<JobsList> getListofjobsofcustomer({required String pcode})async{

    String yearnow=DateTime.now().year.toString();
    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/listofjobsofcustomer/$pcode/$yearnow"))
        .timeout(const Duration(seconds: 10));

    JobsList jobsList=jobsListFromJson(response.body);


    return jobsList;
  }


  // GET JOBS DETAILS FROM JOB NO
  static Future<JobDetails> getjobDetailsfromJobno({required String jobno})async{

    String yearnow=DateTime.now().year.toString();
    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5005/api/getfulljobdetails/$jobno/$yearnow"))
        .timeout(const Duration(seconds: 10));

    JobDetails jobDetails=jobDetailsFromJson(response.body);


    return jobDetails;
  }



}