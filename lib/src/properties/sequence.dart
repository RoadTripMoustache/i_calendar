import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/integer.dart';

/// RFC2445 Section 4.8.7.4
class SequenceProperty extends CalendarProperty<IntegerValue> {
  SequenceProperty(int value)
      : assert(value >= 0, "value must be positive"),
        super("SEQUENCE", IntegerValue(value));

  factory SequenceProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "SEQUENCE",
      "Received invalid property: ${property.name}",
    );

    return SequenceProperty(
      IntegerValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
