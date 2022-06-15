import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/customer_payments.dart';

import '../../../../services/apiservice.dart';

class CustomerPaymentsPage extends StatelessWidget {
  final String pcode;
  const CustomerPaymentsPage({Key? key,required this.pcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Payments"),),
      body: FutureBuilder<CustomerPayments>(
          future: MyApi.getCustomerPayments(pcode: pcode),
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
                List<RecordsetofCustomerPayments> data=snapshot.data!.recordset;

                if(data.isEmpty){


                  return const Center(child: Text("No Payments Found"),);
                }
                else {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_,index){

                      String dateinString=data.elementAt(index).refdt.isBefore(DateTime(2000))?"---":
                      "${data.elementAt(index).refdt.day}-${data.elementAt(index).refdt.month}-${data.elementAt(index).refdt.year}";


                      return ListTile(
                        title: Text("Refno : ${data[index].refno}",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                        subtitle: Text(data[index].description.isEmpty?"--":data[index].description,style: const TextStyle(fontSize: 12,),maxLines: 3,),
                        trailing: Text("BHD. ${data[index].refamount}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        leading: Text(dateinString,style: const TextStyle(fontSize: 12),),
                      );
                    },
                    separatorBuilder: (_,index) {
                      return const Divider();
                    },);
                }
              }
            }
            return const SizedBox();
          }),
    );
  }
}
