// To parse this JSON data, do
//
//     final salesOrderDetails = salesOrderDetailsFromJson(jsonString);

import 'dart:convert';

SalesOrderDetails salesOrderDetailsFromJson(String str) => SalesOrderDetails.fromJson(json.decode(str));

String salesOrderDetailsToJson(SalesOrderDetails data) => json.encode(data.toJson());

class SalesOrderDetails {
  SalesOrderDetails({
    required this.recordset,
  });

  List<RecordsetofSalesorderDetails> recordset;


  factory SalesOrderDetails.fromJson(Map<String, dynamic> json) => SalesOrderDetails(
    recordset: List<RecordsetofSalesorderDetails>.from(json["recordset"].map((x) => RecordsetofSalesorderDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofSalesorderDetails {
  RecordsetofSalesorderDetails({
    required this.sono,
    required this.sodate,
    required this.custName,
    required this.add1,
    required this.add2,
    required this.add3,
    required this.phone1,
    required this.jobId,
    required this.jobNo,
    required this.jobName,
    required this.salesman,
    required this.pcode,
    required this.total,
    required this.tax1Per,
    required this.tax1Amt,
    required this.gtotal,
    required this.invoicedAmt,
  });

  String sono;
  DateTime sodate;
  String custName;
  String add1;
  String add2;
  String add3;
  String phone1;
  int jobId;
  String jobNo;
  String jobName;
  String salesman;
  String pcode;
  double total;
  double tax1Per;
  double tax1Amt;
  double gtotal;
  double invoicedAmt;

  factory RecordsetofSalesorderDetails.fromJson(Map<String, dynamic> json) => RecordsetofSalesorderDetails(
    sono: json["SONO"],
    sodate: DateTime.parse(json["SODATE"]),
    custName: json["CUST_NAME"],
    add1: json["ADD1"],
    add2: json["ADD2"],
    add3: json["ADD3"],
    phone1: json["PHONE1"],
    jobId: json["JOB_ID"],
    jobNo: json["JOB_NO"],
    jobName: json["JOB_NAME"],
    salesman: json["SALESMAN"],
    pcode: json["PCODE"],
    total: json["TOTAL"].toDouble(),
    tax1Per: json["TAX_1_PER"].toDouble(),
    tax1Amt: json["TAX_1_AMT"].toDouble(),
    gtotal: json["GTOTAL"].toDouble(),
    invoicedAmt: json["INVOICED_AMT"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "SONO": sono,
    "SODATE": sodate.toIso8601String(),
    "CUST_NAME": custName,
    "ADD1": add1,
    "ADD2": add2,
    "ADD3": add3,
    "PHONE1": phone1,
    "JOB_ID": jobId,
    "JOB_NO": jobNo,
    "JOB_NAME": jobName,
    "SALESMAN": salesman,
    "PCODE": pcode,
    "TOTAL": total,
    "TAX_1_PER": tax1Per,
    "TAX_1_AMT": tax1Amt,
    "GTOTAL": gtotal,
    "INVOICED_AMT": invoicedAmt,
  };
}



