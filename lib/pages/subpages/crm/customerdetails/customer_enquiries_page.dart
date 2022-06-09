import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/customer_enqueries.dart';

import '../../../../services/apiservice.dart';

class CustomerEnquiriesPage extends StatelessWidget {
  final String pcode;
  const CustomerEnquiriesPage({Key? key,required this.pcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Enquiries"),),
      body: FutureBuilder<CustomerEnqueries>(
          future: MyApi.getCustomerEnqueries(pcode: pcode),
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
                List<RecordsetofCustomerEnquiries> data=snapshot.data!.recordset;

                if(data.isEmpty){
                  return const Center(child: Text("No Enquiries Found"),);
                }
                else {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_,index){
                      return ListTile(
                        leading: Text("Type :\n${data[index].casetype}",style: const TextStyle(fontSize: 12),),
                        title: Text(data[index].casedescription,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        trailing: Text(data[index].caseno,style: const TextStyle(fontSize: 12),),
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
