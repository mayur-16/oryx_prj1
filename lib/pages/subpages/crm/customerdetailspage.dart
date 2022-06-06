import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/customerdetails.dart';
import 'package:oryx_prj1/services/apiservice.dart';

class CustomerDetails extends StatefulWidget {
  final String pcode;
  final String customername;
  const CustomerDetails({Key? key,required this.pcode,required this.customername}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.customername),),
      body: FutureBuilder<CustomerFullDetails>(
          future: MyApi.getFullCustomerDetails(pcode: widget.pcode),
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
                List<RecordsetofCustomerDetails> datalist=snapshot.data!.recordset;

                if(datalist.isEmpty){
                  return const Center(child: Text("No Customers Found"),);
                }
                else {
                  RecordsetofCustomerDetails data=datalist.first;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(onPressed: (){}, child: const Text("Bills")),
                            ElevatedButton(onPressed: (){}, child: const Text("Orders")),
                          ],
                        ),
                        Text("Gl code :${data.glcode}"),
                        Text("Mobile no  :${data.mobile}"),
                        Text("Address 1  :${data.add1}"),
                        Text("Address 2  :${data.add2}"),
                        Text("Address 3  :${data.add3}"),
                        Text("Cr Balance :${data.crBal}"),
                        Text("Db Balance :${data.dbBal}"),
                        Text("Op Balance :${data.opbal}"),
                        Text("Cr Limit   :${data.crLimit}"),

                      ],
                    ),
                  );
                }
              }
            }
            return const SizedBox();
          }),
    );
  }
}
