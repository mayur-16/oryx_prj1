import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/jobincomedetails.dart';
import 'package:oryx_prj1/services/PdfService.dart';
import 'package:oryx_prj1/services/apiservice.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/jobdetails.dart';


class JobIncomePdfPage extends StatefulWidget {
  final RecordsetofJobdetails data;
  const JobIncomePdfPage({Key? key,required this.data}) : super(key: key);

  @override
  State<JobIncomePdfPage> createState() => _JobIncomePdfPageState();
}

class _JobIncomePdfPageState extends State<JobIncomePdfPage> {

  double totalofjobexpense=0.000;

  @override
  void initState() {
    super.initState();
    gettotalofjobExpensefromJobno();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Income"),
        centerTitle: true,
      ),
      body:  FutureBuilder<JobIncomeDetails>(
          future: MyApi.getjobIncomeDetailsfromJobno(jobno: widget.data.jobno, glcode: widget.data.glcode),
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
                List<RecordsetofJobIncome> data=snapshot.data!.recordset;

                if(data.isEmpty){
                  return const Center(child: Text("No Income Found"),);
                }
                else {

                  return FutureBuilder<PDFDocument>(
                    future: generatepdf(data: data,totalofjobexpense: totalofjobexpense),
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

  Future<PDFDocument> generatepdf({required List<RecordsetofJobIncome> data,required double totalofjobexpense})async {
    ///write pdf document
    pw.Document pdf = MyPdf().writeJobincomePdf(incomedata: data, jobdetailsdata: widget.data,totalofJobexpense: totalofjobexpense);

    ///save generated pdf document
    await MyPdf().savePdf(savePdfAs: 'jobincome.pdf', sourcefile: pdf);

    ///get saved file
    File savedfile = await MyPdf().getsavedPdfFile(savedAs: 'jobincome.pdf');

    ///assign to global variable pdfdocument
    PDFDocument pdfDocument = await PDFDocument.fromFile(savedfile);

    return pdfDocument;

  }

  void gettotalofjobExpensefromJobno()async {
    totalofjobexpense=await MyApi.gettotalofjobExpensefromJobno(jobno: widget.data.jobno);
  }

}
