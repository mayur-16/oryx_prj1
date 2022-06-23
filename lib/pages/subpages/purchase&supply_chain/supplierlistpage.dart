import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oryx_prj1/models/supplier.dart';
import 'package:oryx_prj1/pages/subpages/purchase&supply_chain/supplierdetailspage.dart';

import '../../../services/apiservice.dart';

class SupplierListPage extends StatelessWidget {
  const SupplierListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supplier list"),
      ),
      body: FutureBuilder<Supplier>(
          future: MyApi.getAllSuppliersDetails(),
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
                List<RecordsetofSupplier> data=snapshot.data!.recordset;

                if(data.isEmpty){
                  return const Center(child: Text("No Suppliers Found"),);
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
                        Get.to(()=>SupplierDetails(pcode: data[index].pcode, suppliername: data[index].custName));

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
