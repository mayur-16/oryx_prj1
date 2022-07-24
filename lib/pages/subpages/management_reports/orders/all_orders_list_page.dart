import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oryx_prj1/models/alldepartments.dart';
import 'package:oryx_prj1/pages/subpages/management_reports/orders/salesorder_details_page.dart';
import 'package:oryx_prj1/services/apiservice.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'dart:developer';

class AllOrdesListPage extends StatelessWidget {
  const AllOrdesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
        bottom: const PreferredSize(preferredSize: Size.fromHeight(2), child: Divider(thickness: 2,height: 2,)),
      ),
      body: FutureBuilder<AllDepartments>(
        future: MyApi.getAllDepartments(),
          builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        else if(snapshot.connectionState==ConnectionState.done)
          {
            if(snapshot.hasData){
              if(snapshot.data!.recordset.isEmpty)
                {
                  return const Center(
                    child: Text("Department List is Empty"),
                  );
                }
              else{
                List<RecordsetofAllDepartments> data=snapshot.data!.recordset;

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                    itemBuilder: (_,index){
                  return ListTile(
                    title: Text(data[index].deptName,style: const TextStyle(color: Colors.black87,fontWeight:FontWeight.bold,fontSize: 13),),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 15,color: Colors.black87,),
                    onTap: () async{

                       DateTime? selectedmonth=await showMonthYearPicker(context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2010), lastDate: DateTime(DateTime.now().year+1,9));

                       log("${selectedmonth?.month} - ${selectedmonth?.year}");

                       //if month is selected navigate to next page
                       if(selectedmonth!=null){
                         Get.to(()=> SalesOrderDetailsPage(deptid: data[index].deptId.toString(),
                           month: selectedmonth.month.toString(),year: selectedmonth.year.toString(),));
                       }

                    },
                  );
                }, separatorBuilder: (_, int index) {
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
