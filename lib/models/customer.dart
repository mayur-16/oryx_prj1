// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    required this.recordset,
  });

  List<RecordsetofCustomer> recordset;


  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    recordset: List<RecordsetofCustomer>.from(json["recordset"].map((x) => RecordsetofCustomer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofCustomer {
  RecordsetofCustomer({
    required this.pcode,
    required this.custName,
    required this.add1,
    required this.add2,
    required this.add3,
    required this.phone1,
    required this.email,
    required this.crBal,
    required this.dbBal,
    required this.contact,
    required this.mobile,
    required this.opbal,
    required this.glcode,
    required this.status,
    required this.crLimit,
  });

  String pcode;
  String custName;
  String add1;
  String add2;
  String add3;
  String phone1;
  String email;
  double crBal;
  double dbBal;
  String contact;
  String mobile;
  double opbal;
  String glcode;
  String status;
  int crLimit;

  factory RecordsetofCustomer.fromJson(Map<String, dynamic> json) => RecordsetofCustomer(
    pcode: json["PCODE"],
    custName: json["CUST_NAME"],
    add1: json["ADD1"],
    add2: json["ADD2"],
    add3: json["ADD3"],
    phone1: json["PHONE1"],
    email: json["EMAIL"],
    crBal: json["CR_BAL"].toDouble(),
    dbBal: json["DB_BAL"].toDouble(),
    contact: json["CONTACT"],
    mobile: json["MOBILE"],
    opbal: json["OPBAL"].toDouble(),
    glcode:  json["GLCODE"],
    status: json["STATUS"] ,
    crLimit: json["CR_LIMIT"],
  );

  Map<String, dynamic> toJson() => {
    "PCODE": pcode,
    "CUST_NAME": custName,
    "ADD1": add1,
    "ADD2": add2,
    "ADD3": add3,
    "PHONE1": phone1,
    "EMAIL": email,
    "CR_BAL": crBal,
    "DB_BAL": dbBal,
    "CONTACT": contact,
    "MOBILE": mobile,
    "OPBAL": opbal,
    "GLCODE": glcode,
    "STATUS": status,
    "CR_LIMIT": crLimit,
  };
}




