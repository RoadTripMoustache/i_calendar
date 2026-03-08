import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.7.3
class ProductIdentifierProperty extends CalendarProperty<TextValue> {
  ProductIdentifierProperty(String pid) : super("PRODID", TextValue(pid));

  factory ProductIdentifierProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "PRODID",
      "Received invalid property: ${property.name}",
    );

    return ProductIdentifierProperty(
      TextValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
