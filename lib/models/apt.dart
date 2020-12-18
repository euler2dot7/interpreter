import 'expVisitor.dart';
abstract class Exp {
  String toString();

  void accept(ExpVisitor visitor) => visitor.visit(this);
}

abstract class OpExp extends Exp {
  final Exp left, right;

  OpExp(this.left, this.right);

  String myOp();

  @override
  String toString() => '$left ${myOp()} $right';
}

class MinusExp extends OpExp {
  MinusExp(Exp left, Exp right) : super(left, right);

  @override
  String myOp() => "-";
}

class PlusExp extends OpExp {
  PlusExp(Exp left, Exp right) : super(left, right);

  @override
  String myOp() => "+";
}

class DivExp extends OpExp {
  DivExp(Exp left, Exp right) : super(left, right);

  @override
  String myOp() => "/";
}

class TimesExp extends OpExp {
  TimesExp(Exp left, Exp right) : super(left, right);

  @override
  String myOp() => "*";
}

class NumberExp extends Exp {
  final double _value;

  NumberExp(this._value);

  get value => _value;

  @override
  String toString() => '$_value';
}
