import 'package:intl/intl.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_value.dart';
import '../parameters/time_zone_identifier.dart';

const _defaultFixed = true;

/// RFC2445 Section 4.3.12
class TimeValue extends CalendarValue<DateTime> {
  /// If set to [true], will fix the time
  /// value to either the supplied [timeZoneIdentifier]
  /// or to the `UTC` timezone by default
  ///
  /// Defaults to [true]
  final bool fixed;

  /// The [tzId] value of a [TimeZoneComponent]
  /// located inside the current calendar
  final String? timeZoneIdentifier;

  const TimeValue(
    DateTime value, {
    this.fixed = _defaultFixed,
    this.timeZoneIdentifier,
  }) : super(value, ValueType.time);

  factory TimeValue.fromCrawledStringValue(
    String value, {
    String? timeZoneIdentifier,
  }) =>
      TimeValue(
        DateFormat("HHmmss").parse(
          value.toUpperCase(),
          value.toUpperCase().endsWith("Z"),
        ),
        fixed: value.toUpperCase().endsWith("Z") || timeZoneIdentifier != null,
        timeZoneIdentifier: timeZoneIdentifier,
      );

  @override
  String sanitizeToString() {
    DateTime sanitizedValue = value;

    if (fixed && timeZoneIdentifier == null && !value.isUtc) {
      sanitizedValue = value.toUtc();
    }

    return "${DateFormat("HHmmss").format(sanitizedValue)}${sanitizedValue.isUtc ? "Z" : ""}";
  }

  @override
  List<CalendarParameter> getInlineParameters() {
    if (fixed && timeZoneIdentifier != null) {
      return [
        TimeZoneIdentifierParameter(timeZoneIdentifier!),
      ];
    }

    return [];
  }
}

class TimeParameterValue extends TimeValue with CalendarParameterValue {
  TimeParameterValue(
    DateTime value, {
    bool fixed = _defaultFixed,
    String? timeZoneIdentifier,
  }) : super(
          value,
          fixed: fixed,
          timeZoneIdentifier: timeZoneIdentifier,
        );
}
