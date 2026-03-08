import '../calendar_parameter_value.dart';
import '../calendar_value.dart';

/// RFC2445 Section 4.3.13
class UriValue extends CalendarValue<Uri> {
  const UriValue(Uri value) : super(value, ValueType.uri);

  factory UriValue.fromCrawledStringValue(String value) =>
      UriValue(Uri.parse(value));
}

class UriParameterValue extends UriValue with CalendarParameterValue {
  UriParameterValue(Uri value) : super(value);
}
