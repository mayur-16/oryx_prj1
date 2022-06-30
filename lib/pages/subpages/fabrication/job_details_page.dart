import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oryx_prj1/models/jobdetails.dart';
import 'package:oryx_prj1/pages/subpages/fabrication/job_expense_pdf_page.dart';
import 'package:oryx_prj1/pages/subpages/fabrication/job_income_pdf_page.dart';

import '../../../models/appdetails.dart';
import '../../../services/apiservice.dart';

class JobDetailsPage extends StatefulWidget {
  final String jobno;

  const JobDetailsPage({Key? key, required this.jobno}) : super(key: key);

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  TextStyle lablestyle1 = const TextStyle(
      fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xff566573));
  TextStyle valuestyle1 = TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade600);

  late RecordsetofJobdetails data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job details"),
        centerTitle: true,
      ),
      body: FutureBuilder<JobDetails>(
          future: MyApi.getjobDetailsfromJobno(jobno: widget.jobno),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                log(snapshot.error.toString());
                return const Center(
                    child: Text("Some issues please try again"));
              } else if (snapshot.hasData) {
                List<RecordsetofJobdetails> listofdata =
                    snapshot.data!.recordset;

                if (listofdata.isEmpty) {
                  return const Center(
                    child: Text("Job details not found"),
                  );
                } else {
                  data = snapshot.data!.recordset.first;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                            child: Image.asset(AppDetails.logopath,
                                height: 50, width: 80)),
                        const SizedBox(height: 20),
                        const Text(
                          "All Details :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Job no:',
                              style: lablestyle1,
                            ),
                            Text(
                              data.jobno,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Job Name :',
                              style: lablestyle1,
                            ),
                            Flexible(
                                child: Text(
                              data.jobname,
                              style: valuestyle1,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Department:',
                              style: lablestyle1,
                            ),
                            Text(
                              data.deptName.isEmpty ? '---' : data.deptName,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Job date :',
                              style: lablestyle1,
                            ),
                            Flexible(
                                child: Text(
                              "${data.jdate.day}-${data.jdate.month}-${data.jdate.year}",
                              style: valuestyle1,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Job Type :',
                              style: lablestyle1,
                            ),
                            Text(
                              data.jobtype.isEmpty ? '---' : data.jobtype,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Job Status :',
                              style: lablestyle1,
                            ),
                            Text(
                              data.status.isEmpty ? '---' : data.status,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer code :',
                              style: lablestyle1,
                            ),
                            Text(
                              data.custCode.isEmpty ? '---' : data.custCode,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer name :',
                              style: lablestyle1,
                            ),
                            Flexible(
                              child: Text(
                                data.custName.isEmpty
                                    ? '---'
                                    : '${data.title} ${data.custName}',
                                style: valuestyle1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer mobile no :',
                              style: lablestyle1,
                            ),
                            Text(
                              data.custPhone1.isEmpty ? '---' : data.custPhone1,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'GL code :',
                              style: lablestyle1,
                            ),
                            Text(
                              data.glcode.isEmpty ? '---' : data.glcode,
                              style: valuestyle1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'GL name:',
                              style: lablestyle1,
                            ),
                            Flexible(
                              child: Text(
                                data.glName.isEmpty ? '---' : data.glName,
                                style: valuestyle1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Salesman:',
                              style: lablestyle1,
                            ),
                            Text(
                              data.salesman.isEmpty ? '---' : data.salesman,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Salesman phno:',
                              style: lablestyle1,
                            ),
                            Text(
                              data.salesmanPhone1.isEmpty
                                  ? '---'
                                  : data.salesmanPhone1,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Salesman email Id:',
                              style: lablestyle1,
                            ),
                            Text(
                              data.salesmanEmailId.isEmpty
                                  ? '---'
                                  : data.salesmanEmailId,
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Initial Job Value :',
                              style: lablestyle1,
                            ),
                            Text(
                              data.initialJobValue.toStringAsFixed(3),
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Net Job Value :',
                              style: lablestyle1,
                            ),
                            Text(
                              data.netJobValue.toStringAsFixed(3),
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estimated Job Value :',
                              style: lablestyle1,
                            ),
                            Text(
                              data.estimatedValue.toStringAsFixed(3),
                              style: valuestyle1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 50)
                      ],
                    ),
                  );
                }
              }
            }
            return const SizedBox();
          }),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
              onPressed: () async {
                Get.to(() => JobIncomePdfPage(data: data));
              },
              child: const Text("Income")),
          OutlinedButton(onPressed: () async {
            Get.to(() => JobExpensePdfPage(data: data));
          }, child: const Text("Expenses")),
        ],
      ),
    );
  }
}
