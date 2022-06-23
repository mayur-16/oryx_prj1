// To parse this JSON data, do
//
//     final supplier = supplierFromJson(jsonString);

import 'dart:convert';

Supplier supplierFromJson(String str) => Supplier.fromJson(json.decode(str));

String supplierToJson(Supplier data) => json.encode(data.toJson());

class Supplier {
  Supplier({
    required this.recordset,
  });


  List<RecordsetofSupplier> recordset;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    recordset: List<RecordsetofSupplier>.from(json["recordset"].map((x) => RecordsetofSupplier.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}



class RecordsetofSupplier {
  RecordsetofSupplier({
    required this.pcode,
    required this.custName,
    required this.phone1,
    required this.mobile,
  });

  String pcode;
  String custName;
  String phone1;
  String mobile;

  factory RecordsetofSupplier.fromJson(Map<String, dynamic> json) => RecordsetofSupplier(
    pcode: json["PCODE"],
    custName: json["CUST_NAME"],
    phone1: json["PHONE1"],
    mobile: json["MOBILE"],
  );

  Map<String, dynamic> toJson() => {
    "PCODE": pcode,
    "CUST_NAME": custName,
    "PHONE1": phone1,
    "MOBILE": mobile,
  };
}
