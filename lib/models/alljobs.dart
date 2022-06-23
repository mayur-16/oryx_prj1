// To parse this JSON data, do
//
//     final allJobs = allJobsFromJson(jsonString);

import 'dart:convert';

AllJobs allJobsFromJson(String str) => AllJobs.fromJson(json.decode(str));

String allJobsToJson(AllJobs data) => json.encode(data.toJson());

class AllJobs {
  AllJobs({
    required this.recordset,
  });

  List<RecordsetofAllJobs> recordset;

  factory AllJobs.fromJson(Map<String, dynamic> json) => AllJobs(
    recordset: List<RecordsetofAllJobs>.from(json["recordset"].map((x) => RecordsetofAllJobs.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}



class RecordsetofAllJobs {
  RecordsetofAllJobs({
    required this.jobname,
    required this.jobno,
    required this.jdate,
    required this.netJobValue,
    required this.salesman,
  });

  String jobname;
  String jobno;
  DateTime jdate;
  double netJobValue;
  String salesman;

  factory RecordsetofAllJobs.fromJson(Map<String, dynamic> json) => RecordsetofAllJobs(
    jobname: json["JOBNAME"],
    jobno: json["JOBNO"],
    jdate: DateTime.parse(json["JDATE"]),
    netJobValue: json["NET_JOB_VALUE"].toDouble(),
    salesman: json["SALESMAN"],
  );

  Map<String, dynamic> toJson() => {
    "JOBNAME": jobname,
    "JOBNO":jobno,
    "JDATE": jdate.toIso8601String(),
    "NET_JOB_VALUE": netJobValue,
    "SALESMAN": salesman,
  };
}


