import 'package:flutter/material.dart';
import 'package:flutter_interpreter/screens/asm.dart';
import 'package:flutter_interpreter/screens/inputDevPage.dart';
import 'package:flutter_interpreter/screens/astPage.dart';
import 'package:flutter_interpreter/viewmodel/ExpProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(TestingApp());
}

class TestingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpProvider>(
      create: (context) => ExpProvider(),
      child: MaterialApp(
        title: 'Testing Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          InputDevPage.routeName: (context) => InputDevPage(),
          AstPage.routeName: (context) => AstPage(),
          AsmPage.routeName: (context) => AsmPage(),
        },
        initialRoute: InputDevPage.routeName,
      ),
    );
  }
}
