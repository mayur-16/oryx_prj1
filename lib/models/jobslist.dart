// To parse this JSON data, do
//
//     final jobsList = jobsListFromJson(jsonString);

import 'dart:convert';

JobsList jobsListFromJson(String str) => JobsList.fromJson(json.decode(str));

String jobsListToJson(JobsList data) => json.encode(data.toJson());

class JobsList {
  JobsList({
   required this.recordset,

  });

  List<Recordsetofjoblistofcustomer> recordset;


  factory JobsList.fromJson(Map<String, dynamic> json) => JobsList(
    recordset: List<Recordsetofjoblistofcustomer>.from(json["recordset"].map((x) => Recordsetofjoblistofcustomer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class Recordsetofjoblistofcustomer {
  Recordsetofjoblistofcustomer({
    required this.jobname,
    required this.jobno,
    required this.jdate,
    required this.netJobValue,
  });

  String jobname;
  String jobno;
  DateTime jdate;
  int netJobValue;

  factory Recordsetofjoblistofcustomer.fromJson(Map<String, dynamic> json) => Recordsetofjoblistofcustomer(
    jobname: json["JOBNAME"],
    jobno: json['JOBNO'],
    jdate: DateTime.parse(json["JDATE"]),
    netJobValue: json["NET_JOB_VALUE"],
  );

  Map<String, dynamic> toJson() => {
    "JOBNAME": jobname,
    "JOBNO":jobno,
    "JDATE": jdate.toIso8601String(),
    "NET_JOB_VALUE": netJobValue,
  };
}
