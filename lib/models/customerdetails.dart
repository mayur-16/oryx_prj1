// To parse this JSON data, do
//
//     final customerDetails = customerDetailsFromJson(jsonString);

import 'dart:convert';

CustomerFullDetails customerDetailsFromJson(String str) => CustomerFullDetails.fromJson(json.decode(str));

String customerDetailsToJson(CustomerFullDetails data) => json.encode(data.toJson());

class CustomerFullDetails {
  CustomerFullDetails({
    required this.recordset,
  });

  List<RecordsetofCustomerDetails> recordset;

  factory CustomerFullDetails.fromJson(Map<String, dynamic> json) => CustomerFullDetails(
    recordset: List<RecordsetofCustomerDetails>.from(json["recordset"].map((x) => RecordsetofCustomerDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofCustomerDetails {
  RecordsetofCustomerDetails({
    required this.custName,
    required this.add1,
    required this.add2,
    required this.add3,
    required this.mobile,
    required this.crBal,
    required this.dbBal,
    required this.opbal,
    required this.crLimit,
    required this.glcode,
  });

  String custName;
  String add1;
  String add2;
  String add3;
  String mobile;
  double crBal;
  double dbBal;
  int opbal;
  int crLimit;
  String glcode;

  factory RecordsetofCustomerDetails.fromJson(Map<String, dynamic> json) => RecordsetofCustomerDetails(
    custName: json["CUST_NAME"],
    add1: json["ADD1"],
    add2: json["ADD2"],
    add3: json["ADD3"],
    mobile: json["MOBILE"],
    crBal: json["CR_BAL"].toDouble(),
    dbBal: json["DB_BAL"].toDouble(),
    opbal: json["OPBAL"],
    crLimit: json["CR_LIMIT"],
    glcode: json["GLCODE"],
  );

  Map<String, dynamic> toJson() => {
    "CUST_NAME": custName,
    "ADD1": add1,
    "ADD2": add2,
    "ADD3": add3,
    "MOBILE": mobile,
    "CR_BAL": crBal,
    "DB_BAL": dbBal,
    "OPBAL": opbal,
    "CR_LIMIT": crLimit,
    "GLCODE": glcode,
  };
}
