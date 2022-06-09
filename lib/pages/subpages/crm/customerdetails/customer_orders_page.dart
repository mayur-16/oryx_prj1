import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/customer_orders.dart';

import '../../../../services/apiservice.dart';

class CustomerOrdersPage extends StatelessWidget {
  final String pcode;
  const CustomerOrdersPage({Key? key,required this.pcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Orders"),),
      body: FutureBuilder<CustomerOrders>(
          future: MyApi.getCustomerOrders(pcode: pcode),
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
                List<RecordsetofCustomerOrders> data=snapshot.data!.recordset;

                if(data.isEmpty){
                  return const Center(child: Text("No Orders Found"),);
                }
                else {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_,index){
                      String dateinString="${data.elementAt(index).sodate.day}-${data.elementAt(index).sodate.month}-${data.elementAt(index).sodate.year}";
                      return ListTile(
                        title: Text("Sono: ${data[index].sono}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
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
