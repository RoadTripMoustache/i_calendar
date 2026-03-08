import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/uri.dart';

/// RFC2445 Section 4.8.4.6
class URLProperty extends CalendarProperty<UriValue> {
  URLProperty(Uri value) : super("URL", UriValue(value));

  factory URLProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "URL",
      "Received invalid property: ${property.name}",
    );

    return URLProperty(
      UriValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
