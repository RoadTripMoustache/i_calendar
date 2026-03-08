import 'package:intl/locale.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../parameters/alternate_text_representation.dart';
import '../parameters/language.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.4.2
class ContactProperty extends CalendarProperty<TextValue> {
  final Uri? alternateTextRepresentation;
  final Locale? locale;

  ContactProperty(
    String value, {
    this.alternateTextRepresentation,
    this.locale,
  }) : super("CONTACT", TextValue(value));

  factory ContactProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "CONTACT",
      "Received invalid property: ${property.name}",
    );

    return ContactProperty(
      TextValue.fromCrawledStringValue(property.value).value,
      locale: property.parameters
              .where(LanguageParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(LanguageParameter.testCrawledParameter)
              .map((e) => LanguageParameter.fromCrawledParameter(e))
              .first
              .locale,
      alternateTextRepresentation: property.parameters
              .where(AlternateTextRepresentationParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(AlternateTextRepresentationParameter.testCrawledParameter)
              .map((e) =>
                  AlternateTextRepresentationParameter.fromCrawledParameter(e))
              .first
              .uri,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      if (alternateTextRepresentation != null)
        AlternateTextRepresentationParameter(alternateTextRepresentation!),
      if (locale != null) LanguageParameter(locale!),
    ];
  }
}
