// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../parameters/relationship_type.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.4.5
class RelatedToProperty extends CalendarProperty<TextValue> {
  final RelationshipType? type;

  RelatedToProperty(
    String uid, {
    this.type,
  }) : super("RELATED-TO", TextValue(uid));

  factory RelatedToProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "RELATED-TO",
      "Received invalid property: ${property.name}",
    );

    return RelatedToProperty(
      TextValue.fromCrawledStringValue(property.value).value,
      type: property.parameters
              .where(RelationshipTypeParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(RelationshipTypeParameter.testCrawledParameter)
              .map((e) => RelationshipTypeParameter.fromCrawledParameter(e))
              .first
              .type,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      if (type != null) RelationshipTypeParameter(type!),
    ];
  }
}
