// To parse this JSON data, do
//
//     final customerOrders = customerOrdersFromJson(jsonString);

import 'dart:convert';

CustomerOrders customerOrdersFromJson(String str) => CustomerOrders.fromJson(json.decode(str));

String customerOrdersToJson(CustomerOrders data) => json.encode(data.toJson());

class CustomerOrders {
  CustomerOrders({
    required this.recordset,
  });

  List<RecordsetofCustomerOrders> recordset;


  factory CustomerOrders.fromJson(Map<String, dynamic> json) => CustomerOrders(
    recordset: List<RecordsetofCustomerOrders>.from(json["recordset"].map((x) => RecordsetofCustomerOrders.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofCustomerOrders {
  RecordsetofCustomerOrders({
    required this.sono,
    required this.sodate,
    required this.subject,
    required this.total,
  });

  String sono;
  DateTime sodate;
  String subject;
  double total;

  factory RecordsetofCustomerOrders.fromJson(Map<String, dynamic> json) => RecordsetofCustomerOrders(
    sono: json["SONO"],
    sodate: DateTime.parse(json["SODATE"]),
    subject: json["SUBJECT"],
    total: json["TOTAL"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "SONO": sono,
    "SODATE": sodate.toIso8601String(),
    "SUBJECT": subject,
    "TOTAL": total,
  };
}


