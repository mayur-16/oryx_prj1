import 'package:flutter/material.dart';

class QuotationPage extends StatelessWidget {
  const QuotationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quotation"),
        centerTitle: true,),
    );
  }
}
