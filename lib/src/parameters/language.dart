import 'package:intl/locale.dart';

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.10
class LanguageParameter extends CalendarParameter<TextParameterValue> {
  final Locale locale;

  LanguageParameter(this.locale)
      : super("LANGUAGE", TextParameterValue(locale.languageCode));

  factory LanguageParameter.fromCrawledParameter(CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return LanguageParameter(
      Locale.parse(
        TextValue.fromCrawledStringValue(parameter.value).value,
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "LANGUAGE";
}
