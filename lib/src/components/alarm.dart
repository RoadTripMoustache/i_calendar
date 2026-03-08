// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

import '../calendar_component.dart';
import '../calendar_property.dart';
import '../calendar_value.dart';
import '../models/crawled_block.dart';
import '../parameters/value_data_type.dart';
import '../properties/action.dart';
import '../properties/attachment.dart';
import '../properties/attendee.dart';
import '../properties/description.dart';
import '../properties/duration.dart';
import '../properties/repeat_count.dart';
import '../properties/summary.dart';
import '../properties/trigger.dart';

/// RFC2445 Section 4.6.6
class AudioAlarmComponent extends CalendarComponent {
  final DateTimeTriggerProperty? dateTimeTrigger;
  final DurationTriggerProperty? durationTrigger;
  final DurationProperty? duration;
  final RepeatCountProperty? repeatCount;
  final UriAttachmentProperty? uriAttachment;
  final BinaryAttachmentProperty? binaryAttachment;

  const AudioAlarmComponent({
    this.dateTimeTrigger,
    this.durationTrigger,
    this.duration,
    this.repeatCount,
    this.uriAttachment,
    this.binaryAttachment,
  })  : assert(
          (dateTimeTrigger != null) ^ (durationTrigger != null),
          "either dateTimeTrigger or durationTrigger must be provided, but not both",
        ),
        assert(
          (duration == null && repeatCount == null) ||
              (duration != null && repeatCount != null),
          "'duration' and 'repeatCount' are both optional, and MUST NOT occur more than once each, but if one occurs, so MUST the other",
        ),
        assert(
          uriAttachment == null || binaryAttachment == null,
          "cannot supply both uriAttachment and binaryAttachment",
        ),
        super("VALARM");

  factory AudioAlarmComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "VALARM",
      "Received invalid block: ${block.blockName}",
    );

    DateTimeTriggerProperty? dateTimeTrigger;
    DurationTriggerProperty? durationTrigger;
    DurationProperty? duration;
    RepeatCountProperty? repeatCount;
    UriAttachmentProperty? uriAttachment;
    BinaryAttachmentProperty? binaryAttachment;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "TRIGGER":
          {
            final isDuration = e.parameters.any(
              (element) =>
                  element.name.toUpperCase() == "VALUE" &&
                  ValueDataTypeParameter.fromCrawledParameter(element).type ==
                      ValueType.duration,
            );

            if (isDuration) {
              durationTrigger = DurationTriggerProperty.fromCrawledProperty(e);
            } else {
              dateTimeTrigger = DateTimeTriggerProperty.fromCrawledProperty(e);
            }
            break;
          }
        case "DURATION":
          duration = DurationProperty.fromCrawledProperty(e);
          break;
        case "REPEAT":
          repeatCount = RepeatCountProperty.fromCrawledProperty(e);
          break;
        case "ATTACH":
          {
            final isBinary = e.parameters.any(
              (element) =>
                  element.name.toUpperCase() == "VALUE" &&
                  ValueDataTypeParameter.fromCrawledParameter(element).type ==
                      ValueType.binary,
            );

            if (isBinary) {
              binaryAttachment =
                  BinaryAttachmentProperty.fromCrawledProperty(e);
            } else {
              uriAttachment = UriAttachmentProperty.fromCrawledProperty(e);
            }
            break;
          }

        default:
          print(
              "Unknown property encountered in AudioAlarmComponent: ${e.name}");
      }
    }

    return AudioAlarmComponent(
      dateTimeTrigger: dateTimeTrigger,
      durationTrigger: durationTrigger,
      duration: duration,
      repeatCount: repeatCount,
      uriAttachment: uriAttachment,
      binaryAttachment: binaryAttachment,
    );
  }

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return [
      ActionProperty(ActionType.audio),
      ...(<CalendarProperty<CalendarValue>?>[
        dateTimeTrigger,
        durationTrigger,
        duration,
        repeatCount,
        uriAttachment,
        binaryAttachment,
      ].where((element) => element != null).map((e) => e!).toList()),
    ];
  }
}

/// RFC2445 Section 4.6.6
class DisplayAlarmComponent extends CalendarComponent {
  final DateTimeTriggerProperty? dateTimeTrigger;
  final DurationTriggerProperty? durationTrigger;
  final DurationProperty? duration;
  final RepeatCountProperty? repeatCount;

  const DisplayAlarmComponent({
    this.dateTimeTrigger,
    this.durationTrigger,
    this.duration,
    this.repeatCount,
  })  : assert(
          (dateTimeTrigger != null) ^ (durationTrigger != null),
          "either dateTimeTrigger or durationTrigger must be provided, but not both",
        ),
        assert(
          (duration == null && repeatCount == null) ||
              (duration != null && repeatCount != null),
          "'duration' and 'repeatCount' are both optional, and MUST NOT occur more than once each, but if one occurs, so MUST the other",
        ),
        super("VALARM");

  factory DisplayAlarmComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "VALARM",
      "Received invalid block: ${block.blockName}",
    );

    DateTimeTriggerProperty? dateTimeTrigger;
    DurationTriggerProperty? durationTrigger;
    DurationProperty? duration;
    RepeatCountProperty? repeatCount;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "TRIGGER":
          {
            final isDuration = e.parameters.any(
              (element) =>
                  element.name.toUpperCase() == "VALUE" &&
                  ValueDataTypeParameter.fromCrawledParameter(element).type ==
                      ValueType.duration,
            );

            if (isDuration) {
              durationTrigger = DurationTriggerProperty.fromCrawledProperty(e);
            } else {
              dateTimeTrigger = DateTimeTriggerProperty.fromCrawledProperty(e);
            }
            break;
          }
        case "DURATION":
          duration = DurationProperty.fromCrawledProperty(e);
          break;
        case "REPEAT":
          repeatCount = RepeatCountProperty.fromCrawledProperty(e);
          break;

        default:
          print(
              "Unknown property encountered in DisplayAlarmComponent: ${e.name}");
      }
    }

    return DisplayAlarmComponent(
      dateTimeTrigger: dateTimeTrigger,
      durationTrigger: durationTrigger,
      duration: duration,
      repeatCount: repeatCount,
    );
  }

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return [
      ActionProperty(ActionType.display),
      ...(<CalendarProperty<CalendarValue>?>[
        dateTimeTrigger,
        durationTrigger,
        duration,
        repeatCount,
      ].where((element) => element != null).map((e) => e!).toList()),
    ];
  }
}

/// RFC2445 Section 4.6.6
class EmailAlarmComponent extends CalendarComponent {
  final DateTimeTriggerProperty? dateTimeTrigger;
  final DurationTriggerProperty? durationTrigger;
  final DescriptionProperty description;
  final SummaryProperty summary;
  final List<AttendeeProperty> attendees;
  final DurationProperty? duration;
  final RepeatCountProperty? repeatCount;
  final List<UriAttachmentProperty>? uriAttachments;
  final List<BinaryAttachmentProperty>? binaryAttachments;

  const EmailAlarmComponent({
    this.dateTimeTrigger,
    this.durationTrigger,
    required this.description,
    required this.summary,
    required this.attendees,
    this.duration,
    this.repeatCount,
    this.uriAttachments,
    this.binaryAttachments,
  })  : assert(
          (dateTimeTrigger != null) ^ (durationTrigger != null),
          "either dateTimeTrigger or durationTrigger must be provided, but not both",
        ),
        assert(
          (duration == null && repeatCount == null) ||
              (duration != null && repeatCount != null),
          "'duration' and 'repeatCount' are both optional, and MUST NOT occur more than once each, but if one occurs, so MUST the other",
        ),
        super("VALARM");

  factory EmailAlarmComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "VALARM",
      "Received invalid block: ${block.blockName}",
    );

    DateTimeTriggerProperty? dateTimeTrigger;
    DurationTriggerProperty? durationTrigger;
    DurationProperty? duration;
    RepeatCountProperty? repeatCount;
    List<UriAttachmentProperty>? uriAttachments;
    List<BinaryAttachmentProperty>? binaryAttachments;
    List<AttendeeProperty> attendees = [];
    DescriptionProperty? description;
    SummaryProperty? summary;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "TRIGGER":
          {
            final isDuration = e.parameters.any(
              (element) =>
                  element.name.toUpperCase() == "VALUE" &&
                  ValueDataTypeParameter.fromCrawledParameter(element).type ==
                      ValueType.duration,
            );

            if (isDuration) {
              durationTrigger = DurationTriggerProperty.fromCrawledProperty(e);
            } else {
              dateTimeTrigger = DateTimeTriggerProperty.fromCrawledProperty(e);
            }
            break;
          }
        case "DURATION":
          duration = DurationProperty.fromCrawledProperty(e);
          break;
        case "REPEAT":
          repeatCount = RepeatCountProperty.fromCrawledProperty(e);
          break;
        case "ATTACH":
          {
            final isBinary = e.parameters.any(
              (element) =>
                  element.name.toUpperCase() == "VALUE" &&
                  ValueDataTypeParameter.fromCrawledParameter(element).type ==
                      ValueType.binary,
            );

            if (isBinary) {
              binaryAttachments ??= [];
              binaryAttachments
                  .add(BinaryAttachmentProperty.fromCrawledProperty(e));
            } else {
              uriAttachments ??= [];
              uriAttachments.add(UriAttachmentProperty.fromCrawledProperty(e));
            }
            break;
          }
        case "ATTENDEE":
          attendees.add(AttendeeProperty.fromCrawledProperty(e));
          break;
        case "DESCRIPTION":
          description = DescriptionProperty.fromCrawledProperty(e);
          break;
        case "SUMMARY":
          summary = SummaryProperty.fromCrawledProperty(e);
          break;
        default:
          print(
              "Unknown property encountered in EmailAlarmComponent: ${e.name}");
      }
    }

    assert(
      description != null && summary != null,
      "[description] and [summary] cannot be null",
    );

    return EmailAlarmComponent(
      dateTimeTrigger: dateTimeTrigger,
      durationTrigger: durationTrigger,
      duration: duration,
      repeatCount: repeatCount,
      uriAttachments: uriAttachments,
      binaryAttachments: binaryAttachments,
      attendees: attendees,
      description: description!,
      summary: summary!,
    );
  }

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return [
      ActionProperty(ActionType.email),
      description,
      summary,
      ...attendees,
      ...(<CalendarProperty<CalendarValue>?>[
        dateTimeTrigger,
        durationTrigger,
        duration,
        repeatCount,
      ].where((element) => element != null).map((e) => e!).toList()),
      ...(<List<CalendarProperty<CalendarValue>>?>[
        uriAttachments,
        binaryAttachments,
      ]
          .where((element) => element != null)
          .map((e) => e!)
          .expand((element) => element)
          .toList()),
    ];
  }
}

/// RFC2445 Section 4.6.6
class ProcedureAlarmComponent extends CalendarComponent {
  final DateTimeTriggerProperty? dateTimeTrigger;
  final DurationTriggerProperty? durationTrigger;
  final UriAttachmentProperty? uriAttachment;
  final BinaryAttachmentProperty? binaryAttachment;
  final DurationProperty? duration;
  final RepeatCountProperty? repeatCount;
  final DescriptionProperty? description;

  const ProcedureAlarmComponent({
    this.dateTimeTrigger,
    this.durationTrigger,
    this.uriAttachment,
    this.binaryAttachment,
    this.duration,
    this.repeatCount,
    this.description,
  })  : assert(
          (dateTimeTrigger != null) ^ (durationTrigger != null),
          "either dateTimeTrigger or durationTrigger must be provided, but not both",
        ),
        assert(
          (uriAttachment != null) ^ (binaryAttachment != null),
          "either uriAttachment or binaryAttachment must be provided, but not both",
        ),
        assert(
          (duration == null && repeatCount == null) ||
              (duration != null && repeatCount != null),
          "'duration' and 'repeatCount' are both optional, and MUST NOT occur more than once each, but if one occurs, so MUST the other",
        ),
        super("VALARM");

  factory ProcedureAlarmComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "VALARM",
      "Received invalid block: ${block.blockName}",
    );

    DateTimeTriggerProperty? dateTimeTrigger;
    DurationTriggerProperty? durationTrigger;
    DurationProperty? duration;
    RepeatCountProperty? repeatCount;
    UriAttachmentProperty? uriAttachment;
    BinaryAttachmentProperty? binaryAttachment;
    DescriptionProperty? description;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "TRIGGER":
          {
            final isDuration = e.parameters.any(
              (element) =>
                  element.name.toUpperCase() == "VALUE" &&
                  ValueDataTypeParameter.fromCrawledParameter(element).type ==
                      ValueType.duration,
            );

            if (isDuration) {
              durationTrigger = DurationTriggerProperty.fromCrawledProperty(e);
            } else {
              dateTimeTrigger = DateTimeTriggerProperty.fromCrawledProperty(e);
            }
            break;
          }
        case "DURATION":
          duration = DurationProperty.fromCrawledProperty(e);
          break;
        case "REPEAT":
          repeatCount = RepeatCountProperty.fromCrawledProperty(e);
          break;
        case "ATTACH":
          {
            final isBinary = e.parameters.any(
              (element) =>
                  element.name.toUpperCase() == "VALUE" &&
                  ValueDataTypeParameter.fromCrawledParameter(element).type ==
                      ValueType.binary,
            );

            if (isBinary) {
              binaryAttachment =
                  BinaryAttachmentProperty.fromCrawledProperty(e);
            } else {
              uriAttachment = UriAttachmentProperty.fromCrawledProperty(e);
            }
            break;
          }
        case "DESCRIPTION":
          description = DescriptionProperty.fromCrawledProperty(e);
          break;
        default:
          print(
              "Unknown property encountered in ProcedureAlarmComponent: ${e.name}");
      }
    }

    return ProcedureAlarmComponent(
      dateTimeTrigger: dateTimeTrigger,
      durationTrigger: durationTrigger,
      duration: duration,
      repeatCount: repeatCount,
      uriAttachment: uriAttachment,
      binaryAttachment: binaryAttachment,
      description: description,
    );
  }

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return [
      ActionProperty(ActionType.procedure),
      ...(<CalendarProperty<CalendarValue>?>[
        dateTimeTrigger,
        durationTrigger,
        duration,
        repeatCount,
        uriAttachment,
        binaryAttachment,
        description,
      ].where((element) => element != null).map((e) => e!).toList()),
    ];
  }
}
