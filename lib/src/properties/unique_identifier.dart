import 'package:nanoid/nanoid.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.4.7
class UniqueIdentifierProperty extends CalendarProperty<TextValue> {
  UniqueIdentifierProperty({
    String? value,
  }) : super("UID", TextValue(value ?? nanoid(32)));

  factory UniqueIdentifierProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "UID",
      "Received invalid property: ${property.name}",
    );

    return UniqueIdentifierProperty(
      value: TextValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
