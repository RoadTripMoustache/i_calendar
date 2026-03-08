import 'calendar_value.dart';

/// Meant for structured values
/// separated by Semicolons (;)
abstract class CalendarMultiPartStructuredValue<InnerValue>
    extends CalendarValue<InnerValue> {
  const CalendarMultiPartStructuredValue(
    InnerValue value,
    ValueType type,
  ) : super(value, type);

  List<CalendarStructuredValuePart> getValueParts();

  @override
  String sanitizeToString() {
    final res = StringBuffer();
    res.writeAll(getValueParts(), ";");
    return res.toString();
  }
}

abstract class CalendarStructuredValuePart<InnerType>
    extends CalendarValue<InnerType> {
  final String partName;

  const CalendarStructuredValuePart(
    this.partName,
    InnerType value,
    ValueType type,
  ) : super(value, type);

  @override
  String toString() {
    final valStr = super.toString();
    return "${partName.toUpperCase()}=$valStr";
  }
}
