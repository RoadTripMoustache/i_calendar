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
import '../properties/categories.dart';
import '../properties/classification.dart';
import '../properties/comment.dart';
import '../properties/contact.dart';
import '../properties/date_time_completed.dart';
import '../properties/date_time_created.dart';
import '../properties/date_time_due.dart';
import '../properties/date_time_stamp.dart';
import '../properties/date_time_start.dart';
import '../properties/description.dart';
import '../properties/duration.dart';
import '../properties/exception_date_times.dart';
import '../properties/exception_rule.dart';
import '../properties/geographic_position.dart';
import '../properties/last_modified.dart';
import '../properties/location.dart';
import '../properties/organizer.dart';
import '../properties/percent_complete.dart';
import '../properties/priority.dart';
import '../properties/recurrence_date_times.dart';
import '../properties/recurrence_id.dart';
import '../properties/recurrence_rule.dart';
import '../properties/related_to.dart';
import '../properties/request_status.dart';
import '../properties/resources.dart';
import '../properties/sequence.dart';
import '../properties/status.dart';
import '../properties/summary.dart';
import '../properties/unique_identifier.dart';
import '../properties/url.dart';
import 'alarm.dart';

/// RFC2445 Section 4.6.2
class TodoComponent extends CalendarComponent {
  final ClassificationProperty? classification;
  final DateTimeCompletedProperty? dateTimeCompleted;
  final DateTimeCreatedProperty? dateTimeCreated;
  final DescriptionProperty? description;
  final DateTimeStampProperty? dateTimeStamp;
  final DateTimeStartProperty? dateTimeStart;
  final GeographicPositionProperty? geographicPosition;
  final LastModifiedProperty? lastModified;
  final LocationProperty? location;
  final OrganizerProperty? organizer;
  final PercentCompleteProperty? percentComplete;
  final PriorityProperty? priority;
  final RecurrenceIdProperty? recurrenceId;
  final SequenceProperty? sequence;
  final StatusProperty? status;
  final SummaryProperty? summary;
  final UniqueIdentifierProperty? uniqueIdentifier;
  final URLProperty? url;
  final DateTimeDueProperty? dateTimeDue;
  final DurationProperty? duration;
  final List<UriAttachmentProperty>? uriAttachments;
  final List<BinaryAttachmentProperty>? binaryAttachments;
  final List<AttendeeProperty>? attendees;
  final List<CategoriesProperty>? categories;
  final List<CommentProperty>? comments;
  final List<ContactProperty>? contacts;
  final List<ExceptionDateTimesProperty>? exceptionDateTimes;
  final List<ExceptionRuleProperty>? exceptionRules;
  final List<RequestStatusProperty>? requestStatuses;
  final List<RelatedToProperty>? relatedTo;
  final List<ResourcesProperty>? resources;
  final List<RecurrenceDateTimesProperty>? recurrenceDateTimes;
  final List<RecurrenceRuleProperty>? recurrenceRules;
  final List<AudioAlarmComponent>? audioAlarms;
  final List<DisplayAlarmComponent>? displayAlarms;
  final List<EmailAlarmComponent>? emailAlarms;
  final List<ProcedureAlarmComponent>? procedureAlarms;

  const TodoComponent({
    this.classification,
    this.dateTimeCompleted,
    this.dateTimeCreated,
    this.description,
    this.dateTimeStamp,
    this.dateTimeStart,
    this.geographicPosition,
    this.lastModified,
    this.location,
    this.organizer,
    this.percentComplete,
    this.priority,
    this.recurrenceId,
    this.sequence,
    this.status,
    this.summary,
    this.uniqueIdentifier,
    this.url,
    this.dateTimeDue,
    this.duration,
    this.uriAttachments,
    this.binaryAttachments,
    this.attendees,
    this.categories,
    this.comments,
    this.contacts,
    this.exceptionDateTimes,
    this.exceptionRules,
    this.requestStatuses,
    this.relatedTo,
    this.resources,
    this.recurrenceDateTimes,
    this.recurrenceRules,
    this.audioAlarms,
    this.displayAlarms,
    this.emailAlarms,
    this.procedureAlarms,
  })  : assert(
          dateTimeDue == null || duration == null,
          "dateTimeDue and duration cannot be supplied at the same time",
        ),
        super("VTODO");

  factory TodoComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "VTODO",
      "Received invalid block: ${block.blockName}",
    );

    ClassificationProperty? classification;
    DateTimeCompletedProperty? dateTimeCompleted;
    DateTimeCreatedProperty? dateTimeCreated;
    DescriptionProperty? description;
    DateTimeStampProperty? dateTimeStamp;
    DateTimeStartProperty? dateTimeStart;
    GeographicPositionProperty? geographicPosition;
    LastModifiedProperty? lastModified;
    LocationProperty? location;
    OrganizerProperty? organizer;
    PercentCompleteProperty? percentComplete;
    PriorityProperty? priority;
    RecurrenceIdProperty? recurrenceId;
    SequenceProperty? sequence;
    StatusProperty? status;
    SummaryProperty? summary;
    UniqueIdentifierProperty? uniqueIdentifier;
    URLProperty? url;
    DateTimeDueProperty? dateTimeDue;
    DurationProperty? duration;
    List<UriAttachmentProperty>? uriAttachments;
    List<BinaryAttachmentProperty>? binaryAttachments;
    List<AttendeeProperty>? attendees;
    List<CategoriesProperty>? categories;
    List<CommentProperty>? comments;
    List<ContactProperty>? contacts;
    List<ExceptionDateTimesProperty>? exceptionDateTimes;
    List<ExceptionRuleProperty>? exceptionRules;
    List<RequestStatusProperty>? requestStatuses;
    List<RelatedToProperty>? relatedTo;
    List<ResourcesProperty>? resources;
    List<RecurrenceDateTimesProperty>? recurrenceDateTimes;
    List<RecurrenceRuleProperty>? recurrenceRules;
    List<AudioAlarmComponent>? audioAlarms;
    List<DisplayAlarmComponent>? displayAlarms;
    List<EmailAlarmComponent>? emailAlarms;
    List<ProcedureAlarmComponent>? procedureAlarms;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "CLASS":
          classification = ClassificationProperty.fromCrawledProperty(e);
          break;
        case "COMPLETED":
          dateTimeCompleted = DateTimeCompletedProperty.fromCrawledProperty(e);
          break;
        case "CREATED":
          dateTimeCreated = DateTimeCreatedProperty.fromCrawledProperty(e);
          break;
        case "DESCRIPTION":
          description = DescriptionProperty.fromCrawledProperty(e);
          break;
        case "DTSTART":
          dateTimeStart = DateTimeStartProperty.fromCrawledProperty(e);
          break;
        case "GEO":
          geographicPosition =
              GeographicPositionProperty.fromCrawledProperty(e);
          break;
        case "LAST-MODIFIED":
          lastModified = LastModifiedProperty.fromCrawledProperty(e);
          break;
        case "LOCATION":
          location = LocationProperty.fromCrawledProperty(e);
          break;
        case "ORGANIZER":
          organizer = OrganizerProperty.fromCrawledProperty(e);
          break;
        case "PERCENT-COMPLETE":
          percentComplete = PercentCompleteProperty.fromCrawledProperty(e);
          break;
        case "PRIORITY":
          priority = PriorityProperty.fromCrawledProperty(e);
          break;
        case "DTSTAMP":
          dateTimeStamp = DateTimeStampProperty.fromCrawledProperty(e);
          break;
        case "SEQUENCE":
          sequence = SequenceProperty.fromCrawledProperty(e);
          break;
        case "STATUS":
          status = StatusProperty.fromCrawledProperty(e);
          break;
        case "SUMMARY":
          summary = SummaryProperty.fromCrawledProperty(e);
          break;
        case "UID":
          uniqueIdentifier = UniqueIdentifierProperty.fromCrawledProperty(e);
          break;
        case "URL":
          url = URLProperty.fromCrawledProperty(e);
          break;
        case "DUE":
          dateTimeDue = DateTimeDueProperty.fromCrawledProperty(e);
          break;
        case "RECURRENCE-ID":
          recurrenceId = RecurrenceIdProperty.fromCrawledProperty(e);
          break;
        case "DURATION":
          duration = DurationProperty.fromCrawledProperty(e);
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
          attendees ??= [];
          attendees.add(AttendeeProperty.fromCrawledProperty(e));
          break;
        case "CATEGORIES":
          categories ??= [];
          categories.add(CategoriesProperty.fromCrawledProperty(e));
          break;
        case "COMMENT":
          comments ??= [];
          comments.add(CommentProperty.fromCrawledProperty(e));
          break;
        case "CONTACT":
          contacts ??= [];
          contacts.add(ContactProperty.fromCrawledProperty(e));
          break;
        case "EXDATE":
          exceptionDateTimes ??= [];
          exceptionDateTimes
              .add(ExceptionDateTimesProperty.fromCrawledProperty(e));
          break;
        case "EXRULE":
          exceptionRules ??= [];
          exceptionRules.add(ExceptionRuleProperty.fromCrawledProperty(e));
          break;
        case "REQUEST-STATUS":
          requestStatuses ??= [];
          requestStatuses.add(RequestStatusProperty.fromCrawledProperty(e));
          break;
        case "RELATED-TO":
          relatedTo ??= [];
          relatedTo.add(RelatedToProperty.fromCrawledProperty(e));
          break;
        case "RESOURCES":
          resources ??= [];
          resources.add(ResourcesProperty.fromCrawledProperty(e));
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
        default:
          print("Unknown property encountered in TodoComponent: ${e.name}");
      }
    }

    for (var e in block.nestedBlocks) {
      switch (e.blockName.toUpperCase()) {
        case "VALARM":
          {
            final action = ActionProperty.fromCrawledProperty(
              e.properties.firstWhere(
                  (element) => element.name.toUpperCase() == "ACTION"),
            );
            switch (action.type) {
              case ActionType.audio:
                audioAlarms ??= [];
                audioAlarms.add(AudioAlarmComponent.fromCrawledBlock(e));
                break;
              case ActionType.display:
                displayAlarms ??= [];
                displayAlarms.add(DisplayAlarmComponent.fromCrawledBlock(e));
                break;
              case ActionType.email:
                emailAlarms ??= [];
                emailAlarms.add(EmailAlarmComponent.fromCrawledBlock(e));
                break;
              case ActionType.procedure:
                procedureAlarms ??= [];
                procedureAlarms
                    .add(ProcedureAlarmComponent.fromCrawledBlock(e));
                break;
            }
            break;
          }
        default:
          print(
              "Unknown component encountered in TodoComponent: ${e.blockName}");
      }
    }

    return TodoComponent(
      classification: classification,
      dateTimeCompleted: dateTimeCompleted,
      dateTimeCreated: dateTimeCreated,
      description: description,
      dateTimeStamp: dateTimeStamp,
      dateTimeStart: dateTimeStart,
      geographicPosition: geographicPosition,
      lastModified: lastModified,
      location: location,
      organizer: organizer,
      percentComplete: percentComplete,
      priority: priority,
      recurrenceId: recurrenceId,
      sequence: sequence,
      status: status,
      summary: summary,
      uniqueIdentifier: uniqueIdentifier,
      url: url,
      dateTimeDue: dateTimeDue,
      duration: duration,
      uriAttachments: uriAttachments,
      binaryAttachments: binaryAttachments,
      attendees: attendees,
      categories: categories,
      comments: comments,
      contacts: contacts,
      exceptionDateTimes: exceptionDateTimes,
      exceptionRules: exceptionRules,
      requestStatuses: requestStatuses,
      relatedTo: relatedTo,
      resources: resources,
      recurrenceDateTimes: recurrenceDateTimes,
      recurrenceRules: recurrenceRules,
      audioAlarms: audioAlarms,
      displayAlarms: displayAlarms,
      emailAlarms: emailAlarms,
      procedureAlarms: procedureAlarms,
    );
  }

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return [
      ...(<CalendarProperty<CalendarValue>?>[
        classification,
        dateTimeCompleted,
        dateTimeCreated,
        description,
        dateTimeStamp,
        dateTimeStart,
        geographicPosition,
        lastModified,
        location,
        organizer,
        percentComplete,
        priority,
        recurrenceId,
        sequence,
        status,
        summary,
        uniqueIdentifier,
        url,
        dateTimeDue,
        duration,
      ].where((element) => element != null).map((e) => e!).toList()),
      ...(<List<CalendarProperty<CalendarValue>>?>[
        uriAttachments,
        binaryAttachments,
        attendees,
        categories,
        comments,
        contacts,
        exceptionDateTimes,
        exceptionRules,
        requestStatuses,
        relatedTo,
        resources,
        recurrenceDateTimes,
        recurrenceRules,
      ]
          .where((element) => element != null)
          .map((e) => e!)
          .expand((element) => element)
          .toList())
    ];
  }

  @override
  List<CalendarComponent> getSubComponents() {
    return [
      ...(audioAlarms ?? []),
      ...(displayAlarms ?? []),
      ...(emailAlarms ?? []),
      ...(procedureAlarms ?? []),
    ];
  }
}
