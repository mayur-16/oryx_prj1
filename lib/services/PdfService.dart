import 'dart:io';

import 'package:oryx_prj1/models/jobdetails.dart';
import 'package:oryx_prj1/models/jobexpensedetails.dart';
import 'package:oryx_prj1/models/jobincomedetails.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../models/monthlytimecard.dart';

class MyPdf {
  final Document pdf = Document(); //Create new blank document;

  //Different textstyles for pdf
  TextStyle style1bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 23);
  TextStyle style2bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle style3bold = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16
  );

  TextStyle style4bold = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: PdfColors.blue800
  );

  TextStyle style1normal =
  TextStyle(fontWeight: FontWeight.normal, fontSize: 23);
  TextStyle style2normal =
  TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
  TextStyle style3normal =
  TextStyle(fontWeight: FontWeight.normal, fontSize: 18);

  //Total number of holidays to display in timecard
  int totalholidaysinTimecard = 0;
  int totalabsentsinTimecard = 0;
  int totalmedicalleavesinTimecard = 0;
  int totalannualleavesinTimecard = 0;
  int totalabsentwithReasoninTimecard = 0;


  Document writeTimecardPdf(
      {required List<Recordsetoftimecard> timecarddatalist,
        required String empname,
        required String badgenumber,
        required String selectedmonthName,
        required String selectedYear}) {
    List<String> tableHeaders = [
      'SL NO',
      'DATE',
      'MORN\nIN',
      'MORN\nOUT',
      'AFT\nIN',
      'AFT\nOUT',
      'REMARKS'
    ]; //Headers(labels) of table;

    pdf.addPage( //add new Page to blank document
        MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const EdgeInsets.all(30),
          build: (context) {
            return [
              Center(
                child: Text(
                  "ORYX ALUMINIUM INDUSTRY (W.L.L)",
                  textAlign: TextAlign.center,
                  style: style1bold,
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Employee Monthly Wages Sheet\n"
                      "for the Month $selectedmonthName-$selectedYear",
                  textAlign: TextAlign.center,
                  style: style2bold,
                ),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("NAME: $empname",
                    textAlign: TextAlign.left, style: style3bold),
                Text("BADGE NO: $badgenumber",
                    textAlign: TextAlign.right, style: style3bold),
              ]),
              SizedBox(height: 10),
              if (timecarddatalist.isNotEmpty) ...[
                Table(
                  //Add timecard table
                  children: buildTimecardTable(
                      context: context,
                      timecarddatalist: timecarddatalist,
                      tableHeaders: tableHeaders),
                  border: TableBorder.all(),
                  tableWidth: TableWidth.max,
                ),
              ] else
                ...[
                  Container(
                    height: 150,
                    color: PdfColors.green100,
                    child: Center(
                      child: Text("Data of this Month\nNot available.",
                          textAlign: TextAlign.center, style: style1bold),
                    ),
                  ),
                ],
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("$totalholidaysinTimecard\nHOLIDAY",
                    textAlign: TextAlign.center, style: style3bold),
                Text("$totalabsentsinTimecard\nABSENT",
                    textAlign: TextAlign.center, style: style3bold),
                Text("$totalmedicalleavesinTimecard\nMEDICAL\nLEAVE",
                    textAlign: TextAlign.center, style: style3bold),
                Text("$totalannualleavesinTimecard\nANNUAL\nLEAVE",
                    textAlign: TextAlign.center, style: style3bold),
                Text("$totalabsentwithReasoninTimecard\nABSENT\nWITH REASON",
                    textAlign: TextAlign.center, style: style3bold),
              ]),
            ];
          },
        ));

    return pdf;
  }

  Document writeJobincomePdf({required List<RecordsetofJobIncome> incomedata,
    required RecordsetofJobdetails jobdetailsdata,required double totalofJobexpense}) {

    String jobdate =
        "${jobdetailsdata.jdate.day}-${jobdetailsdata.jdate
        .month}-${jobdetailsdata.jdate.year}";

    //Total income amount in jobincome
    double totaljobincome = 0.000;
    for (var element in incomedata) {
      totaljobincome+=element.incomeAmt;
    }

    List<String> tableHeaders = [
      'INV NO',
      'INV DATE',
      'REMARKS',
      'SO NO',
      'INVOICE AMOUNT'
    ]; //Headers(labels) of table;

    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.all(30),
        build: (context) {
          return [
            Center(
              child: Text(
                "ORYX ALUMINIUM INDUSTRY (W.L.L)",
                textAlign: TextAlign.center,
                style: style1bold,
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                "JOB INCOME STATEMENT",
                textAlign: TextAlign.center,
                style: style2bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              jobdetailsdata.jobname,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.red800),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Job no : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.jobno,
                    style: style3normal,
                  ),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Date : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdate,
                    style: style3normal,
                  ),
                ]),
              ),
            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Status : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.status,
                    style: style3normal,
                  ),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Phone number : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.custPhone1.isEmpty
                        ? '---'
                        : jobdetailsdata.custPhone1,
                    style: style3normal,
                  ),
                ]),
              ),

            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Gl code : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.glcode,
                    style: style3normal,
                  ),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Gl name : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.glName,
                    style: style3normal,
                  ),
                ]),
              ),

            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Customer name : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.custName,
                    style: style3normal,
                  ),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Customer code : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.custCode,
                    style: style3normal,
                  ),
                ]),
              ),

            ]),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Department : ",
                  style: style4bold,
                ),
                TextSpan(
                  text: jobdetailsdata.deptName,
                  style: style3normal,
                ),
              ]),
            ),

            SizedBox(height: 15),
            Table(
              //Add timecard table
              children: buildJobIncomeTable(
                  context: context,
                  jobincomedatalist: incomedata,
                  tableHeaders: tableHeaders),
              border: TableBorder.all(),
              tableWidth: TableWidth.max,
            ),
            SizedBox(height: 20),
          ];
        },
        footer: (context) {
          return Table(
              border: TableBorder.all(),
              tableWidth: TableWidth.max,
              children: [
                TableRow(children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    child: Text("Initial Value",
                        style: Theme
                            .of(context)
                            .tableHeader,
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    child: Text("Estimated Value",
                        style: Theme
                            .of(context)
                            .tableHeader,
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    child: Text("Net Value",
                        style: Theme
                            .of(context)
                            .tableHeader,
                        textAlign: TextAlign.center),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      child: Text("Total Income amount",
                          style: Theme
                              .of(context)
                              .tableHeader,
                          textAlign: TextAlign.center)),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      child: Text("Total Expense amount",
                          style: Theme
                              .of(context)
                              .tableHeader,
                          textAlign: TextAlign.center)),
                ]),
                TableRow(
                    decoration: const BoxDecoration(color: PdfColors.red50),
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        child: Text(
                            jobdetailsdata.initialJobValue.toStringAsFixed(3),
                            style: style3bold,
                            textAlign: TextAlign.center),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        child: Text(
                            jobdetailsdata.estimatedValue.toStringAsFixed(3),
                            style: style3bold,
                            textAlign: TextAlign.center),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        child: Text(
                            jobdetailsdata.netJobValue.toStringAsFixed(3),
                            style: style3bold,
                            textAlign: TextAlign.center),
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          child: Text(totaljobincome.toStringAsFixed(3),
                              style: style3bold, textAlign: TextAlign.center)),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          child: Text(totalofJobexpense.toStringAsFixed(3),
                              style: style3bold, textAlign: TextAlign.center)),
                    ]),
              ]);
        }));

    return pdf;
  }

  Document writeJobExpensePdf({required List<RecordsetofJobExpense> expensedata,
    required RecordsetofJobdetails jobdetailsdata,required double totalofJobincome}) {
    String jobdate =
        "${jobdetailsdata.jdate.day}-${jobdetailsdata.jdate
        .month}-${jobdetailsdata.jdate.year}";


    //Total expense amount in jobexpense
    double totaljobexpense = 0.000;
    for (var element in expensedata) {
      totaljobexpense+=element.expenseAmt;
    }

    List<String> tableHeaders = [
      'SO NO',
      'SUBJECT',
      'QTY',
      'EXPENSE AMOUNT'
    ]; //Headers(labels) of table;

    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.all(30),
        build: (context) {
          return [
            Center(
              child: Text(
                "ORYX ALUMINIUM INDUSTRY (W.L.L)",
                textAlign: TextAlign.center,
                style: style1bold,
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                "JOB EXPENSE STATEMENT",
                textAlign: TextAlign.center,
                style: style2bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              jobdetailsdata.jobname,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.red800),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Job no : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.jobno,
                    style: style3normal,
                  ),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Date : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdate,
                    style: style3normal,
                  ),
                ]),
              ),
            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Status : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.status,
                    style: style3normal,
                  ),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Phone number : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.custPhone1.isEmpty
                        ? '---'
                        : jobdetailsdata.custPhone1,
                    style: style3normal,
                  ),
                ]),
              ),

            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Gl code : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.glcode,
                    style: style3normal,
                  ),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Gl name : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.glName,
                    style: style3normal,
                  ),
                ]),
              ),

            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Customer name : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.custName,
                    style: style3normal,
                  ),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Customer code : ",
                    style: style4bold,
                  ),
                  TextSpan(
                    text: jobdetailsdata.custCode,
                    style: style3normal,
                  ),
                ]),
              ),

            ]),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Department : ",
                  style: style4bold,
                ),
                TextSpan(
                  text: jobdetailsdata.deptName,
                  style: style3normal,
                ),
              ]),
            ),
            SizedBox(height: 15),
            Table(
              //Add timecard table
              children: buildJobExpenseTable(
                  context: context,
                  jobexpensedatalist: expensedata,
                  tableHeaders: tableHeaders),
              border: TableBorder.all(),
              tableWidth: TableWidth.max,
            ),

          ];
        }, footer: (context) {
      return Table(
          border: TableBorder.all(),
          tableWidth: TableWidth.max,
          children: [
            TableRow(children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                child: Text("Initial Value",
                    style: Theme
                        .of(context)
                        .tableHeader,
                    textAlign: TextAlign.center),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                child: Text("Estimated Value",
                    style: Theme
                        .of(context)
                        .tableHeader,
                    textAlign: TextAlign.center),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                child: Text("Net Value",
                    style: Theme
                        .of(context)
                        .tableHeader,
                    textAlign: TextAlign.center),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  child: Text("Total Income amount",
                      style: Theme
                          .of(context)
                          .tableHeader,
                      textAlign: TextAlign.center)),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  child: Text("Total Expense amount",
                      style: Theme
                          .of(context)
                          .tableHeader,
                      textAlign: TextAlign.center)),
            ]),
            TableRow(
                decoration: const BoxDecoration(color: PdfColors.red50),
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    child: Text(
                        jobdetailsdata.initialJobValue.toStringAsFixed(3),
                        style: style3bold,
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    child: Text(
                        jobdetailsdata.estimatedValue.toStringAsFixed(3),
                        style: style3bold,
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    child: Text(
                        jobdetailsdata.netJobValue.toStringAsFixed(3),
                        style: style3bold,
                        textAlign: TextAlign.center),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      child: Text(
                          totalofJobincome.toStringAsFixed(3),
                          style: style3bold, textAlign: TextAlign.center)),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      child: Text(
                          totaljobexpense.toStringAsFixed(3),
                          style: style3bold, textAlign: TextAlign.center)),
                ]),
          ]);
    }));

    return pdf;
  }

  Future<void> savePdf(
      {required String savePdfAs, required Document sourcefile}) async {
    Directory directory =
    await getTemporaryDirectory(); //Get the application directory containing path
    File file =
    File("${directory.path}/$savePdfAs"); //Get the path from the directory
    file.writeAsBytesSync(
        await sourcefile.save()); // Save the created pdf in the path
  }

  Future<File> getsavedPdfFile({required String savedAs}) async {
    //Get Application directory containing path
    Directory directory = await getTemporaryDirectory();

    //get the path from directory to create new path
    File file = File("${directory.path}/$savedAs");

    return file;
  }

  List<TableRow> buildTimecardTable({required Context context,
    required List<String> tableHeaders,
    required List<Recordsetoftimecard> timecarddatalist,
    int? totalholidays}) {
    final rows = <TableRow>[];

    final tableRow = <Widget>[];
    for (String tableHeader in tableHeaders) {
      //Add Labels of the table to tabel row
      tableRow.add(
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
          child: Text(tableHeader, style: Theme
              .of(context)
              .tableHeader),
        ),
      );
    }
    rows.add(
      TableRow(
        children: tableRow,
        repeat: true,
        decoration: const BoxDecoration(color: PdfColors.purple50),
      ),
    );
    int slno = 0; //for slno column;
    for (Recordsetoftimecard timecardData in timecarddatalist) {
      slno++;
      final tableRow = <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          child: Text('$slno', style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child:
          Text(timecardData.checktime, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child:
          Text(timecardData.updatemin, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child:
          Text(timecardData.updatemout, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child:
          Text(timecardData.updateain, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child:
          Text(timecardData.updateaout, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(timecardData.remarks, style: Theme
              .of(context)
              .tableCell),
        ),
      ];
      rows.add(TableRow(children: tableRow));
      /* if ((timecardData.remarks).contains('HOLIDAY')) totalholidaysinTimecard++;
      else if(timecardData.remarks == 'ANNULLEAVE') */
      switch (timecardData.remarks) {
        case 'HOLIDAY':
          totalholidaysinTimecard++;
          break;
        case 'GOVT.HOLIDAY':
          totalholidaysinTimecard++;
          break;
        case 'ANNULLEAVE':
          totalannualleavesinTimecard++;
          break;
        case 'ABSENT':
          totalabsentsinTimecard++;
          break;
        case 'MEDICAL LEAVE':
          totalmedicalleavesinTimecard++;
          break;
        case 'ABSENT WITH REASON':
          totalabsentwithReasoninTimecard++;
          break;
      }
    }
    return rows;
  }

  List<TableRow> buildJobIncomeTable({required Context context,
    required List<String> tableHeaders,
    required List<RecordsetofJobIncome> jobincomedatalist}) {
    final rows = <TableRow>[];

    final tableRow = <Widget>[];
    for (String tableHeader in tableHeaders) {
      //Add Labels of the table to tabel row
      tableRow.add(
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
          child: Text(tableHeader, style: Theme
              .of(context)
              .tableHeader),
        ),
      );
    }
    rows.add(
      TableRow(
        children: tableRow,
        repeat: true,
        decoration: const BoxDecoration(color: PdfColors.purple50),
      ),
    );

    for (RecordsetofJobIncome jobincomedata in jobincomedatalist) {
      String vcrdateinstring =
          "${jobincomedata.vcrDate.day}-${jobincomedata.vcrDate
          .month}-${jobincomedata.vcrDate.year}";


      final tableRow = <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(jobincomedata.vcrNo, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(vcrdateinstring, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child:
          Text(jobincomedata.remarks, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(jobincomedata.soNo, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(jobincomedata.incomeAmt.toStringAsFixed(3),
              style: Theme
                  .of(context)
                  .tableCell),
        ),
      ];
      rows.add(TableRow(children: tableRow));
    }
    return rows;
  }

  List<TableRow> buildJobExpenseTable({required Context context,
    required List<String> tableHeaders,
    required List<RecordsetofJobExpense> jobexpensedatalist}) {
    final rows = <TableRow>[];

    final tableRow = <Widget>[];
    for (String tableHeader in tableHeaders) {
      //Add Labels of the table to tabel row
      tableRow.add(
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
          child: Text(tableHeader, style: Theme
              .of(context)
              .tableHeader),
        ),
      );
    }
    rows.add(
      TableRow(
        children: tableRow,
        repeat: true,
        decoration: const BoxDecoration(color: PdfColors.purple50),
      ),
    );

    for (RecordsetofJobExpense jobexpensedata in jobexpensedatalist) {
      //String vcrdateinstring="${jobincomedata.vcrDate.day}-${jobincomedata.vcrDate.month}-${jobincomedata.vcrDate.year}";


      final tableRow = <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(jobexpensedata.soNo, style: Theme
              .of(context)
              .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(jobexpensedata.soSubject,
              style: Theme
                  .of(context)
                  .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(jobexpensedata.qty.toString(),
              style: Theme
                  .of(context)
                  .tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(jobexpensedata.expenseAmt.toStringAsFixed(3),
              style: Theme
                  .of(context)
                  .tableCell),
        ),
      ];
      rows.add(TableRow(children: tableRow));
    }
    return rows;
  }
}
