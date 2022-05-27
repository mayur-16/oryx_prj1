import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../models/monthlytimecard.dart';
import '../../../services/PdfService.dart';
import '../../../services/apiservice.dart';

class WageSheetPageHr extends StatelessWidget {
  const WageSheetPageHr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wage Sheet"),centerTitle: true,),
      body: Center(
        child: ElevatedButton(onPressed: (){
          _selectDate(context, "103011",
              "MANZOOR");
        }, child: const Text("View Wage Sheet")),
      ),
    );
  }
}

Future<void> _selectDate(
    BuildContext context, String badgenum, String empname) async {
  DateTime currentdate = DateTime.now();

  final DateTime? pickedDate = await showMonthPicker(
    context: context,
    initialDate: currentdate,
    lastDate: currentdate,
  );
  if (pickedDate != null && pickedDate != currentdate) {
    String month = pickedDate.month.toString();
    String year = pickedDate.year.toString();
    List<String> monthname=['JAN','FEB','MARCH','APRIL','MAY','JUNE','JULY','AUG'
      ,'SEP','OCT','NOV','DEC'];
    print('$month $year $badgenum ');
    _timecardReportFunction(
        month: month,
        year: year,
        badgenum: badgenum,
        empname: empname,
        selectedmonthname: monthname[(pickedDate.month)-1]);
  }
}

void _timecardReportFunction(
    {required String month,
      required String year,
      required String badgenum,
      required String empname,
      required String selectedmonthname}) async {
  //GET TIMECARD DETAILS USING BADGENUM
  MyApi.gettimecardDetailsfromBadgenum(
      month: month, year: year, badgenum: badgenum)
      .then((values) async {
    List<Recordsetoftimecard> listofTimecardDetails = values;
    MyPdf().writeTimecardPdf(
        timecarddatalist: listofTimecardDetails,
        empname: empname,
        badgenumber: badgenum,
        selectedmonthName: selectedmonthname,
        selectedYear: year);
  });
}
