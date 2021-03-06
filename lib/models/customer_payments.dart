// To parse this JSON data, do
//
//     final customerPayments = customerPaymentsFromJson(jsonString);

import 'dart:convert';

CustomerPayments customerPaymentsFromJson(String str) => CustomerPayments.fromJson(json.decode(str));

String customerPaymentsToJson(CustomerPayments data) => json.encode(data.toJson());

class CustomerPayments {
  CustomerPayments({
    required this.recordset,
  });

  List<RecordsetofCustomerPayments> recordset;

  factory CustomerPayments.fromJson(Map<String, dynamic> json) => CustomerPayments(
    recordset: List<RecordsetofCustomerPayments>.from(json["recordset"].map((x) => RecordsetofCustomerPayments.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofCustomerPayments {
  RecordsetofCustomerPayments({
    required this.refno,
    required this.refdt,
    required this.refamount,
    required this.lpono,
    required this.description,
  });

  String refno;
  DateTime refdt;
  double refamount;
  String lpono;
  String description;

  factory RecordsetofCustomerPayments.fromJson(Map<String, dynamic> json) => RecordsetofCustomerPayments(
    refno: json["REFNO"],
    refdt: DateTime.parse(json["REFDT"]),
    refamount: json["REFAMOUNT"].toDouble(),
    lpono: json["LPO_NO"],
    description:json["DESCRIPTION"],
  );

  Map<String, dynamic> toJson() => {
    "REFNO": refno,
    "REFDT": refdt.toIso8601String(),
    "REFAMOUNT": refamount,
    "LPO_NO": lpono,
    "DESCRIPTION": description,
  };
}

