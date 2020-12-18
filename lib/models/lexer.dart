abstract class ILexer {
  String getNextToken();
}

class RegExpLexer implements ILexer {
  final String _input;
  int _index = 0;
  List<String> tokens;

  RegExpLexer(this._input) {
    tokens = _input.replaceAll(" ", "").split(new RegExp('(?<=\\d)(?=\\D)|(?<=\\D)'));
  }

  @override
  String getNextToken() {
    String result;
    if (_index < tokens.length) {
      result = tokens[_index];
      _index++;
    }
    return result;
  }
}
