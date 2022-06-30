// To parse this JSON data, do
//
//     final jobExpenseDetails = jobExpenseDetailsFromJson(jsonString);

import 'dart:convert';

JobExpenseDetails jobExpenseDetailsFromJson(String str) => JobExpenseDetails.fromJson(json.decode(str));

String jobExpenseDetailsToJson(JobExpenseDetails data) => json.encode(data.toJson());

class JobExpenseDetails {
  JobExpenseDetails({
    required this.recordset,
  });

  List<RecordsetofJobExpense> recordset;


  factory JobExpenseDetails.fromJson(Map<String, dynamic> json) => JobExpenseDetails(
    recordset: List<RecordsetofJobExpense>.from(json["recordset"].map((x) => RecordsetofJobExpense.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}



class RecordsetofJobExpense {
  RecordsetofJobExpense({
    required this.expDesc,
    required this.itcode,
    required this.itdesc,
    required this.soNo,
    required this.soSubject,
    required this.qty,
    required this.expenseAmt,

  });

  String expDesc;
  String itcode;
  String itdesc;
  String soNo;
  String soSubject;
  int qty;
  double expenseAmt;

  factory RecordsetofJobExpense.fromJson(Map<String, dynamic> json) => RecordsetofJobExpense(
    expDesc: json["EXP_DESC"],
    itcode: json["ITCODE"],
    itdesc: json["ITDESC"],
    soNo: json["SO_NO"],
    soSubject: json["SO_SUBJECT"],
    qty: json["QTY"],
    expenseAmt: json["EXPENSE_AMT"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "EXP_DESC": expDesc,
    "ITCODE": itcode,
    "ITDESC": itdesc,
    "SO_NO": soNo,
    "SO_SUBJECT": soSubject,
    "QTY": qty,
    "EXPENSE_AMT": expenseAmt,
  };
}
