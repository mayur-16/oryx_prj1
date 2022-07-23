// To parse this JSON data, do
//
//     final allDepartments = allDepartmentsFromJson(jsonString);

import 'dart:convert';

AllDepartments allDepartmentsFromJson(String str) => AllDepartments.fromJson(json.decode(str));

String allDepartmentsToJson(AllDepartments data) => json.encode(data.toJson());

class AllDepartments {
  AllDepartments({
    required this.recordset,
  });

  List<RecordsetofAllDepartments> recordset;


  factory AllDepartments.fromJson(Map<String, dynamic> json) => AllDepartments(
    recordset: List<RecordsetofAllDepartments>.from(json["recordset"].map((x) => RecordsetofAllDepartments.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofAllDepartments {
  RecordsetofAllDepartments({
   required this.deptId,
    required  this.deptName,
  });

  int deptId;
  String deptName;

  factory RecordsetofAllDepartments.fromJson(Map<String, dynamic> json) => RecordsetofAllDepartments(
    deptId: json["DEPT_ID"],
    deptName: json["DEPT_NAME"],
  );

  Map<String, dynamic> toJson() => {
    "DEPT_ID": deptId,
    "DEPT_NAME": deptName,
  };
}
