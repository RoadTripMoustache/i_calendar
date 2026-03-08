import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/duration.dart';

/// RFC2445 Section 4.8.2.5
class DurationProperty extends CalendarProperty<DurationValue> {
  DurationProperty(Duration value)
      : assert(
          !value.isNegative,
          "Duration must be positive",
        ),
        super("DURATION", DurationValue(value));

  factory DurationProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "DURATION",
      "Received invalid property: ${property.name}",
    );

    return DurationProperty(
      DurationValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
