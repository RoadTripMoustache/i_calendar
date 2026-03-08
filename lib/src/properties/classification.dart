// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.1.3
class ClassificationProperty extends CalendarProperty<TextValue> {
  ClassificationProperty(ClassificationType type)
      : super(
          "CLASS",
          TextValue(type.value),
        );

  factory ClassificationProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "CLASS",
      "Received invalid property: ${property.name}",
    );

    return ClassificationProperty(
      ClassificationType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(property.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

enum ClassificationType {
  public,
  private,
  confidential,
}

extension ClassificationTypeStringValue on ClassificationType {
  String get value {
    switch (this) {
      case ClassificationType.public:
        return "PUBLIC";
      case ClassificationType.private:
        return "PRIVATE";
      case ClassificationType.confidential:
        return "CONFIDENTIAL";
    }
  }
}
