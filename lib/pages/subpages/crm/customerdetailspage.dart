import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/appdetails.dart';
import 'package:oryx_prj1/models/customerdetails.dart';
import 'package:oryx_prj1/services/apiservice.dart';

class CustomerDetails extends StatefulWidget {
  final String pcode;
  final String customername;

  const CustomerDetails(
      {Key? key, required this.pcode, required this.customername})
      : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  ButtonStyle buttonstyle1 = ButtonStyle(
      padding:
          MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10)),
      minimumSize: MaterialStateProperty.all(const Size(20, 35)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customername),
      ),
      body: FutureBuilder<CustomerFullDetails>(
          future: MyApi.getFullCustomerDetails(pcode: widget.pcode),
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
                List<RecordsetofCustomerDetails> datalist =
                    snapshot.data!.recordset;

                if (datalist.isEmpty) {
                  return const Center(
                    child: Text("No Customers Found"),
                  );
                } else {
                  RecordsetofCustomerDetails data = datalist.first;

                  double currentbal = data.opbal + data.dbBal - data.crBal;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset(AppDetails.logopath,
                                height: 50, width: 80)),

                        const SizedBox(height: 20),
                        const Text(
                          "Contact Details :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text("Party Code :${widget.pcode}"),
                        Text("Contact Name :${widget.pcode}"),

                        Text("Mobile no  :${data.mobile}"),
                        Text("Address    :${data.add1} ${data.add2}"),
                        Text("                   ${data.add3}"),
                        Text("Post Box No:${data.pobox}"),
                        Text("Mobile no  :${data.mobile}"),
                        Text("Email  :${data.email}"),
                        Text("Fax No.:${data.fax1}"),
                        Text("VAT Registration No.:${data.tax1No}"), //tax_1_no
                        Text(
                          "Note :${data.remarks}",
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Account Details:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 10),

                        Text("Opening Balance BD.:${data.opbal}"),
                        Text("Payments BD.:${data.crBal}"),
                        Text("Billed BD.:${data.dbBal}"),
                        Text("Current Balance BD.: $currentbal"),
                        Text("Credit Limit   :${data.crLimit}"),
                        const SizedBox(height: 50),
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
          ElevatedButton(
              style: buttonstyle1,
              onPressed: () {},
              child: const Text("Bills")),
          ElevatedButton(
              style: buttonstyle1,
              onPressed: () {},
              child: const Text("Payments")),
          ElevatedButton(
              style: buttonstyle1,
              onPressed: () {},
              child: const Text("Orders")),
          ElevatedButton(
              style: buttonstyle1,
              onPressed: () {},
              child: const Text("Enquiries")),
        ],
      ),
    );
  }
}
