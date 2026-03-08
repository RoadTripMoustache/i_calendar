import '../calendar_parameter.dart';
import '../calendar_parameter_value_list.dart';
import '../calendar_value_list.dart';
import '../models/craweled_parameter.dart';
import '../values/calendar_user_address.dart';

/// RFC2445 Section 4.2.11
class GroupOrListMembershipParameter extends CalendarParameter<
    CalendarParameterValueList<CalendarUserAddressParameterValue>> {
  final List<String> emails;

  GroupOrListMembershipParameter(this.emails)
      : super(
          "MEMBER",
          CalendarParameterValueList(
            emails.map((e) => CalendarUserAddressParameterValue(e)).toList(),
          ),
        );

  factory GroupOrListMembershipParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return GroupOrListMembershipParameter(
      CalendarValueList.fromCrawledStringValue(
        parameter.value,
        (elem) => CalendarUserAddressValue.fromCrawledStringValue(elem),
      ).values.map((e) => e.value).toList(),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "MEMBER";
}
