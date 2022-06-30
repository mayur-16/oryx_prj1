import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/jobexpensedetails.dart';
import 'package:oryx_prj1/services/PdfService.dart';
import 'package:oryx_prj1/services/apiservice.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/jobdetails.dart';


class JobExpensePdfPage extends StatefulWidget {
  final RecordsetofJobdetails data;
  const JobExpensePdfPage({Key? key,required this.data}) : super(key: key);

  @override
  State<JobExpensePdfPage> createState() => _JobExpensePdfPageState();
}

class _JobExpensePdfPageState extends State<JobExpensePdfPage> {

  double totalofjobincome=0.000;

  @override
  void initState() {
    super.initState();
    gettotalofjobIncomefromJobno();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Expense"),
        centerTitle: true,
      ),
      body:  FutureBuilder<JobExpenseDetails>(
          future: MyApi.getjobExpenseDetailsfromJobno(jobno: widget.data.jobno),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting)
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.connectionState==ConnectionState.done)
            {
              if(snapshot.hasError)
              {
                log(snapshot.error.toString());
                return const Center(child: Text("Some issues please try again"));
              }
              else if(snapshot.hasData)
              {
                List<RecordsetofJobExpense> data=snapshot.data!.recordset;

                if(data.isEmpty){
                  return const Center(child: Text("No Expenses Found"),);
                }
                else {

                  return FutureBuilder<PDFDocument>(
                      future: generatepdf(data: data,totalofJobincome: totalofjobincome),
                      builder: (_,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const Center(child: Text("generating pdf file..."),);
                        }else if(snapshot.connectionState==ConnectionState.done){
                          if(snapshot.hasData){
                            return PDFViewer(document: snapshot.data!);
                          }
                        }
                        return const SizedBox();
                      });



                }
              }
            }
            return const SizedBox();
          }),
    );
  }

  Future<PDFDocument> generatepdf({required List<RecordsetofJobExpense> data,required double totalofJobincome})async {
    ///write pdf document
    pw.Document pdf = MyPdf().writeJobExpensePdf(expensedata: data, jobdetailsdata: widget.data,totalofJobincome: totalofJobincome);

    ///save generated pdf document
    await MyPdf().savePdf(savePdfAs: 'jobexpense.pdf', sourcefile: pdf);

    ///get saved file
    File savedfile = await MyPdf().getsavedPdfFile(savedAs: 'jobexpense.pdf');

    ///assign to global variable pdfdocument
    PDFDocument pdfDocument = await PDFDocument.fromFile(savedfile);

    return pdfDocument;

  }

  void gettotalofjobIncomefromJobno()async {
    totalofjobincome=await MyApi.gettotalofjobIncomefromJobno(jobno: widget.data.jobno,glcode: widget.data.glcode);
  }
}
