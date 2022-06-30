// To parse this JSON data, do
//
//     final jobIncomeDetails = jobIncomeDetailsFromJson(jsonString);

import 'dart:convert';

JobIncomeDetails jobIncomeDetailsFromJson(String str) => JobIncomeDetails.fromJson(json.decode(str));

String jobIncomeDetailsToJson(JobIncomeDetails data) => json.encode(data.toJson());

class JobIncomeDetails {
  JobIncomeDetails({
    required this.recordset,
  });

  List<RecordsetofJobIncome> recordset;


  factory JobIncomeDetails.fromJson(Map<String, dynamic> json) => JobIncomeDetails(

    recordset: List<RecordsetofJobIncome>.from(json["recordset"].map((x) => RecordsetofJobIncome.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofJobIncome {
  RecordsetofJobIncome({
    required this.accode,
    required this.vcrNo,
    required this.vcrDate,
    required this.dbCd,
    required this.dbDesc,
    required this.remarks,
    required this.soNo,
    required this.jobNo,
    required this.linkCode,
    required this.incomeAmt,
  });

  String accode;
  String vcrNo;
  DateTime vcrDate;
  String dbCd;
  String dbDesc;
  String remarks;
  String soNo;
  String jobNo;
  String linkCode;
  double incomeAmt;

  factory RecordsetofJobIncome.fromJson(Map<String, dynamic> json) => RecordsetofJobIncome(
    accode: json["ACCODE"],
    vcrNo: json["VCR_NO"],
    vcrDate: DateTime.parse(json["VCR_DATE"]),
    dbCd: json["DB_CD"],
    dbDesc: json["DB_DESC"],
    remarks: json["REMARKS"],
    soNo: json["SO_NO"],
    jobNo: json["JOB_NO"],
    linkCode: json["LINK_CODE"],
    incomeAmt: json["INCOME_AMT"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "ACCODE": accode,
    "VCR_NO": vcrNo,
    "VCR_DATE": vcrDate.toIso8601String(),
    "DB_CD": dbCd,
    "DB_DESC": dbDesc,
    "REMARKS": remarks,
    "SO_NO": soNo,
    "JOB_NO": jobNo,
    "LINK_CODE": linkCode,
    "INCOME_AMT": incomeAmt,
  };
}
