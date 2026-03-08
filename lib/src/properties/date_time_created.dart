import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/date_time.dart';

/// RFC2445 Section 4.8.7.1
class DateTimeCreatedProperty extends CalendarProperty<DateTimeValue> {
  DateTimeCreatedProperty(DateTime value)
      : super("CREATED", DateTimeValue(value));

  factory DateTimeCreatedProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "CREATED",
      "Received invalid property: ${property.name}",
    );

    return DateTimeCreatedProperty(
      DateTimeValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
