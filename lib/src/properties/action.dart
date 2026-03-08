// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../values/text.dart';

/// RFC2445 Section 4.8.6.1
class ActionProperty extends CalendarProperty<TextValue> {
  final ActionType type;

  ActionProperty(this.type) : super("ACTION", TextValue(type.value));

  factory ActionProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "ACTION",
      "Received invalid property: ${property.name}",
    );

    return ActionProperty(ActionType.values.firstWhere(
        (element) => element.value.toUpperCase() == property.value));
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [];
  }
}

enum ActionType {
  audio,
  display,
  email,
  procedure,
}

extension ActionTypeStringValue on ActionType {
  String get value {
    switch (this) {
      case ActionType.audio:
        return "AUDIO";
      case ActionType.display:
        return "DISPLAY";
      case ActionType.email:
        return "EMAIL";
      case ActionType.procedure:
        return "PROCEDURE";
    }
  }
}
