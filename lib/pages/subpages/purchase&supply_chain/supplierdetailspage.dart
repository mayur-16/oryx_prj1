import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/appdetails.dart';
import 'package:oryx_prj1/models/supplierdetails.dart';
import 'package:oryx_prj1/services/apiservice.dart';

class SupplierDetails extends StatefulWidget {
  final String pcode;
  final String suppliername;

  const SupplierDetails(
      {Key? key, required this.pcode, required this.suppliername})
      : super(key: key);

  @override
  State<SupplierDetails> createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
  
  TextStyle lablestyle1=const TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Color(
      0xff566573));
  TextStyle valuestyle1= TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey.shade600);
  
  ButtonStyle buttonstyle1 = ButtonStyle(
      padding:
          MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10)),
      minimumSize: MaterialStateProperty.all(const Size(20, 35)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.suppliername),
      ),
      body: FutureBuilder<SupplierFullDetails>(
          future: MyApi.getFullSupplierDetails(pcode: widget.pcode),
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
                List<RecordsetofSupplierDetails> datalist =
                    snapshot.data!.recordset;

                if (datalist.isEmpty) {
                  return const Center(
                    child: Text("No Customers Found"),
                  );
                } else {
                  RecordsetofSupplierDetails data = datalist.first;

                  double currentbal = data.opbal + data.dbBal - data.crBal;

                  return SingleChildScrollView(
                    child: Padding(
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
                            "Contact Details :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Party Code :',style: lablestyle1,),
                              Text(widget.pcode,style: valuestyle1,),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Contact Name :',style: lablestyle1,),
                              Flexible(child: Text(data.custName,style: valuestyle1,overflow: TextOverflow.ellipsis,)),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Address :',style: lablestyle1,),
                              Flexible(child: Text("${data.add1}  ${data.add2}",style: valuestyle1,overflow: TextOverflow.ellipsis,)),
                            ],
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                              child: Text(data.add3,style: valuestyle1,textAlign: TextAlign.end,)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Post Box No :',style: lablestyle1,),
                              Text(data.pobox.isEmpty?'---':data.pobox,style: valuestyle1,),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Mobile no :',style: lablestyle1,),
                              Text(data.mobile.isEmpty?'---':data.mobile,style: valuestyle1,),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Email :',style: lablestyle1,),
                              Flexible(child: Text(data.email.isEmpty?'---':data.email,style: valuestyle1,overflow: TextOverflow.ellipsis,)),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Fax No :',style: lablestyle1,),
                              Text(data.fax1.isEmpty?'---':data.fax1,style: valuestyle1,),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('VAT Registration No :',style: lablestyle1,),
                              Text(data.tax1No.isEmpty?'---':data.tax1No,style: valuestyle1,),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Text('Note :',style: lablestyle1,),

                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              color: Colors.white54,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side: const BorderSide(color: Colors.black45)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(data.remarks,style: valuestyle1,overflow: TextOverflow.clip,),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40,),
                          const Text(
                            "Account Details:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 10),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Opening Balance BD. :',style: lablestyle1,),
                              Text(data.opbal.toString(),style: valuestyle1,),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Payments BD. :',style: lablestyle1,),
                              Text(data.crBal.toString(),style: valuestyle1,),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Billed BD :',style: lablestyle1,),
                              Text(data.dbBal.toString(),style: valuestyle1,),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Current Balance BD :',style: lablestyle1,),
                              Text(currentbal.toString(),style: valuestyle1,),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Credit Limit :',style: lablestyle1,),
                              Text(data.crLimit.toString(),style: valuestyle1,),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Aging :',style: lablestyle1,),
                              Text('',style: valuestyle1,),
                            ],
                          ),

                          const SizedBox(height: 50)
                        ],
                      ),
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
              onPressed: () {
                ///Get.to(()=>CustomerBillsPage(pcode: widget.pcode));
              },
              child: const Text("Bills")),
          ElevatedButton(
              style: buttonstyle1,
              onPressed: () {
                //Get.to(()=>CustomerPaymentsPage(pcode: widget.pcode));
              },
              child: const Text("Payments")),
          ElevatedButton(
              style: buttonstyle1,
              onPressed: () {
                ///Get.to(()=>CustomerOrdersPage(pcode: widget.pcode));
              },
              child: const Text("Orders")),
          ElevatedButton(
              style: buttonstyle1,
              onPressed: () {
                //Get.to(()=>CustomerEnquiriesPage(pcode: widget.pcode));
              },
              child: const Text("Enquiries")),
        ],
      ),
    );
  }
}
