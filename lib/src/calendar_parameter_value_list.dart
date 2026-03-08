import 'calendar_parameter_value.dart';
import 'calendar_value_list.dart';

class CalendarParameterValueList<T extends CalendarParameterValue>
    extends CalendarValueList<T> with CalendarParameterValue {
  CalendarParameterValueList(List<T> values) : super(values);

  @override
  String toString() {
    validate();
    return sanitizeToString();
  }
}
