import 'package:flutter/material.dart';

class ReceiptsPage extends StatelessWidget {
  const ReceiptsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receipts"),
        centerTitle: true,),
    );
  }
}
