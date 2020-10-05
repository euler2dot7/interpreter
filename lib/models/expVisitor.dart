import 'apt.dart';
abstract class ExpVisitor {

  void visit(Exp e) {
    switch (e.runtimeType) {
      case PlusExp:
        visitPlus(e);
        break;
      case MinusExp:
        visitMinus(e);
        break;
      case TimesExp:
        visitTimes(e);
        break;
      case DivExp:
        visitDiv(e);
        break;
      case NumberExp:
        visitNumber(e);
        break;
    }
  }

  void visitPlus(PlusExp e);

  void visitMinus(MinusExp e);

  void visitTimes(TimesExp e);

  void visitDiv(DivExp e);

  void visitNumber(NumberExp e);
}
