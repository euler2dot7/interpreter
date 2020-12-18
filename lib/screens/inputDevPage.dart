import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_interpreter/screens/asm.dart';
import 'package:flutter_interpreter/screens/astPage.dart';
import 'package:flutter_interpreter/viewmodel/ExpProvider.dart';
import 'package:provider/provider.dart';

class InputDevPage extends StatelessWidget {
  static String routeName = '/';
  final TextEditingController _textController = TextEditingController();

  InputDevPage();

  @override
  Widget build(BuildContext context) {
    var expProvider = Provider.of<ExpProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Input Device'),
          actions: <Widget>[
            FlatButton.icon(
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, AstPage.routeName);
              },
              icon: Icon(Icons.account_tree),
              label: Text('Abstract Syntax Tree'),
            ),
            FlatButton.icon(
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, AsmPage.routeName);
              },
              icon: Icon(Icons.memory_rounded),
              label: Text('Stack Machine ASM'),
            ),
          ],
        ),
        body: IconTheme(
          data: IconThemeData(color: Theme.of(context).accentColor),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 54.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: _textController,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9+-/*()]"))],
                          onSubmitted: expProvider.add,
                          decoration: InputDecoration.collapsed(hintText: 'Insert expression'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: RotatedBox(
                          quarterTurns: 1, child: IconButton(icon: Icon(Icons.pause), onPressed: () => expProvider.add(_textController.text))),
                    ),
                  ],
                ),
                Consumer<ExpProvider>(builder: (context, value, child) {
                  double result = value.evaluationResult;
                  if (result == null) _textController.clear();
                  return Text(
                    _textController.text == null ? "" : _textController.text + (result == null ? "" : " = $result"),
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  );
                })
              ],
            ),
          ),
        ));
  }
}
