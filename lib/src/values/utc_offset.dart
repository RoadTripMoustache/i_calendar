import '../calendar_value.dart';

/// RFC2445 Section 4.3.14
class UTCOffsetValue extends CalendarValue<Duration> {
  const UTCOffsetValue(Duration value) : super(value, ValueType.utcOffset);

  factory UTCOffsetValue.fromCrawledStringValue(String value) {
    int negativeMultiplier = 1;
    int intVal;

    if (num.tryParse(value[0]) == null) {
      negativeMultiplier = value[0] == "-" ? -1 : 1;
      intVal = int.parse(value.substring(1));
    } else {
      intVal = int.parse(value);
    }

    intVal *= negativeMultiplier;

    final minutes = intVal.remainder(100);
    final hours = ((intVal - minutes) / 100).floor();

    return UTCOffsetValue(
      Duration(
        hours: hours,
        minutes: minutes,
      ),
    );
  }

  @override
  String sanitizeToString() {
    final res = StringBuffer();
    final absOffset = value.abs();
    final minutes = absOffset.inMinutes - (absOffset.inHours * 60);
    final hours = absOffset.inHours + (minutes == 60 ? 1 : 0);
    if (value.isNegative) res.write("-");
    res.write("$hours".padLeft(2, "0"));
    res.write(minutes == 60 ? "00" : "$minutes".padLeft(2, "0"));
    return res.toString();
  }
}
