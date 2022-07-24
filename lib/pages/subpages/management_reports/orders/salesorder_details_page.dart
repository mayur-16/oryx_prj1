import 'package:flutter/material.dart';
import 'package:oryx_prj1/models/salesorderdetails.dart';

import '../../../../services/apiservice.dart';

class SalesOrderDetailsPage extends StatelessWidget {
  final String deptid;
  final String month;
  final String year;

  const SalesOrderDetailsPage(
      {Key? key, required this.deptid, required this.month, required this.year})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales Order Details"),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(2), child: Divider(thickness: 2,height: 2,)),
      ),
      body: FutureBuilder<SalesOrderDetails>(
          future: MyApi.getListofSalesOrderbyDeptid(
              deptid: deptid, month: month, year: year),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.recordset.isEmpty) {
                  return const Center(
                    child: Text("Sales order list is Empty"),
                  );
                } else {
                  List<RecordsetofSalesorderDetails> data =
                      snapshot.data!.recordset;

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (_, index) {

                        String sodate =
                            "${data[index].sodate.day}-${data[index].sodate.month}-${data[index].sodate.year}";
                        return ListTile(
                        leading: Text(
                          sodate,
                          style:  const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        title: Text(
                          data[index].custName,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Bd . ${data[index].total}",
                          style:   TextStyle(
                              color: Colors.blue.shade500,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          "--${data[index].salesman}",
                          style: TextStyle(
                              color: Colors.grey.shade800, fontSize: 12),
                        ),
                      );

                    },
                    separatorBuilder: (_, int index) {
                      return const Divider(
                        color: Colors.black54,
                      );
                    },
                  );
                }
              }
            }
            return const SizedBox();
          }),
    );
  }
}
