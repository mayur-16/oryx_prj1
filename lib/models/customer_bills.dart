// To parse this JSON data, do
//
//     final customerBills = customerBillsFromJson(jsonString);

import 'dart:convert';

CustomerBills customerBillsFromJson(String str) => CustomerBills.fromJson(json.decode(str));

String customerBillsToJson(CustomerBills data) => json.encode(data.toJson());

class CustomerBills {
  CustomerBills({
    required this.recordset,
  });

  List<RecordsetofCustomerBills> recordset;


  factory CustomerBills.fromJson(Map<String, dynamic> json) => CustomerBills(
    recordset: List<RecordsetofCustomerBills>.from(json["recordset"].map((x) => RecordsetofCustomerBills.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),

  };
}

class RecordsetofCustomerBills {
  RecordsetofCustomerBills({
    required this.invNo,
    required this.amount,
    required this.invDate,
  });

  String invNo;
  double amount;
  DateTime invDate;

  factory RecordsetofCustomerBills.fromJson(Map<String, dynamic> json) => RecordsetofCustomerBills(
    invNo: json["INV_NO"],
    amount: json["AMOUNT"].toDouble(),
    invDate: DateTime.parse(json["INV_DATE"]),
  );

  Map<String, dynamic> toJson() => {
    "INV_NO": invNo,
    "AMOUNT": amount,
    "INV_DATE": invDate.toIso8601String(),
  };
}
