

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oryx_prj1/pages/home/homepage.dart';
import 'package:oryx_prj1/services/apiservice.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/appdetails.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextStyle style1 =
  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  final List<Color> colorizeColors = const [
    Colors.black87,
    Colors.green,
    Colors.orange,
    Colors.teal,
  ];

  final _formKey = GlobalKey<FormState>();
  TextEditingController empnoController = TextEditingController();
  TextEditingController cprnoController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  bool _isObscure = true;
  bool _loading = false;
  bool _empnoInvalid = false, _cprnoInvalid = false;


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: _loading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06),
                  Text(
                    "ORYX ALUMINIUM",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweather(color: const Color(0xff34495E),
                        fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08),

                  Center(
                    child: Image.asset(AppDetails.logopath,height: 80,width: 120),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09),
                  TextFormField(
                    controller: empnoController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
/*                            focusColor: Colors.black87,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),*/
                      border: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      errorText:
                      _empnoInvalid ? "Emp no invalid" : null,
                      labelText: "Emp no",
                      hintText: "Enter Emp no",
                      prefixIcon: const Icon(Icons.account_box),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter emp no";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05),
                  TextFormField(
                    controller: cprnoController,
                    obscureText: _isObscure,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (term) {
                      loginValidation();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      labelText: "Cpr no",
                      hintText: "Enter Cpr no",
                      prefixIcon: const Icon(Icons.lock),
                      errorText:
                      _cprnoInvalid ? "Cpr no invalid" : null,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter Cprno";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: loginValidation,
                          child: const Text("Login"))),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
            ),
          )),
    );
  }

  void loginValidation() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        //clear all error messages
        _empnoInvalid = false;
        _cprnoInvalid = false;
        //_loading=true;
      });


      passwordFocus.unfocus();
      getLoginDetailsfromApi();
    } else {
      return;
    }
  }

  void getLoginDetailsfromApi() async{
    String enteredMembernoval=empnoController.text.trim();
    String enteredCprnoval=cprnoController.text.trim();


    MyApi.getUserdetailsforLogin(empno: enteredMembernoval).then((value){

      List<dynamic> response = (jsonDecode(value.body))['recordset'];
      if(response.isNotEmpty)
      {


        String responseEmpno=response[0]['EMPNO'];
        String responseEmpname=response[0]['EMPNAME'];
        String responseContractorId=response[0]['CONTRACTOR_ID'].toString();
        String responseDesignationId=response[0]['DESIGNATION_ID'].toString();
        String responseShiftId=response[0]['SHIFT_ID'].toString();
        String responseDOB=response[0]['DOB'].toString();
        String responsephonenoOffice=response[0]['L_TEL'].toString();
        String responseCprno=response[0]['CPR_NO'];
        String responseAttCardno=response[0]['ATT_CARD_NO'];
        String responseUserid=response[0]['USERID'];



        Map<String,String> logindata={
          'empno':responseEmpno,
          'empname':responseEmpname,
          'contractorid':responseContractorId,
          'designationid':responseDesignationId,
          'shiftid':responseShiftId,
          'dob':responseDOB,
          'officephoneno':responsephonenoOffice,
          'cprno':responseCprno,
          'attcardno':responseAttCardno,
          'userid':responseUserid,
        };

        if(responseCprno==enteredCprnoval)
        {
          savedatatosqlflite(details: logindata);

          Get.off(()=>HomePage(logindata: logindata));


          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Logged In as $responseEmpname")));
        }
        else
        {
          setState(() {
            _loading=false;
            _cprnoInvalid=true;
          });
          return;
        }
      }
      else
      {
        setState(() {
          _empnoInvalid=true;
          _loading=false;
        });
        return;
      }


    }).onError((error, stackTrace){

      log(error.toString(),name: "error");

      setState((){});

      if(error==TimeoutException)
        {
          Get.snackbar("No Internet", "Please turn on Internet");
          return;
        }

    });

  }


  void savedatatosqlflite({required Map<String,String> details}) async{

    //get database path
    String databasePath=await getDatabasesPath();
    String path="$databasePath/usercredentials.db";

    //open the database
    Database database=await openDatabase(path);
    
    await database.rawDelete('DELETE FROM USER;');

    //insert user details to USER TABLE
    await database.transaction((txn) async{
      int id=await txn.rawInsert(

          'INSERT INTO USER(empno ,empname ,contractorid ,designationid ,shiftid ,dob  ,officephoneno ,'
              'cprno,attcardno,userid,loggedin) '
              'VALUES("${details['empno']}","${details['empname']}","${details['contractorid']}","${details['designationid']}",'
              '"${details['shiftid']}","${details['dob']}","${details['officephoneno']}",'
              '"${details['cprno']}","${details['attcardno']}","${details['userid']}",1)'
      );
      log(id.toString());
    });

    //Close the database
    await database.close();
  }

}

//like fontstyles  ---- tangerine,rockSalt,ralewayDots
//best fontstyles -----cabinSketch,londrinaSketch
