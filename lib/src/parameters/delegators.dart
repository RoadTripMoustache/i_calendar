import '../calendar_parameter.dart';
import '../calendar_parameter_value_list.dart';
import '../calendar_value_list.dart';
import '../models/craweled_parameter.dart';
import '../values/calendar_user_address.dart';

/// RFC2445 Section 4.2.4
class DelegatorsParameter extends CalendarParameter<
    CalendarParameterValueList<CalendarUserAddressParameterValue>> {
  final List<String> emails;

  DelegatorsParameter(this.emails)
      : super(
          "DELEGATED-FROM",
          CalendarParameterValueList(
            emails.map((e) => CalendarUserAddressParameterValue(e)).toList(),
          ),
        );

  factory DelegatorsParameter.fromCrawledParameter(CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return DelegatorsParameter(
      CalendarValueList.fromCrawledStringValue(parameter.value,
              (elem) => CalendarUserAddressValue.fromCrawledStringValue(elem))
          .values
          .map((e) => e.value)
          .toList(),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "DELEGATED-FROM";
}
