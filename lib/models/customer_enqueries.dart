// To parse this JSON data, do
//
//     final customerEnqueries = customerEnqueriesFromJson(jsonString);

import 'dart:convert';

CustomerEnqueries customerEnqueriesFromJson(String str) => CustomerEnqueries.fromJson(json.decode(str));

String customerEnqueriesToJson(CustomerEnqueries data) => json.encode(data.toJson());

class CustomerEnqueries {
  CustomerEnqueries({
    required this.recordset,
  });

  List<RecordsetofCustomerEnquiries> recordset;


  factory CustomerEnqueries.fromJson(Map<String, dynamic> json) => CustomerEnqueries(
    recordset: List<RecordsetofCustomerEnquiries>.from(json["recordset"].map((x) => RecordsetofCustomerEnquiries.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofCustomerEnquiries {
  RecordsetofCustomerEnquiries({
    required this.caseno,
    required this.casetype,
    required this.casedescription,
  });

  String caseno;
  String casetype;
  String casedescription;

  factory RecordsetofCustomerEnquiries.fromJson(Map<String, dynamic> json) => RecordsetofCustomerEnquiries(
    caseno: json["CASE_NO"],
    casetype: json["CASE_TYPE"],
    casedescription: json["CASE_DESCRIPTION"],
  );

  Map<String, dynamic> toJson() => {
    "CASE_NO": caseno,
    "CASE_TYPE": casetype,
    "CASE_DESCRIPTION": casedescription,
  };
}








