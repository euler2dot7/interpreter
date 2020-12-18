import 'package:flutter/material.dart';
import 'package:flutter_interpreter/models/apt.dart';
import 'package:flutter_interpreter/models/evalExpVisitor.dart';
import 'package:flutter_interpreter/models/lexer.dart';
import 'package:flutter_interpreter/models/stackExpVisitor.dart';
import 'package:flutter_interpreter/models/parser.dart';

class ExpProvider extends ChangeNotifier {
  Exp _apt;
  double _evaluationResult;
  String treeViewString = "";

  get apt => _apt;

  get evaluationResult => _evaluationResult;

  void add(String expStr) {
    Exp resultAst = ParserExp(RegExpLexer(expStr)).getAst();
    _apt = resultAst;
    if (resultAst != null) {
      final evalVisitor = EvalExpVisitor();
      evalVisitor.visit(resultAst);
      _evaluationResult = evalVisitor.getEvaluation();
      final smVisitor = StackExpVisitor();
      smVisitor.visit(resultAst);
      treeViewString = smVisitor.stack;
    } else {
      _evaluationResult = null;
      treeViewString = "";
    }
    print(evaluationResult);
    notifyListeners();
  }
}
