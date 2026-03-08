import '../calendar_multi_part_structured_value.dart';
import '../calendar_parameter_value.dart';
import '../calendar_value.dart';
import '../models/recurrence_rule.dart';
import 'date_time.dart';
import 'integer.dart';

/// RFC2445 Section 4.3.10
class RecurrenceRuleValue
    extends CalendarMultiPartStructuredValue<RecurrenceRule> {
  RecurrenceRuleValue({
    required RecurrenceFrequency frequency,
    int interval = RecurrenceRule.defaultInterval,
    RecurrenceWeekday startOfWorkWeek = RecurrenceRule.defaultStartOfWorkWeek,
    DateTime? until,
    int? count,
    Set<int>? bySeconds,
    Set<int>? byMinutes,
    Set<int>? byHours,
    Set<RecurrenceByDay>? byDays,
    Set<int>? byMonthDays,
    Set<int>? byYearDays,
    Set<int>? byWeekNumbers,
    Set<int>? byMonths,
    Set<int>? bySetPositions,
  }) : super(
          RecurrenceRule(
            frequency: frequency,
            interval: interval,
            startOfWorkWeek: startOfWorkWeek,
            until: until,
            count: count,
            bySeconds: bySeconds,
            byMinutes: byMinutes,
            byHours: byHours,
            byDays: byDays,
            byMonthDays: byMonthDays,
            byYearDays: byYearDays,
            byWeekNumbers: byWeekNumbers,
            byMonths: byMonths,
            bySetPositions: bySetPositions,
          ),
          ValueType.recur,
        );

  factory RecurrenceRuleValue.fromCrawledStringValue(
    String value, {
    String? timeZoneIdentifier,
  }) {
    RecurrenceFrequency? frequency;
    int interval = RecurrenceRule.defaultInterval;
    RecurrenceWeekday startOfWorkWeek = RecurrenceRule.defaultStartOfWorkWeek;
    DateTime? until;
    int? count;
    Set<int>? bySeconds;
    Set<int>? byMinutes;
    Set<int>? byHours;
    Set<RecurrenceByDay>? byDays;
    Set<int>? byMonthDays;
    Set<int>? byYearDays;
    Set<int>? byWeekNumbers;
    Set<int>? byMonths;
    Set<int>? bySetPositions;

    value.split(";").forEach((e) {
      final name = e.split("=").first;
      final value = e.split("=").last;

      switch (name.toUpperCase()) {
        case "FREQ":
          frequency = RecurrenceFrequency.values.firstWhere(
            (element) => element.value.toUpperCase() == value.toUpperCase(),
          );
          break;
        case "UNTIL":
          until = DateTimeValue.fromCrawledStringValue(
            value,
            timeZoneIdentifier: timeZoneIdentifier,
          ).value;
          break;
        case "COUNT":
          count = IntegerValue.fromCrawledStringValue(value).value;
          break;
        case "INTERVAL":
          interval = IntegerValue.fromCrawledStringValue(value).value;
          break;
        case "BYSECOND":
          bySeconds = value
              .split(",")
              .map((e) => IntegerValue.fromCrawledStringValue(e).value)
              .toSet();
          break;
        case "BYMINUTE":
          byMinutes = value
              .split(",")
              .map((e) => IntegerValue.fromCrawledStringValue(e).value)
              .toSet();
          break;
        case "BYHOUR":
          byHours = value
              .split(",")
              .map((e) => IntegerValue.fromCrawledStringValue(e).value)
              .toSet();
          break;
        case "BYDAY":
          byDays = _ByDayValuePart.fromCrawledStringValue(value).value;
          break;
        case "BYMONTHDAY":
          byMonthDays = value
              .split(",")
              .map((e) => IntegerValue.fromCrawledStringValue(e).value)
              .toSet();
          break;
        case "BYYEARDAY":
          byYearDays = value
              .split(",")
              .map((e) => IntegerValue.fromCrawledStringValue(e).value)
              .toSet();
          break;
        case "BYWEEKNO":
          byWeekNumbers = value
              .split(",")
              .map((e) => IntegerValue.fromCrawledStringValue(e).value)
              .toSet();
          break;
        case "BYMONTH":
          byMonths = value
              .split(",")
              .map((e) => IntegerValue.fromCrawledStringValue(e).value)
              .toSet();
          break;
        case "BYSETPOS":
          bySetPositions = value
              .split(",")
              .map((e) => IntegerValue.fromCrawledStringValue(e).value)
              .toSet();
          break;
        case "WKST":
          startOfWorkWeek = RecurrenceWeekday.values.firstWhere(
              (element) => element.value.toUpperCase() == value.toUpperCase());
          break;
      }
    });

    assert(frequency != null, "Frequency must be provided");

    return RecurrenceRuleValue(
      frequency: frequency!,
      interval: interval,
      startOfWorkWeek: startOfWorkWeek,
      until: until,
      count: count,
      bySeconds: bySeconds,
      byMinutes: byMinutes,
      byHours: byHours,
      byDays: byDays,
      byMonthDays: byMonthDays,
      byYearDays: byYearDays,
      byWeekNumbers: byWeekNumbers,
      byMonths: byMonths,
      bySetPositions: bySetPositions,
    );
  }

  @override
  List<CalendarStructuredValuePart> getValueParts() {
    return [
      _FreqValuePart(value.frequency),
      if (value.until != null) _UntilValuePart(value.until!),
      if (value.count != null) _CountValuePart(value.count!),
      _IntervalValuePart(value.interval),
      if (value.bySeconds != null && value.bySeconds!.isNotEmpty)
        _BySecondValuePart(value.bySeconds!),
      if (value.byMinutes != null && value.byMinutes!.isNotEmpty)
        _ByMinuteValuePart(value.byMinutes!),
      if (value.byHours != null && value.byHours!.isNotEmpty)
        _ByHourValuePart(value.byHours!),
      if (value.byDays != null && value.byDays!.isNotEmpty)
        _ByDayValuePart(value.byDays!),
      if (value.byMonthDays != null && value.byMonthDays!.isNotEmpty)
        _ByMonthDayValuePart(value.byMonthDays!),
      if (value.byYearDays != null && value.byYearDays!.isNotEmpty)
        _ByYearDayValuePart(value.byYearDays!),
      if (value.byWeekNumbers != null && value.byWeekNumbers!.isNotEmpty)
        _ByWeekNoValuePart(value.byWeekNumbers!),
      if (value.byMonths != null && value.byMonths!.isNotEmpty)
        _ByMonthValuePart(value.byMonths!),
      if (value.bySetPositions != null && value.bySetPositions!.isNotEmpty)
        _BySetPosValuePart(value.bySetPositions!),
      _WkstValuePart(value.startOfWorkWeek),
    ];
  }
}

class RecurrenceRuleParameterValue extends RecurrenceRuleValue
    with CalendarParameterValue {
  RecurrenceRuleParameterValue({
    required RecurrenceFrequency frequency,
    int interval = RecurrenceRule.defaultInterval,
    RecurrenceWeekday startOfWorkWeek = RecurrenceRule.defaultStartOfWorkWeek,
    DateTime? until,
    int? count,
    Set<int>? bySeconds,
    Set<int>? byMinutes,
    Set<int>? byHours,
    Set<RecurrenceByDay>? byDays,
    Set<int>? byMonthDays,
    Set<int>? byYearDays,
    Set<int>? byWeekNumbers,
    Set<int>? byMonths,
    Set<int>? bySetPositions,
  }) : super(
          frequency: frequency,
          interval: interval,
          startOfWorkWeek: startOfWorkWeek,
          until: until,
          count: count,
          bySeconds: bySeconds,
          byMinutes: byMinutes,
          byHours: byHours,
          byDays: byDays,
          byMonthDays: byMonthDays,
          byYearDays: byYearDays,
          byWeekNumbers: byWeekNumbers,
          byMonths: byMonths,
          bySetPositions: bySetPositions,
        );
}

class _FreqValuePart extends CalendarStructuredValuePart<RecurrenceFrequency> {
  const _FreqValuePart(RecurrenceFrequency value)
      : super("FREQ", value, ValueType.text);

  @override
  String sanitizeToString() {
    return value.value;
  }
}

class _UntilValuePart extends CalendarStructuredValuePart<DateTime> {
  const _UntilValuePart(DateTime value)
      : super("UNTIL", value, ValueType.dateTime);

  @override
  String sanitizeToString() {
    return DateTimeValue(value, fixed: true).toString();
  }
}

class _CountValuePart extends CalendarStructuredValuePart<int> {
  const _CountValuePart(int value) : super("COUNT", value, ValueType.integer);
}

class _IntervalValuePart extends CalendarStructuredValuePart<int> {
  const _IntervalValuePart(int value)
      : super("INTERVAL", value, ValueType.integer);
}

class _BySecondValuePart extends CalendarStructuredValuePart<Set<int>> {
  const _BySecondValuePart(Set<int> value)
      : super("BYSECOND", value, ValueType.integer);

  @override
  String sanitizeToString() {
    return value.join(",");
  }
}

class _ByMinuteValuePart extends CalendarStructuredValuePart<Set<int>> {
  const _ByMinuteValuePart(Set<int> value)
      : super("BYMINUTE", value, ValueType.integer);

  @override
  String sanitizeToString() {
    return value.join(",");
  }
}

class _ByHourValuePart extends CalendarStructuredValuePart<Set<int>> {
  const _ByHourValuePart(Set<int> value)
      : super("BYHOUR", value, ValueType.integer);

  @override
  String sanitizeToString() {
    return value.join(",");
  }
}

class _ByDayValuePart
    extends CalendarStructuredValuePart<Set<RecurrenceByDay>> {
  const _ByDayValuePart(
    Set<RecurrenceByDay> value,
  ) : super("BYDAY", value, ValueType.text);

  factory _ByDayValuePart.fromCrawledStringValue(String value) {
    return _ByDayValuePart(
      value.split(",").map((e) {
        final byDayRegexp = RegExp(
          r'(-{0,1}[0-9]+){0,1}(MO|TU|WE|TH|FR|SA|SU){1}',
          caseSensitive: false,
        );

        final rbdMatch = byDayRegexp.firstMatch(e)!;

        return RecurrenceByDay(
          RecurrenceWeekday.values.firstWhere(
            (element) =>
                element.value.toUpperCase() == rbdMatch.group(2)!.toUpperCase(),
          ),
          occurrence: rbdMatch.group(1) == null
              ? null
              : IntegerValue.fromCrawledStringValue(rbdMatch.group(1)!).value,
        );
      }).toSet(),
    );
  }

  @override
  String sanitizeToString() {
    final res = StringBuffer();
    res.writeAll(
      value.map((e) => "${e.occurrence ?? ""}${e.weekday.value}"),
      ",",
    );
    return res.toString();
  }
}

class _ByMonthDayValuePart extends CalendarStructuredValuePart<Set<int>> {
  const _ByMonthDayValuePart(Set<int> value)
      : super("BYMONTHDAY", value, ValueType.integer);

  @override
  String sanitizeToString() {
    return value.join(",");
  }
}

class _ByYearDayValuePart extends CalendarStructuredValuePart<Set<int>> {
  const _ByYearDayValuePart(Set<int> value)
      : super("BYYEARDAY", value, ValueType.integer);

  @override
  String sanitizeToString() {
    return value.join(",");
  }
}

class _ByWeekNoValuePart extends CalendarStructuredValuePart<Set<int>> {
  const _ByWeekNoValuePart(Set<int> value)
      : super("BYWEEKNO", value, ValueType.integer);

  @override
  String sanitizeToString() {
    return value.join(",");
  }
}

class _ByMonthValuePart extends CalendarStructuredValuePart<Set<int>> {
  const _ByMonthValuePart(Set<int> value)
      : super("BYMONTH", value, ValueType.integer);

  @override
  String sanitizeToString() {
    return value.join(",");
  }
}

class _BySetPosValuePart extends CalendarStructuredValuePart<Set<int>> {
  const _BySetPosValuePart(Set<int> value)
      : super("BYSETPOS", value, ValueType.integer);

  @override
  String sanitizeToString() {
    return value.join(",");
  }
}

class _WkstValuePart extends CalendarStructuredValuePart<RecurrenceWeekday> {
  const _WkstValuePart(RecurrenceWeekday value)
      : super("WKST", value, ValueType.text);

  @override
  String sanitizeToString() {
    return value.value;
  }
}
