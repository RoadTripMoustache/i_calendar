import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/uri.dart';

/// RFC2445 Section 4.2.1
class AlternateTextRepresentationParameter
    extends CalendarParameter<UriParameterValue> {
  final Uri uri;
  AlternateTextRepresentationParameter(
    this.uri,
  ) : super(
          "ALTREP",
          UriParameterValue(uri),
        );

  factory AlternateTextRepresentationParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return AlternateTextRepresentationParameter(
      UriValue.fromCrawledStringValue(parameter.value).value,
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "ALTREP";
}
