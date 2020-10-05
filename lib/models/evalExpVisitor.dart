import 'apt.dart';
import 'expVisitor.dart';

class EvalExpVisitor extends ExpVisitor {
  double value = 0.0;

  double getEvaluation() => value;

  @override
  void visitDiv(DivExp e) => eval(e, (l, r) => value = l / r);

  @override
  void visitMinus(MinusExp e) => eval(e, (l, r) => value = l - r);

  @override
  void visitPlus(PlusExp e) => eval(e, (l, r) => value = l + r);

  @override
  void visitTimes(TimesExp e) => eval(e, (l, r) => value = l * r);

  @override
  void visitNumber(NumberExp e) => value = e.value;

  void eval(OpExp e, Function(double, double) callback) {
    e.left.accept(this);
    final leftResult = getEvaluation();
    e.right.accept(this);
    final rightResult = getEvaluation();
    callback(leftResult, rightResult);
  }
}
