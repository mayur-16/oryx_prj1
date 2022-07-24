import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oryx_prj1/pages/subpages/management_reports/models/mis_route.dart';


class MisReportsListPage extends StatefulWidget {
  const MisReportsListPage({Key? key}) : super(key: key);

  @override
  State<MisReportsListPage> createState() => _MisReportsListPageState();
}

class _MisReportsListPageState extends State<MisReportsListPage> {



final List<MisRoute> mislist=[MisRoute('Enqueries','Enqueries'),MisRoute('Quotation','Quotation'),MisRoute('Orders','Orders'),MisRoute('Receipts','Receipts'),
  MisRoute('Cash Inflow','CashInflow'),MisRoute('Cash Outflow','CashOutflow'),MisRoute('Revenue Statement','RevenueStatement'),MisRoute('Income Statement','IncomeStatement')];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MIS REPORTS"),
        centerTitle: true,
        bottom: const PreferredSize(preferredSize: Size.fromHeight(2), child: Divider(thickness: 2,height: 2,)),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: mislist.length,
        itemBuilder: (_,index){
          return ListTile(
            title: Text(mislist[index].name.toUpperCase(),style: const TextStyle(color: Colors.black87,fontWeight:FontWeight.bold,fontSize: 13),),
            trailing: const Icon(Icons.arrow_forward_ios,size: 15,color: Colors.black87,),
            onTap: () async{

              Get.toNamed("/${mislist[index].route}");

              /* Get.to(()=> SalesOrderDetailsPage(deptid: data[index].deptId.toString(),
                  month: selectedmonth.month.toString(),year: selectedmonth.year.toString(),));*/

            },
          );
        }, separatorBuilder: (_, int index) {
        return const Divider();
      },),
    );
  }
}
