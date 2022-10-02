import 'package:dartz/dartz.dart';
import 'package:html/parser.dart';

import 'error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException catch (e) {
      return Left(InvalidInputFailure(e.message));
    }
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    String parsedString = parse(document.body?.text).documentElement?.text ?? "";
    parsedString = parsedString.replaceAll("\n", " ");
    return parsedString;
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(String errorMessage) : super(errorMessage);
}
