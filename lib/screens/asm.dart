import 'package:flutter/material.dart';
import 'package:flutter_interpreter/viewmodel/ExpProvider.dart';
import 'package:provider/provider.dart';

class AsmPage extends StatelessWidget {
  static String routeName = '/asm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assembler for Stack Machine"),
        ),
        body: Consumer<ExpProvider>(
          builder: (context, value, child) {
            return Text(value.treeViewString, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold));
          },
        ));
  }

// return Text(
// _textController.text == null ? "" : _textController.text + (result == null ? "" : " = $result"),
// style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
// );
}
