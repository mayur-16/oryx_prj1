// To parse this JSON data, do
//
//     final jobDetails = jobDetailsFromJson(jsonString);

import 'dart:convert';

JobDetails jobDetailsFromJson(String str) => JobDetails.fromJson(json.decode(str));

String jobDetailsToJson(JobDetails data) => json.encode(data.toJson());

class JobDetails {
  JobDetails({
    required this.recordset,
  });

  List<RecordsetofJobdetails> recordset;

  factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
    recordset: List<RecordsetofJobdetails>.from(json["recordset"].map((x) => RecordsetofJobdetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofJobdetails {
  RecordsetofJobdetails({
    required this.jobno,
    required this.jobname,
    required this.jdate,
    required this.jobtype,
    required this.status,
    required this.custCode,
    required this.title,
    required this.custName,
    required this.custPhone1,
    required this.glcode,
    required this.glName,
    required this.deptName,
    required this.salesman,
    required this.salesmanPhone1,
    required this.salesmanEmailId,
    required this.initialJobValue,
    required this.netJobValue,
    required this.estimatedValue,
  });

  String jobno;
  String jobname;
  DateTime jdate;
  String jobtype;
  String status;
  String custCode;
  String title;
  String custName;
  String custPhone1;
  String glcode;
  String glName;
  String deptName;
  String salesman;
  String salesmanPhone1;
  String salesmanEmailId;
  double initialJobValue;
  double netJobValue;
  double estimatedValue;

  factory RecordsetofJobdetails.fromJson(Map<String, dynamic> json) => RecordsetofJobdetails(
    jobno: json["JOBNO"],
    jobname: json["JOBNAME"],
    jdate: DateTime.parse(json["JDATE"]),
    jobtype: json["JOBTYPE"],
    status: json["STATUS"],
    custCode: json["CUST_CODE"],
    title: json["TITLE"],
    custName: json["CUST_NAME"],
    custPhone1: json["CUST_PHONE1"],
    glcode: json["GLCODE"],
    glName: json["GL_NAME"],
    deptName: json["DEPT_NAME"],
    salesman: json["SALESMAN"],
    salesmanPhone1: json["SALESMAN_PHONE1"],
    salesmanEmailId: json["SALESMAN_EMAIL_ID"],
    initialJobValue: json["INITIAL_JOB_VALUE"].toDouble(),
    netJobValue: json["NET_JOB_VALUE"].toDouble(),
    estimatedValue: json["ESTIMATED_VALUE"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "JOBNO": jobno,
    "JOBNAME": jobname,
    "JDATE": jdate.toIso8601String(),
    "JOBTYPE": jobtype,
    "STATUS": status,
    "CUST_CODE": custCode,
    "TITLE": title,
    "CUST_NAME": custName,
    "CUST_PHONE1": custPhone1,
    "GLCODE": glcode,
    "GL_NAME": glName,
    "DEPT_NAME": deptName,
    "SALESMAN": salesman,
    "SALESMAN_PHONE1": salesmanPhone1,
    "SALESMAN_EMAIL_ID": salesmanEmailId,
    "INITIAL_JOB_VALUE": initialJobValue,
    "NET_JOB_VALUE": netJobValue,
    "ESTIMATED_VALUE": estimatedValue,
  };
}
