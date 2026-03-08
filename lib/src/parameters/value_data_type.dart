import '../calendar_parameter.dart';
import '../calendar_value.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.18
class ValueDataTypeParameter extends CalendarParameter<TextParameterValue> {
  final ValueType type;

  ValueDataTypeParameter(this.type)
      : super("VALUE", TextParameterValue(type.value));

  factory ValueDataTypeParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return ValueDataTypeParameter(
      ValueType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "VALUE";
}
