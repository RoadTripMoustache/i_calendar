import 'dart:io';

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.8
class FormatTypeParameter extends CalendarParameter<TextParameterValue> {
  FormatTypeParameter(ContentType type)
      : super("FMTTYPE", TextParameterValue(type.mimeType));

  factory FormatTypeParameter.fromCrawledParameter(CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return FormatTypeParameter(
      ContentType.parse(
        TextValue.fromCrawledStringValue(parameter.value).value,
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "FMTTYPE";
}
