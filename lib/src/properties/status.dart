import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.1.11
class StatusProperty extends CalendarProperty<TextValue> {
  StatusProperty(StatusType type) : super("STATUS", TextValue(type.value));

  factory StatusProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "STATUS",
      "Received invalid property: ${property.name}",
    );

    return StatusProperty(
      StatusType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(property.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

enum StatusType {
  tentative,
  confirmed,
  cancelled,
  needsAction,
  completed,
  inProcess,
  draft,
  kFinal,
}

extension StatusTypeStringValue on StatusType {
  String get value {
    switch (this) {
      case StatusType.tentative:
        return "TENTATIVE";
      case StatusType.confirmed:
        return "CONFIRMED";
      case StatusType.cancelled:
        return "CANCELLED";
      case StatusType.needsAction:
        return "NEEDS-ACTION";
      case StatusType.completed:
        return "COMPLETED";
      case StatusType.inProcess:
        return "IN-PROCESS";
      case StatusType.draft:
        return "DRAFT";
      case StatusType.kFinal:
        return "FINAL";
    }
  }
}
