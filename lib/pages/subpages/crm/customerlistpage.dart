import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oryx_prj1/pages/subpages/crm/customerdetailspage.dart';

import '../../../models/customer.dart';
import '../../../services/apiservice.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer list"),
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
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_,index){
                      return ListTile(
                        tileColor: index%2==0? Colors.grey.shade300:Colors.white70,
                        leading: Text("pcode:\n${data[index].pcode}",style: const TextStyle(fontSize: 12),),
                        title: Text(data[index].custName,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        subtitle: Text("phno: ${data[index].phone1}",style: const TextStyle(fontSize: 12),),
                        onTap: (){

                          ///navigate to customerdetails page
                        Get.to(()=>CustomerDetails(pcode: data[index].pcode, customername: data[index].custName));

                        },
                      );
                    },);
                }
              }
            }
            return const SizedBox();
          }),
    );
  }
}
