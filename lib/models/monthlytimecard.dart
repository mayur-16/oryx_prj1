// To parse this JSON data, do
//
//     final timecard = timecardFromJson(jsonString);

import 'dart:convert';

Timecard timecardFromJson(String str) => Timecard.fromJson(json.decode(str));

String timecardToJson(Timecard data) => json.encode(data.toJson());

class Timecard {
  Timecard({
    required this.recordset,
  });

  List<Recordsetoftimecard> recordset;


  factory Timecard.fromJson(Map<String, dynamic> json) => Timecard(
    recordset: List<Recordsetoftimecard>.from(json["recordset"].map((x) => Recordsetoftimecard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class Recordsetoftimecard {
  Recordsetoftimecard({
    required this.userid,
    required this.name,
    required this.checktime,
    required this.badgenumber,
    required this.moringin,
    required this.moringout,
    required this.afterin,
    required this.afterout,
    required this.checktype,
    required this.updatemin,
    required this.updatemout,
    required this.updateain,
    required this.updateaout,
    required this.remarks,
    required this.deviceType,
    required this.shiftId,
    required this.contractorId,
    required this.premisisid,
    required this.updated,
  });

  String userid;
  String name;
  String checktime;
  String badgenumber;
  String moringin;
  String moringout;
  String afterin;
  String afterout;
  String checktype;
  String updatemin;
  String updatemout;
  String updateain;
  String updateaout;
  String remarks;
  String deviceType;
  int shiftId;
  int contractorId;
  String premisisid;
  int updated;

  factory Recordsetoftimecard.fromJson(Map<String, dynamic> json) => Recordsetoftimecard(
    userid: json["USERID"],
    name: json["NAME"],
    checktime: json["CHECKTIME"],
    badgenumber: json["BADGENUMBER"],
    moringin: json["MORINGIN"],
    moringout: json["MORINGOUT"],
    afterin: json["AFTERIN"],
    afterout: json["AFTEROUT"],
    checktype: json["CHECKTYPE"],
    updatemin: json["UPDATEMIN"],
    updatemout: json["UPDATEMOUT"],
    updateain: json["UPDATEAIN"],
    updateaout: json["UPDATEAOUT"],
    remarks: json["REMARKS"],
    deviceType: json["DEVICE_TYPE"],
    shiftId: json["SHIFT_ID"],
    contractorId: json["CONTRACTOR_ID"],
    premisisid: json["PREMISISID"],
    updated: json["UPDATED"],
  );

  Map<String, dynamic> toJson() => {
    "USERID": userid,
    "NAME": name,
    "CHECKTIME": checktime,
    "BADGENUMBER": badgenumber,
    "MORINGIN": moringin,
    "MORINGOUT": moringout,
    "AFTERIN": afterin,
    "AFTEROUT": afterout,
    "CHECKTYPE": checktype,
    "UPDATEMIN": updatemin,
    "UPDATEMOUT": updatemout,
    "UPDATEAIN": updateain,
    "UPDATEAOUT": updateaout,
    "REMARKS": remarks,
    "DEVICE_TYPE": deviceType,
    "SHIFT_ID": shiftId,
    "CONTRACTOR_ID": contractorId,
    "PREMISISID": premisisid,
    "UPDATED": updated,
  };
}

