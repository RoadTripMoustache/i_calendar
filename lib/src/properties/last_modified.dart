import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/date_time.dart';

/// RFC2445 Section 4.8.7.3
class LastModifiedProperty extends CalendarProperty<DateTimeValue> {
  LastModifiedProperty(DateTime value)
      : super("LAST-MODIFIED", DateTimeValue(value));

  factory LastModifiedProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "LAST-MODIFIED",
      "Received invalid property: ${property.name}",
    );

    return LastModifiedProperty(
      DateTimeValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
