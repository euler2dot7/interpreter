
import 'apt.dart';
import 'expVisitor.dart';
import 'lexer.dart';
import 'parser.dart';
import 'stackExpVisitor.dart';
import 'evalExpVisitor.dart';

main(List<String> arguments) {
  String expStr = "(13 - (4 - 5))";
  final parVisitor = StackExpVisitor();
  parVisitor.visit(ParserExp(RegExpLexer(expStr)).getAst());
  print(parVisitor.stack);
  // final evalVisitor = EvalExpVisitor();
  // evalVisitor.visit(ParserExp(RegExpLexer(expStr)).getAst());
  // print(evalVisitor.getEvaluation());

  // final sm = StackMachineVisitor();
  // sm.visit(ParserExp(RegExpLexer(expStr)).getAst());
}
