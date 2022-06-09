import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/customer_bills.dart';

import '../../../../services/apiservice.dart';

class CustomerBillsPage extends StatelessWidget {
  final String pcode;
  const CustomerBillsPage({Key? key,required this.pcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Bills"),),
      body: FutureBuilder<CustomerBills>(
          future: MyApi.getCustomerBills(pcode: pcode),
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
                List<RecordsetofCustomerBills> data=snapshot.data!.recordset;

                if(data.isEmpty){
                  return const Center(child: Text("No Bills Found"),);
                }
                else {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_,index){
                      String dateinString="${data.elementAt(index).invDate.day}-${data.elementAt(index).invDate.month}-${data.elementAt(index).invDate.year}";
                      return ListTile(
                        leading: Text("Invno :\n${data[index].invNo}",style: const TextStyle(fontSize: 12),),
                        title: Text("BHD. ${data[index].amount}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        trailing: Text(dateinString,style: const TextStyle(fontSize: 12),),
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
