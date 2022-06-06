import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:oryx_prj1/models/customer.dart';

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

    CustomerFullDetails customerDetails=customerDetailsFromJson(response.body);

    return customerDetails;
  }


}