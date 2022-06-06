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
    required this.phone1,
    required this.crBal,
    required this.dbBal,
    required this.mobile,
    required this.opbal,
    required this.glcode,
    required this.status,
  });

  String pcode;
  String custName;
  String phone1;
  double crBal;
  double dbBal;
  String mobile;
  double opbal;
  String glcode;
  String status;

  factory RecordsetofCustomer.fromJson(Map<String, dynamic> json) => RecordsetofCustomer(
    pcode: json["PCODE"],
    custName: json["CUST_NAME"],
    phone1: json["PHONE1"],
    crBal: json["CR_BAL"].toDouble(),
    dbBal: json["DB_BAL"].toDouble(),
    mobile: json["MOBILE"],
    opbal: json["OPBAL"].toDouble(),
    glcode:  json["GLCODE"],
    status: json["STATUS"] ,
  );

  Map<String, dynamic> toJson() => {
    "PCODE": pcode,
    "CUST_NAME": custName,
    "PHONE1": phone1,
    "CR_BAL": crBal,
    "DB_BAL": dbBal,
    "MOBILE": mobile,
    "OPBAL": opbal,
    "GLCODE": glcode,
    "STATUS": status,
  };
}




