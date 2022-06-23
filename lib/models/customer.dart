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
  });

  String pcode;
  String custName;
  String phone1;


  factory RecordsetofCustomer.fromJson(Map<String, dynamic> json) => RecordsetofCustomer(
    pcode: json["PCODE"],
    custName: json["CUST_NAME"],
    phone1: json["PHONE1"],
  );

  Map<String, dynamic> toJson() => {
    "PCODE": pcode,
    "CUST_NAME": custName,
    "PHONE1": phone1,
  };
}




