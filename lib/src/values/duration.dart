import '../calendar_parameter_value.dart';
import '../calendar_value.dart';

/// RFC2445 Section 4.3.6
class DurationValue extends CalendarValue<Duration> {
  /// Will produce a duration value that only
  /// accounts for the number of weeks.
  ///
  /// Ex: `Duration(days: 8, hours: 7, minutes: 2) == "P1W"`
  final bool inWeeks;

  const DurationValue(
    Duration value, {
    this.inWeeks = false,
  }) : super(value, ValueType.duration);

  factory DurationValue.fromCrawledStringValue(String value) {
    final durRegexp = RegExp(r'(?:([0-9]+)(D|W|H|M|S))', caseSensitive: false);
    final durMatches = durRegexp.allMatches(value);
    final hasWeeks = durMatches.map((e) => e.group(2)).any(
          (element) => element?.toUpperCase() == "W",
        );
    final hasDays = durMatches.map((e) => e.group(2)).any(
          (element) => element?.toUpperCase() == "D",
        );
    final hasHours = durMatches.map((e) => e.group(2)).any(
          (element) => element?.toUpperCase() == "H",
        );
    final hasMinutes = durMatches.map((e) => e.group(2)).any(
          (element) => element?.toUpperCase() == "M",
        );
    final hasSeconds = durMatches.map((e) => e.group(2)).any(
          (element) => element?.toUpperCase() == "S",
        );

    if (hasWeeks) {
      return DurationValue(
          Duration(
            days: int.parse(
              durMatches
                  .firstWhere(
                      (element) => element.group(2)?.toUpperCase() == "W")
                  .group(1)!,
            ),
          ),
          inWeeks: true);
    }

    return DurationValue(
      Duration(
        days: hasDays
            ? int.parse(
                durMatches
                    .firstWhere(
                        (element) => element.group(2)?.toUpperCase() == "D")
                    .group(1)!,
              )
            : 0,
        hours: hasHours
            ? int.parse(
                durMatches
                    .firstWhere(
                        (element) => element.group(2)?.toUpperCase() == "H")
                    .group(1)!,
              )
            : 0,
        minutes: hasMinutes
            ? int.parse(
                durMatches
                    .firstWhere(
                        (element) => element.group(2)?.toUpperCase() == "M")
                    .group(1)!,
              )
            : 0,
        seconds: hasSeconds
            ? int.parse(
                durMatches
                    .firstWhere(
                        (element) => element.group(2)?.toUpperCase() == "S")
                    .group(1)!,
              )
            : 0,
      ),
      inWeeks: false,
    );
  }

  @override
  String sanitizeToString() {
    final res = StringBuffer("${value.isNegative ? "-" : ""}P");
    final absDuration = value.abs();

    if (inWeeks) {
      final weeks = (absDuration.inDays / 7).floor();
      res.write("${weeks}W");
      return res.toString();
    }

    if (absDuration.inDays > 0) res.write("${absDuration.inDays}D");

    final hours = absDuration.inHours - (absDuration.inDays * 24);
    final minutes = absDuration.inMinutes - (absDuration.inHours * 60);
    final seconds = absDuration.inSeconds - (absDuration.inMinutes * 60);

    res.write("T${hours}H${minutes}M${seconds}S");

    return res.toString();
  }
}

class DurationParameterValue extends DurationValue with CalendarParameterValue {
  DurationParameterValue(Duration value) : super(value);
}
