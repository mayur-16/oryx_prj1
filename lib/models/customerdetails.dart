// To parse this JSON data, do
//
//     final customerFullDetails = customerFullDetailsFromJson(jsonString);

import 'dart:convert';

CustomerFullDetails customerFullDetailsFromJson(String str) => CustomerFullDetails.fromJson(json.decode(str));

String customerFullDetailsToJson(CustomerFullDetails data) => json.encode(data.toJson());

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
    required this.pobox,
    required this.phone1,
    required this.phone2,
    required this.fax1,
    required this.fax2,
    required this.email,
    required this.contact,
    required this.tax1No,
    required this.glcode,
    required this.creditperiod,
    required this.crLimit,
    required this.opbal,
    required this.remarks,
    required this.reportEndDate,
    required this.m30Days,
    required this.m60Days,
    required this.m90Days,
    required this.m120Days,
    required this.m180Days,
    required this.m365Days,
    required this.above365Days,
    required this.invBalance,
    required this.unallocBalance,
    required this.netBalance,
  });

  String custName;
  String add1;
  String add2;
  String add3;
  String pobox;
  String phone1;
  String phone2;
  String fax1;
  String fax2;
  String email;
  String contact;
  String tax1No;
  String glcode;
  int creditperiod;
  int crLimit;
  double opbal;
  String remarks;
  String reportEndDate;
  int m30Days;
  int m60Days;
  int m90Days;
  int m120Days;
  int m180Days;
  int m365Days;
  double above365Days;
  double invBalance;
  int unallocBalance;
  double netBalance;

  factory RecordsetofCustomerDetails.fromJson(Map<String, dynamic> json) => RecordsetofCustomerDetails(
    custName: json["CUST_NAME"],
    add1: json["ADD1"],
    add2: json["ADD2"],
    add3: json["ADD3"],
    pobox: json["POBOX"],
    phone1: json["PHONE1"],
    phone2: json["PHONE2"],
    fax1: json["FAX1"],
    fax2: json["FAX2"],
    email: json["EMAIL"],
    contact: json["CONTACT"],
    tax1No: json["TAX_1_NO"],
    glcode: json["GLCODE"],
    creditperiod: json["CREDITPERIOD"],
    crLimit: json["CR_LIMIT"],
    opbal: json["OPBAL"].toDouble(),
    remarks: json["REMARKS"],
    reportEndDate: json["REPORT_END_DATE"],
    m30Days: json["M_30_DAYS"],
    m60Days: json["M_60_DAYS"],
    m90Days: json["M_90_DAYS"],
    m120Days: json["M_120_DAYS"],
    m180Days: json["M_180_DAYS"],
    m365Days: json["M_365_DAYS"],
    above365Days: json["ABOVE_365_DAYS"].toDouble(),
    invBalance: json["INV_BALANCE"].toDouble(),
    unallocBalance: json["UNALLOC_BALANCE"],
    netBalance: json["NET_BALANCE"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "CUST_NAME": custName,
    "ADD1": add1,
    "ADD2": add2,
    "ADD3": add3,
    "POBOX": pobox,
    "PHONE1": phone1,
    "PHONE2": phone2,
    "FAX1": fax1,
    "FAX2": fax2,
    "EMAIL": email,
    "CONTACT": contact,
    "TAX_1_NO": tax1No,
    "GLCODE": glcode,
    "CREDITPERIOD": creditperiod,
    "CR_LIMIT": crLimit,
    "OPBAL": opbal,
    "REMARKS": remarks,
    "REPORT_END_DATE": reportEndDate,
    "M_30_DAYS": m30Days,
    "M_60_DAYS": m60Days,
    "M_90_DAYS": m90Days,
    "M_120_DAYS": m120Days,
    "M_180_DAYS": m180Days,
    "M_365_DAYS": m365Days,
    "ABOVE_365_DAYS": above365Days,
    "INV_BALANCE": invBalance,
    "UNALLOC_BALANCE": unallocBalance,
    "NET_BALANCE": netBalance,
  };
}
