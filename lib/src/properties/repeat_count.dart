import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/integer.dart';

/// RFC2445 Section 4.8.6.2
class RepeatCountProperty extends CalendarProperty<IntegerValue> {
  RepeatCountProperty(int value)
      : assert(value >= 0, "value must be greater than 0"),
        super("REPEAT", IntegerValue(value));

  factory RepeatCountProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "REPEAT",
      "Received invalid property: ${property.name}",
    );

    return RepeatCountProperty(
      IntegerValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
