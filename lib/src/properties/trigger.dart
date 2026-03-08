// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../calendar_value.dart';
import '../models/crawled_property.dart';
import '../parameters/alarm_trigger_relationship.dart';
import '../parameters/value_data_type.dart';
import '../values/date_time.dart';
import '../values/duration.dart';

/// RFC2445 Section 4.8.6.3
class DateTimeTriggerProperty extends CalendarProperty<DateTimeValue> {
  DateTimeTriggerProperty(DateTime value)
      : super("TRIGGER", DateTimeValue(value));

  factory DateTimeTriggerProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "TRIGGER",
      "Received invalid property: ${property.name}",
    );

    return DateTimeTriggerProperty(
      DateTimeValue.fromCrawledStringValue(property.value).value,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      ValueDataTypeParameter(ValueType.dateTime),
    ];
  }
}

/// RFC2445 Section 4.8.6.3
class DurationTriggerProperty extends CalendarProperty<DurationValue> {
  final AlarmTriggerRelationshipType? relationshipType;

  DurationTriggerProperty(
    Duration value, {
    this.relationshipType,
  }) : super("TRIGGER", DurationValue(value));

  factory DurationTriggerProperty.fromCrawledProperty(
      CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "TRIGGER",
      "Received invalid property: ${property.name}",
    );

    return DurationTriggerProperty(
      DurationValue.fromCrawledStringValue(property.value).value,
      relationshipType: property.parameters
              .where(AlarmTriggerRelationshipParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(AlarmTriggerRelationshipParameter.testCrawledParameter)
              .map((e) =>
                  AlarmTriggerRelationshipParameter.fromCrawledParameter(e))
              .first
              .type,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      ValueDataTypeParameter(ValueType.duration),
      if (relationshipType != null)
        AlarmTriggerRelationshipParameter(relationshipType!),
    ];
  }
}
