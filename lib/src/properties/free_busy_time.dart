import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../parameters/free_busy_time_type.dart';
import '../values/period_of_time.dart';

/// RFC2445 Section 4.8.2.6
class FreeBusyTimeProperty extends CalendarProperty<PeriodOfTimeValue> {
  final FreeBusyTimeType? type;

  FreeBusyTimeProperty({
    required DateTime start,
    DateTime? end,
    Duration? duration,
    this.type,
  }) : super(
          "FREEBUSY",
          PeriodOfTimeValue(
            start: start,
            end: end,
            duration: duration,
          ),
        );

  const FreeBusyTimeProperty.fromValue(
    PeriodOfTimeValue value, {
    this.type,
  }) : super("FREEBUSY", value);

  factory FreeBusyTimeProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "FREEBUSY",
      "Received invalid property: ${property.name}",
    );

    return FreeBusyTimeProperty.fromValue(
      PeriodOfTimeValue.fromCrawledStringValue(property.value),
      type: property.parameters
              .where(FreeBusyTimeTypeParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(FreeBusyTimeTypeParameter.testCrawledParameter)
              .map((e) => FreeBusyTimeTypeParameter.fromCrawledParameter(e))
              .first
              .type,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      if (type != null) FreeBusyTimeTypeParameter(type!),
    ];
  }
}
