// ignore_for_file: avoid_print

import "../calendar_component.dart";
import "../calendar_property.dart";
import "../calendar_value.dart";
import '../models/crawled_block.dart';
import '../properties/comment.dart';
import '../properties/date_time_start.dart';
import '../properties/last_modified.dart';
import '../properties/recurrence_date_times.dart';
import '../properties/recurrence_rule.dart';
import '../properties/time_zone_identifier.dart';
import '../properties/time_zone_name.dart';
import '../properties/time_zone_offset_from.dart';
import '../properties/time_zone_offset_to.dart';
import '../properties/time_zone_url.dart';

/// RFC2445 Section 4.6.5
class TimeZoneComponent extends CalendarComponent {
  final TimeZoneIdentifierProperty timeZoneIdentifier;
  final LastModifiedProperty? lastModified;
  final TimeZoneUrlProperty? timeZoneUrl;
  final List<StandardTimeZoneComponent>? standardTimeZones;
  final List<DaylightTimeZoneComponent>? daylightTimeZones;

  const TimeZoneComponent({
    required this.timeZoneIdentifier,
    this.lastModified,
    this.timeZoneUrl,
    this.standardTimeZones,
    this.daylightTimeZones,
  })  : assert(
          standardTimeZones != null || daylightTimeZones != null,
          "one of standardTimeZones or daylightTimeZones MUST occur",
        ),
        super("VTIMEZONE");

  factory TimeZoneComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "VTIMEZONE",
      "Received invalid block: ${block.blockName}",
    );

    TimeZoneIdentifierProperty? timeZoneIdentifier;
    LastModifiedProperty? lastModified;
    TimeZoneUrlProperty? timeZoneUrl;
    List<StandardTimeZoneComponent>? standardTimeZones;
    List<DaylightTimeZoneComponent>? daylightTimeZones;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "TZID":
          timeZoneIdentifier =
              TimeZoneIdentifierProperty.fromCrawledProperty(e);
          break;
        case "LAST-MODIFIED":
          lastModified = LastModifiedProperty.fromCrawledProperty(e);
          break;
        case "TZURL":
          timeZoneUrl = TimeZoneUrlProperty.fromCrawledProperty(e);
          break;
        default:
          print("Unknown property encountered in TimeZoneComponent: ${e.name}");
      }
    }

    for (var e in block.nestedBlocks) {
      switch (e.blockName.toUpperCase()) {
        case "STANDARD":
          standardTimeZones ??= [];
          standardTimeZones.add(StandardTimeZoneComponent.fromCrawledBlock(e));
          break;
        case "DAYLIGHT":
          daylightTimeZones ??= [];
          daylightTimeZones.add(DaylightTimeZoneComponent.fromCrawledBlock(e));
          break;
        default:
          print(
              "Unknown component encountered in TimeZoneComponent: ${e.blockName}");
      }
    }

    assert(
      timeZoneIdentifier != null,
      "[timeZoneIdentifier] cannot be null",
    );

    return TimeZoneComponent(
      timeZoneIdentifier: timeZoneIdentifier!,
      lastModified: lastModified,
      timeZoneUrl: timeZoneUrl,
      standardTimeZones: standardTimeZones,
      daylightTimeZones: daylightTimeZones,
    );
  }

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return <CalendarProperty<CalendarValue>>[
      timeZoneIdentifier,
      ...(<CalendarProperty<CalendarValue>?>[
        lastModified,
        timeZoneUrl,
      ].where((element) => element != null).map((e) => e!).toList()),
    ];
  }

  @override
  List<CalendarComponent> getSubComponents() {
    return [
      ...(standardTimeZones ?? []),
      ...(daylightTimeZones ?? []),
    ];
  }
}

abstract class _TimeZoneSubComponent extends CalendarComponent {
  final DateTimeStartProperty dateTimeStart;
  final TimeZoneOffsetFromProperty timeZoneOffsetFrom;
  final TimeZoneOffsetToProperty timeZoneOffsetTo;
  final List<CommentProperty>? comments;
  final List<RecurrenceDateTimesProperty>? recurrenceDateTimes;
  final List<RecurrenceRuleProperty>? recurrenceRules;
  final List<TimeZoneNameProperty>? timeZoneNames;

  const _TimeZoneSubComponent(
    String componentName, {
    required this.dateTimeStart,
    required this.timeZoneOffsetFrom,
    required this.timeZoneOffsetTo,
    this.comments,
    this.recurrenceDateTimes,
    this.recurrenceRules,
    this.timeZoneNames,
  }) : super(componentName);

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return [
      ...(<CalendarProperty<CalendarValue>?>[
        dateTimeStart,
        timeZoneOffsetFrom,
        timeZoneOffsetTo,
      ].where((element) => element != null).map((e) => e!).toList()),
      ...(<List<CalendarProperty<CalendarValue>>?>[
        comments,
        recurrenceDateTimes,
        recurrenceRules,
        timeZoneNames,
      ]
          .where((element) => element != null)
          .map((e) => e!)
          .expand((element) => element)
          .toList())
    ];
  }
}

class StandardTimeZoneComponent extends _TimeZoneSubComponent {
  const StandardTimeZoneComponent({
    required DateTimeStartProperty dateTimeStart,
    required TimeZoneOffsetFromProperty timeZoneOffsetFrom,
    required TimeZoneOffsetToProperty timeZoneOffsetTo,
    List<CommentProperty>? comments,
    List<RecurrenceDateTimesProperty>? recurrenceDateTimes,
    List<RecurrenceRuleProperty>? recurrenceRules,
    List<TimeZoneNameProperty>? timeZoneNames,
  }) : super(
          "STANDARD",
          dateTimeStart: dateTimeStart,
          timeZoneOffsetFrom: timeZoneOffsetFrom,
          timeZoneOffsetTo: timeZoneOffsetTo,
          comments: comments,
          recurrenceDateTimes: recurrenceDateTimes,
          recurrenceRules: recurrenceRules,
          timeZoneNames: timeZoneNames,
        );

  factory StandardTimeZoneComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "STANDARD",
      "Received invalid block: ${block.blockName}",
    );

    DateTimeStartProperty? dateTimeStart;
    TimeZoneOffsetFromProperty? timeZoneOffsetFrom;
    TimeZoneOffsetToProperty? timeZoneOffsetTo;
    List<CommentProperty>? comments;
    List<RecurrenceDateTimesProperty>? recurrenceDateTimes;
    List<RecurrenceRuleProperty>? recurrenceRules;
    List<TimeZoneNameProperty>? timeZoneNames;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "DTSTART":
          dateTimeStart = DateTimeStartProperty.fromCrawledProperty(e);
          break;
        case "TZOFFSETFROM":
          timeZoneOffsetFrom =
              TimeZoneOffsetFromProperty.fromCrawledProperty(e);
          break;
        case "TZOFFSETTO":
          timeZoneOffsetTo = TimeZoneOffsetToProperty.fromCrawledProperty(e);
          break;
        case "COMMENT":
          comments ??= [];
          comments.add(CommentProperty.fromCrawledProperty(e));
          break;
        case "RDATE":
          recurrenceDateTimes ??= [];
          recurrenceDateTimes
              .add(RecurrenceDateTimesProperty.fromCrawledProperty(e));
          break;
        case "RRULE":
          recurrenceRules ??= [];
          recurrenceRules.add(RecurrenceRuleProperty.fromCrawledProperty(e));
          break;
        case "TZNAME":
          timeZoneNames ??= [];
          timeZoneNames.add(TimeZoneNameProperty.fromCrawledProperty(e));
          break;
        default:
          print(
              "Unknown property encountered in StandardTimeZoneComponent: ${e.name}");
      }
    }

    assert(
      dateTimeStart != null &&
          timeZoneOffsetFrom != null &&
          timeZoneOffsetTo != null,
      "[dateTimeStart], [timeZoneOffsetFrom], and [timeZoneOffsetTo] cannot be null",
    );

    return StandardTimeZoneComponent(
      dateTimeStart: dateTimeStart!,
      timeZoneOffsetFrom: timeZoneOffsetFrom!,
      timeZoneOffsetTo: timeZoneOffsetTo!,
      comments: comments,
      recurrenceDateTimes: recurrenceDateTimes,
      recurrenceRules: recurrenceRules,
      timeZoneNames: timeZoneNames,
    );
  }
}

class DaylightTimeZoneComponent extends _TimeZoneSubComponent {
  const DaylightTimeZoneComponent({
    required DateTimeStartProperty dateTimeStart,
    required TimeZoneOffsetFromProperty timeZoneOffsetFrom,
    required TimeZoneOffsetToProperty timeZoneOffsetTo,
    List<CommentProperty>? comments,
    List<RecurrenceDateTimesProperty>? recurrenceDateTimes,
    List<RecurrenceRuleProperty>? recurrenceRules,
    List<TimeZoneNameProperty>? timeZoneNames,
  }) : super(
          "DAYLIGHT",
          dateTimeStart: dateTimeStart,
          timeZoneOffsetFrom: timeZoneOffsetFrom,
          timeZoneOffsetTo: timeZoneOffsetTo,
          comments: comments,
          recurrenceDateTimes: recurrenceDateTimes,
          recurrenceRules: recurrenceRules,
          timeZoneNames: timeZoneNames,
        );

  factory DaylightTimeZoneComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "DAYLIGHT",
      "Received invalid block: ${block.blockName}",
    );

    DateTimeStartProperty? dateTimeStart;
    TimeZoneOffsetFromProperty? timeZoneOffsetFrom;
    TimeZoneOffsetToProperty? timeZoneOffsetTo;
    List<CommentProperty>? comments;
    List<RecurrenceDateTimesProperty>? recurrenceDateTimes;
    List<RecurrenceRuleProperty>? recurrenceRules;
    List<TimeZoneNameProperty>? timeZoneNames;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "DTSTART":
          dateTimeStart = DateTimeStartProperty.fromCrawledProperty(e);
          break;
        case "TZOFFSETFROM":
          timeZoneOffsetFrom =
              TimeZoneOffsetFromProperty.fromCrawledProperty(e);
          break;
        case "TZOFFSETTO":
          timeZoneOffsetTo = TimeZoneOffsetToProperty.fromCrawledProperty(e);
          break;
        case "COMMENT":
          comments ??= [];
          comments.add(CommentProperty.fromCrawledProperty(e));
          break;
        case "RDATE":
          recurrenceDateTimes ??= [];
          recurrenceDateTimes
              .add(RecurrenceDateTimesProperty.fromCrawledProperty(e));
          break;
        case "RRULE":
          recurrenceRules ??= [];
          recurrenceRules.add(RecurrenceRuleProperty.fromCrawledProperty(e));
          break;
        case "TZNAME":
          timeZoneNames ??= [];
          timeZoneNames.add(TimeZoneNameProperty.fromCrawledProperty(e));
          break;
        default:
          print(
              "Unknown property encountered in DaylightTimeZoneComponent: ${e.name}");
      }
    }

    assert(
      dateTimeStart != null &&
          timeZoneOffsetFrom != null &&
          timeZoneOffsetTo != null,
      "[dateTimeStart], [timeZoneOffsetFrom], and [timeZoneOffsetTo] cannot be null",
    );

    return DaylightTimeZoneComponent(
      dateTimeStart: dateTimeStart!,
      timeZoneOffsetFrom: timeZoneOffsetFrom!,
      timeZoneOffsetTo: timeZoneOffsetTo!,
      comments: comments,
      recurrenceDateTimes: recurrenceDateTimes,
      recurrenceRules: recurrenceRules,
      timeZoneNames: timeZoneNames,
    );
  }
}
