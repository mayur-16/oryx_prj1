
class SublistPageItem{
  final String pagetitle;
  final List<String> pageitemsnames;
  final List<String> redirectpages;

  SublistPageItem({required this.pagetitle,required this.pageitemsnames,required this.redirectpages});
}


List<SublistPageItem> sublistpageitems=[
  SublistPageItem(pagetitle: "Customer Relationship", pageitemsnames: [
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
  
  SublistPageItem(pagetitle: "Purchase & Supply chain",
      pageitemsnames: [],
      redirectpages: [
      ]),

  SublistPageItem(pagetitle: "Fabrication projects",
      pageitemsnames: [],
      redirectpages: []),

  SublistPageItem(pagetitle: "Trading",
      pageitemsnames: ['Product Profile', 'E-cart', 'Delivery', 'Bills & Payments'],
      redirectpages: [
        '/ProductprofileEshowroom',
        '/EcartPage',
        '/Deliveryeshowroom',
        '/BillsNpaymentshowroom'
      ]),
  
  SublistPageItem(pagetitle: "Materials & Warehouse", pageitemsnames: [],
      redirectpages: [],
  ),
  
  SublistPageItem(pagetitle: "Human resource", pageitemsnames: [
    'Time & Attendence',
    'Wage Sheet',
    'Jobwise Allocation',
    'Loss of Pay',
    'Pay Slip',
    'Loans & Deduction',
    'Apply for Leave',
    'Apply for Document'
  ], redirectpages: [
    '/TimeNattendenceHr',
    '/WageSheetHr',
    '/JobwiseallocationHr',
    '/LossofPayHr',
    '/PayslipHr',
    '/LoansNdeductionHr',
    '/ApplyforleaveHr',
    '/ApplyfordocHr'
  ]),

  SublistPageItem(pagetitle: "Finance Reports", pageitemsnames: [], redirectpages: []),

  SublistPageItem(pagetitle: "Kitchen fittings", pageitemsnames: [], redirectpages: []),

  SublistPageItem(pagetitle: "Wooden coating", pageitemsnames: [], redirectpages: []),

  SublistPageItem(pagetitle: "Powder coating", pageitemsnames: [], redirectpages: []),

  SublistPageItem(pagetitle: "Management reports", pageitemsnames: [], redirectpages: []),

  SublistPageItem(pagetitle: "Other Services", pageitemsnames: [], redirectpages: []),
];

