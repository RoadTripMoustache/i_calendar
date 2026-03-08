// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.15
class RelationshipTypeParameter extends CalendarParameter<TextParameterValue> {
  final RelationshipType type;

  RelationshipTypeParameter(this.type)
      : super("RELTYPE", TextParameterValue(type.value));

  factory RelationshipTypeParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return RelationshipTypeParameter(
      RelationshipType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "RELTYPE";
}

enum RelationshipType {
  parent,
  child,
  sibling,
}

extension RelationshipTypeStringValue on RelationshipType {
  String get value {
    switch (this) {
      case RelationshipType.parent:
        return "PARENT";
      case RelationshipType.child:
        return "CHILD";
      case RelationshipType.sibling:
        return "SIBLING";
    }
  }
}
