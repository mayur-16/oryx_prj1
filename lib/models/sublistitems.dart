
class SublistPageItem{
  final String pagetitle;
  final List<String> pageitemsnames;
  final List<String> redirectpages;

  SublistPageItem({required this.pagetitle,required this.pageitemsnames,required this.redirectpages});
}


List<SublistPageItem> sublistpageitems=[
  SublistPageItem(pagetitle: "CRM", pageitemsnames: [
    'Bills & Payments',
    'Complaints & Enqueries',
    'Customer Profile',
    'Orders & Schedules'
  ], redirectpages:  [
    '/BillsNpaymentCrm',
    '/ComplaintsNenqueriesCrm',
    '/CustomerProfileCrm',
    '/OrdersNschedulesCrm'
  ]),
  
  SublistPageItem(pagetitle: "SUPPLY CHAIN",
      pageitemsnames: [],
      redirectpages: [
      ]),

  SublistPageItem(pagetitle: "PROJECTS",
      pageitemsnames: [],
      redirectpages: []),

  SublistPageItem(pagetitle: "E-SHOWROOM",
      pageitemsnames: ['Product Profile', 'E-cart', 'Delivery', 'Bills & Payments'],
      redirectpages: [
        '/ProductprofileEshowroom',
        '/EcartPage',
        '/Deliveryeshowroom',
        '/BillsNpaymentshowroom'
      ]),
  
  SublistPageItem(pagetitle: "WMS", pageitemsnames: [],
      redirectpages: [],
  ),
  
  SublistPageItem(pagetitle: "HR", pageitemsnames: [
    'Time & Attendence',
    'Jobwise Allocation',
    'Loss of Pay',
    'Pay Slip',
    'Loans & Deduction',
    'Apply for Leave',
    'Apply for Document'
  ], redirectpages: [
    '/TimeNattendenceHr',
    '/JobwiseallocationHr',
    '/LossofPayHr',
    '/PayslipHr',
    '/LoansNdeductionHr',
    '/ApplyforleaveHr',
    '/ApplyfordocHr'
  ]),

  SublistPageItem(pagetitle: "MMP", pageitemsnames: [], redirectpages: []),

  SublistPageItem(pagetitle: "SMC", pageitemsnames: [], redirectpages: []),
];

