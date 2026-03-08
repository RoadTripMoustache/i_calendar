import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.2
class CommonNameParameter extends CalendarParameter<TextParameterValue> {
  final String commonName;

  CommonNameParameter(this.commonName)
      : super(
          "CN",
          TextParameterValue(commonName),
        );

  factory CommonNameParameter.fromCrawledParameter(CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return CommonNameParameter(
      TextValue.fromCrawledStringValue(parameter.value).value,
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "CN";
}
