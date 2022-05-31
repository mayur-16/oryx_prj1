import 'dart:io';

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:oryx_prj1/models/usercredentials.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/monthlytimecard.dart';
import '../../../services/PdfService.dart';
import '../../../services/apiservice.dart';

class WageSheetPageHr extends StatefulWidget {
  const WageSheetPageHr({Key? key}) : super(key: key);

  @override
  State<WageSheetPageHr> createState() => _WageSheetPageHrState();
}

class _WageSheetPageHrState extends State<WageSheetPageHr> {
  late PDFDocument pdfDocument;
  bool pdfgenerationSuccessful = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wage Sheet"),
        centerTitle: true,
      ),
      body: pdfgenerationSuccessful
          ? PDFViewer(document: pdfDocument)
          :  Center(child: ElevatedButton(onPressed: _selectDate, child: const Text("Show Report"), )),

    );
  }

  Future<void> _selectDate() async {

    ///delay the date picker dialog.. to

    DateTime currentdate = DateTime.now();

    final DateTime? pickedDate = await showMonthPicker(
      context: context,
      initialDate: currentdate,
      lastDate: currentdate,
    );
    if (pickedDate != null && pickedDate != currentdate) {
      String month = pickedDate.month.toString();
      String year = pickedDate.year.toString();
      List<String> monthname = [
        'JAN',
        'FEB',
        'MARCH',
        'APRIL',
        'MAY',
        'JUNE',
        'JULY',
        'AUG',
        'SEP',
        'OCT',
        'NOV',
        'DEC'
      ];
      print('$month $year ');
      _timecardReportFunction(
          month: month,
          year: year,
          selectedmonthname: monthname[(pickedDate.month) - 1]);
    }
  }

  void _timecardReportFunction(
      {required String month,
      required String year,
      required String selectedmonthname}) async {

    //GET TIMECARD DETAILS USING BADGENUM
    MyApi.gettimecardDetailsfromBadgenum(
            month: month, year: year, badgenum: UserCredential.attCardno)
        .then((values) async {
      List<Recordsetoftimecard> listofTimecardDetails = values;
      

      ///write pdf document
      pw.Document pdf = MyPdf().writeTimecardPdf(
          timecarddatalist: listofTimecardDetails,
          empname: UserCredential.empname,
          badgenumber: UserCredential.empno,
          selectedmonthName: selectedmonthname,
          selectedYear: year);

      ///save generated pdf document
      await MyPdf().savePdf(savePdfAs: 'wagesheet.pdf', sourcefile: pdf);

      ///get saved file
      File savedfile = await MyPdf().getsavedPdfFile(savedAs: 'wagesheet.pdf');

      ///assign to global variable pdfdocument
      pdfDocument = await PDFDocument.fromFile(savedfile);

      ///rebuild to start viewing pdf
      setState((){pdfgenerationSuccessful=true;});
    });
  }
}
