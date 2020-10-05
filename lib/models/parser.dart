import 'apt.dart';
import 'lexer.dart';

abstract class IParserExp {
  Exp getAst();
}

class ParserExp implements IParserExp {
  String _currentToken;
  final ILexer _lexer;

  ParserExp(this._lexer) : _currentToken = _lexer.getNextToken();

  @override
  Exp getAst() => _parseExp();

  Exp _parseExp() {
    Exp termSeq = _parseTerm();
    while (_currentToken != null) {
      if (_currentToken == "+") {
        _currentToken = _lexer.getNextToken();
        Exp nextTerm = _parseTerm();
        if (nextTerm != null)
          // build left part of APT
          termSeq = new PlusExp(termSeq, nextTerm);
        else
          return null;
      } else if (_currentToken == "-") {
        _currentToken = _lexer.getNextToken();
        Exp nextTerm = _parseTerm();
        if (nextTerm != null)
          // build left part of APT
          termSeq = new MinusExp(termSeq, nextTerm);
        else
          return null;
      } else
        return termSeq;
    }
    return termSeq;
  }

  Exp _parseTerm() {
    Exp factorSeq = _parseFactor();
    while (_currentToken != null) {
      if (_currentToken == '*') {
        _currentToken = _lexer.getNextToken();
        Exp nextFactor = _parseFactor();
        if (nextFactor != null)
          // build left part of APT
          factorSeq = new TimesExp(factorSeq, nextFactor);
        else
          return null;
      } else if (_currentToken == '/') {
        _currentToken = _lexer.getNextToken();
        Exp nextFactor = _parseFactor();
        if (nextFactor != null)
          // build left part of APT
          factorSeq = new DivExp(factorSeq, nextFactor);
        else
          return null;
      } else
        return factorSeq;
    }
    return factorSeq;
  }

  Exp _parseFactor() {
    if (_currentToken == '(') {
      _currentToken = _lexer.getNextToken();
      Exp innerExp = _parseExp();
      // PDA: manage self-embedding part
      if (_currentToken == ')') {
        _currentToken = _lexer.getNextToken();
        return innerExp;
        // remove brackets
      } else
        return null;
    } else if (_isNumeric(_currentToken)) {
      double value = double.parse(_currentToken);
      _currentToken = _lexer.getNextToken();
      return new NumberExp(value);
    } else
      return null;
  }

  static bool _isNumeric(String str) => (str != null) && double.tryParse(str) != null;
}
