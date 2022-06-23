import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oryx_prj1/models/alljobs.dart';
import 'package:oryx_prj1/pages/subpages/fabrication/job_details_page.dart';

import '../../../services/apiservice.dart';

class AllJobsListPage extends StatelessWidget {
  const AllJobsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Jobs list"),
      ),
      body: FutureBuilder<AllJobs>(
          future: MyApi.getAlljobsoftheyear(),
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
                List<RecordsetofAllJobs> data=snapshot.data!.recordset;

                if(data.isEmpty){
                  return const Center(child: Text("No Jobs Found"),);
                }
                else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_,index){
                      String dateinString="${data.elementAt(index).jdate.day}-${data.elementAt(index).jdate.month}-${data.elementAt(index).jdate.year}";

                      return ListTile(
                        tileColor: index%2==0? Colors.grey.shade300:Colors.white70,
                        leading: Text(dateinString,style: const TextStyle(fontSize: 12),),
                        title: Text(data[index].jobname,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        subtitle: Text("--${data[index].salesman}",style: const TextStyle(fontSize: 12),),
                        trailing: Text("Bd. ${data[index].netJobValue}",style: const TextStyle(fontSize: 12),),
                        onTap: (){

                          ///navigate to jobdetails page
                          Get.to(()=>JobDetailsPage(jobno: data[index].jobno));

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
