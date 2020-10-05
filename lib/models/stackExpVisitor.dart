import 'expVisitor.dart';
import 'apt.dart';

class StackExpVisitor extends ExpVisitor {
  String curs = "";
  String _stackVals = '';

  get stack => _stackVals;

  //read the result
  void visitOpExp(OpExp e, String stackRep) {
    e.left.accept(this);
    String leftString = stack;
    e.right.accept(this);
    String rightString = stack;
    _stackVals = leftString + '\n' + rightString + '\n' + stackRep;
  }

  @override
  void visitDiv(DivExp e) => visitOpExp(e, "DIV");

  @override
  void visitMinus(MinusExp e) => visitOpExp(e, "SUB");

  @override
  void visitNumber(NumberExp e) => _stackVals = 'PUSH ' + e.value.toString();

  @override
  void visitPlus(PlusExp e) => visitOpExp(e, 'SUM');

  @override
  void visitTimes(TimesExp e) => visitOpExp(e, 'MUL');
}
