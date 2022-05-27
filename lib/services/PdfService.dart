import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';

import '../models/monthlytimecard.dart';

class MyPdf {
  final Document pdf = Document(); //Create new blank document;

  //Different textstyles for pdf
  TextStyle style1bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 23);
  TextStyle style2bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle style3bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

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

  void writeTimecardPdf(
      {required List<Recordsetoftimecard> timecarddatalist,
       required String empname,
        required String badgenumber,
        required String selectedmonthName,
        required String selectedYear}) {
    String savePdfAs = 'wagesheet.pdf'; //Pdf path name for saving the file;
    List<String> tableHeaders = [
      'SL NO',
      'DATE',
      'MORN\nIN',
      'MORN\nOUT',
      'AFT\nIN',
      'AFT\nOUT',
      'REMARKS'
    ]; //Headers(labels) of table;

    pdf.addPage(//add new Page to blank document
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
              children: buildTable(
                  context: context,
                  timecarddatalist: timecarddatalist,
                  tableHeaders: tableHeaders),
              border: TableBorder.all(),
              tableWidth: TableWidth.max,
            ),
          ] else ...[
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

    saveAndOpenPdf(savePdfAs);
  }


  void saveAndOpenPdf(String savePdfAs) async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //Get the application directory containing path
    File file =
        File("${directory.path}/$savePdfAs"); //Get the path from the directory
    file.writeAsBytesSync(await pdf.save()); // Save the created pdf in the path
    await OpenFile.open(file.path); //Open pdf file using openfile package
  }

  List<TableRow> buildTable(
      {required Context context,
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
          child: Text(tableHeader, style: Theme.of(context).tableHeader),
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
          child: Text('$slno', style: Theme.of(context).tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(timecardData.checktime,
              style: Theme.of(context).tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(timecardData.updatemin,
              style: Theme.of(context).tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(timecardData.updatemout,
              style: Theme.of(context).tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(timecardData.updateain,
              style: Theme.of(context).tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(timecardData.updateaout,
              style: Theme.of(context).tableCell),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(timecardData.remarks,
              style: Theme.of(context).tableCell),
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
}
