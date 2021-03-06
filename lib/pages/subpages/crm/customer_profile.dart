import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/customer.dart';
import 'package:oryx_prj1/services/apiservice.dart';
import 'dart:developer';

class CustomerProfileCrm extends StatelessWidget {
  const CustomerProfileCrm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Profile"),
      ),
      body: FutureBuilder<Customer>(
        future: MyApi.getAllCustomerDetails(),
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
                  List<RecordsetofCustomer> data=snapshot.data!.recordset;

                  if(data.isEmpty){
                    return const Center(child: Text("No Customers Found"),);
                  }
                  else {
                    return ListView.separated(
                      itemCount: data.length,
                        itemBuilder: (_,index){
                      return ListTile(
                        tileColor: Colors.white70,
                        leading: Text("pcode:\n${data[index].pcode}",style: const TextStyle(fontSize: 12),),
                        title: Text(data[index].custName,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        subtitle: Text("phno: ${data[index].phone1}",style: const TextStyle(fontSize: 12),),
                      );
                    },
                    separatorBuilder: (_,index){
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
