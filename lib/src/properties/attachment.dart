import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../calendar_value.dart';
import '../models/crawled_property.dart';
import '../parameters/format_type.dart';
import '../parameters/value_data_type.dart';
import '../values/binary.dart';
import '../values/uri.dart';

/// RFC2445 Section 4.8.1.1
class UriAttachmentProperty extends CalendarProperty<UriValue> {
  UriAttachmentProperty(Uri value) : super("ATTACH", UriValue(value));

  factory UriAttachmentProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "ATTACH",
      "Received invalid property: ${property.name}",
    );

    return UriAttachmentProperty(Uri.parse(property.value));
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      ValueDataTypeParameter(ValueType.uri),
    ];
  }
}

/// RFC2445 Section 4.8.1.1
class BinaryAttachmentProperty extends CalendarProperty<BinaryValue> {
  final ContentType? contentType;

  BinaryAttachmentProperty(
    Uint8List value, {
    this.contentType,
  }) : super("ATTACH", BinaryValue(value));

  factory BinaryAttachmentProperty.fromCrawledProperty(
    CrawledProperty property,
  ) {
    assert(
      property.name.toUpperCase() == "ATTACH",
      "Received invalid property: ${property.name}",
    );

    if (property.parameters.isEmpty ||
        !property.parameters
            .any((element) => element.name.toUpperCase() == "FMTTYPE")) {
      return BinaryAttachmentProperty(
        base64Decode(property.value),
      );
    }

    final contentTypeValue = property.parameters
        .firstWhere((element) => element.name.toUpperCase() == "FMTTYPE");

    return BinaryAttachmentProperty(
      base64Decode(property.value),
      contentType: ContentType.parse(contentTypeValue.value),
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      if (contentType != null) FormatTypeParameter(contentType!),
    ];
  }
}
