import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.9
class FreeBusyTimeTypeParameter extends CalendarParameter<TextParameterValue> {
  final FreeBusyTimeType type;

  FreeBusyTimeTypeParameter(this.type)
      : super("FBTYPE", TextParameterValue(type.value));

  factory FreeBusyTimeTypeParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return FreeBusyTimeTypeParameter(
      FreeBusyTimeType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "FBTYPE";
}

enum FreeBusyTimeType {
  free,
  busy,
  busyUnavailable,
  busyTentative,
}

extension FreeBusyTimeTypeStringValue on FreeBusyTimeType {
  String get value {
    switch (this) {
      case FreeBusyTimeType.free:
        return "FREE";
      case FreeBusyTimeType.busy:
        return "BUSY";
      case FreeBusyTimeType.busyUnavailable:
        return "BUSY-UNAVAILABLE";
      case FreeBusyTimeType.busyTentative:
        return "BUSY-TENTATIVE";
    }
  }
}
