import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/float.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.1.6
class GeographicPositionProperty extends CalendarProperty<TextValue> {
  GeographicPositionProperty({
    required double lat,
    required double long,
  }) : super(
          "GEO",
          TextValue(
            "${FloatValue(lat)};${FloatValue(long)}",
            escapeCharacters: false,
          ),
        );

  factory GeographicPositionProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "GEO",
      "Received invalid property: ${property.name}",
    );

    return GeographicPositionProperty(
      lat: FloatValue.fromCrawledStringValue(property.value.split(";").first)
          .value,
      long: FloatValue.fromCrawledStringValue(property.value.split(";").last)
          .value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}
