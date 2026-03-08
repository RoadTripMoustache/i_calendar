import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/uri.dart';

/// RFC2445 Section 4.8.3.5
class TimeZoneUrlProperty extends CalendarProperty<UriValue> {
  TimeZoneUrlProperty(Uri value) : super("TZURL", UriValue(value));

  factory TimeZoneUrlProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "TZURL",
      "Received invalid property: ${property.name}",
    );

    return TimeZoneUrlProperty(
      UriValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
