// To parse this JSON data, do
//
//     final supplierDetails = supplierDetailsFromJson(jsonString);

import 'dart:convert';

SupplierFullDetails supplierDetailsFromJson(String str) => SupplierFullDetails.fromJson(json.decode(str));

String supplierDetailsToJson(SupplierFullDetails data) => json.encode(data.toJson());

class SupplierFullDetails {
  SupplierFullDetails({
    required this.recordset,
  });

  List<RecordsetofSupplierDetails> recordset;

  factory SupplierFullDetails.fromJson(Map<String, dynamic> json) => SupplierFullDetails(
    recordset: List<RecordsetofSupplierDetails>.from(json["recordset"].map((x) => RecordsetofSupplierDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofSupplierDetails {
  RecordsetofSupplierDetails({
    required this.custName,
    required this.add1,
    required this.add2,
    required this.add3,
    required this.mobile,
    required this.pobox,
    required this.fax1,
    required this.remarks,
    required this.tax1No,
    required this.email,
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
  String pobox;
  String fax1;
  String remarks;
  String tax1No;
  String email;
  double crBal;
  double dbBal;
  double opbal;
  double crLimit;
  String glcode;

  factory RecordsetofSupplierDetails.fromJson(Map<String, dynamic> json) => RecordsetofSupplierDetails(
    custName: json["CUST_NAME"],
    add1: json["ADD1"],
    add2: json["ADD2"],
    add3: json["ADD3"],
    mobile: json["MOBILE"],
    pobox: json["POBOX"],
    fax1: json["FAX1"],
    remarks: json["REMARKS"],
    tax1No: json["TAX_1_NO"],
    email: json["EMAIL"],
    crBal: json["CR_BAL"].toDouble(),
    dbBal: json["DB_BAL"].toDouble(),
    opbal: json["OPBAL"].toDouble(),
    crLimit: json["CR_LIMIT"].toDouble(),
    glcode: json["GLCODE"],
  );

  Map<String, dynamic> toJson() => {
    "CUST_NAME": custName,
    "ADD1": add1,
    "ADD2": add2,
    "ADD3": add3,
    "MOBILE": mobile,
    "POBOX": pobox,
    "FAX1": fax1,
    "REMARKS": remarks,
    "TAX_1_NO": tax1No,
    "EMAIL":email,
    "CR_BAL": crBal,
    "DB_BAL": dbBal,
    "OPBAL": opbal,
    "CR_LIMIT": crLimit,
    "GLCODE": glcode,
  };
}
