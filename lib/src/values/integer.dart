import '../calendar_parameter_value.dart';
import '../calendar_value.dart';

/// RFC2445 Section 4.3.8
class IntegerValue extends CalendarValue<int> {
  const IntegerValue(int value) : super(value, ValueType.integer);

  factory IntegerValue.fromCrawledStringValue(String value) =>
      IntegerValue(int.parse(value));
}

class IntegerParameterValue extends IntegerValue with CalendarParameterValue {
  IntegerParameterValue(int value) : super(value);
}
