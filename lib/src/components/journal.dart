// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_component.dart';
import '../calendar_property.dart';
import '../calendar_value.dart';
import '../models/crawled_block.dart';
import '../parameters/value_data_type.dart';
import '../properties/attachment.dart';
import '../properties/attendee.dart';
import '../properties/categories.dart';
import '../properties/classification.dart';
import '../properties/comment.dart';
import '../properties/contact.dart';
import '../properties/date_time_created.dart';
import '../properties/date_time_stamp.dart';
import '../properties/date_time_start.dart';
import '../properties/description.dart';
import '../properties/exception_date_times.dart';
import '../properties/exception_rule.dart';
import '../properties/last_modified.dart';
import '../properties/organizer.dart';
import '../properties/recurrence_date_times.dart';
import '../properties/recurrence_id.dart';
import '../properties/recurrence_rule.dart';
import '../properties/related_to.dart';
import '../properties/request_status.dart';
import '../properties/sequence.dart';
import '../properties/status.dart';
import '../properties/summary.dart';
import '../properties/unique_identifier.dart';
import '../properties/url.dart';

/// RFC2445 Section 4.6.3
class JournalComponent extends CalendarComponent {
  final ClassificationProperty? classification;
  final DateTimeCreatedProperty? dateTimeCreated;
  final DescriptionProperty? description;
  final DateTimeStartProperty? dateTimeStart;
  final DateTimeStampProperty? dateTimeStamp;
  final LastModifiedProperty? lastModified;
  final OrganizerProperty? organizer;
  final RecurrenceIdProperty? recurrenceId;
  final SequenceProperty? sequence;
  final StatusProperty? status;
  final SummaryProperty? summary;
  final UniqueIdentifierProperty? uniqueIdentifier;
  final URLProperty? url;
  final List<UriAttachmentProperty>? uriAttachments;
  final List<BinaryAttachmentProperty>? binaryAttachments;
  final List<AttendeeProperty>? attendees;
  final List<CategoriesProperty>? categories;
  final List<CommentProperty>? comments;
  final List<ContactProperty>? contacts;
  final List<ExceptionDateTimesProperty>? exceptionDateTimes;
  final List<ExceptionRuleProperty>? exceptionRules;
  final List<RelatedToProperty>? relatedTo;
  final List<RecurrenceDateTimesProperty>? recurrenceDateTimes;
  final List<RecurrenceRuleProperty>? recurrenceRules;
  final List<RequestStatusProperty>? requestStatuses;

  const JournalComponent({
    this.classification,
    this.dateTimeCreated,
    this.description,
    this.dateTimeStart,
    this.dateTimeStamp,
    this.lastModified,
    this.organizer,
    this.recurrenceId,
    this.sequence,
    this.status,
    this.summary,
    this.uniqueIdentifier,
    this.url,
    this.uriAttachments,
    this.binaryAttachments,
    this.attendees,
    this.categories,
    this.comments,
    this.contacts,
    this.exceptionDateTimes,
    this.exceptionRules,
    this.relatedTo,
    this.recurrenceDateTimes,
    this.recurrenceRules,
    this.requestStatuses,
  }) : super("VJOURNAL");

  factory JournalComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "VJOURNAL",
      "Received invalid block: ${block.blockName}",
    );

    ClassificationProperty? classification;
    DateTimeCreatedProperty? dateTimeCreated;
    DescriptionProperty? description;
    DateTimeStartProperty? dateTimeStart;
    DateTimeStampProperty? dateTimeStamp;
    LastModifiedProperty? lastModified;
    OrganizerProperty? organizer;
    RecurrenceIdProperty? recurrenceId;
    SequenceProperty? sequence;
    StatusProperty? status;
    SummaryProperty? summary;
    UniqueIdentifierProperty? uniqueIdentifier;
    URLProperty? url;
    List<UriAttachmentProperty>? uriAttachments;
    List<BinaryAttachmentProperty>? binaryAttachments;
    List<AttendeeProperty>? attendees;
    List<CategoriesProperty>? categories;
    List<CommentProperty>? comments;
    List<ContactProperty>? contacts;
    List<ExceptionDateTimesProperty>? exceptionDateTimes;
    List<ExceptionRuleProperty>? exceptionRules;
    List<RelatedToProperty>? relatedTo;
    List<RecurrenceDateTimesProperty>? recurrenceDateTimes;
    List<RecurrenceRuleProperty>? recurrenceRules;
    List<RequestStatusProperty>? requestStatuses;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "CLASS":
          classification = ClassificationProperty.fromCrawledProperty(e);
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
        case "LAST-MODIFIED":
          lastModified = LastModifiedProperty.fromCrawledProperty(e);
          break;
        case "ORGANIZER":
          organizer = OrganizerProperty.fromCrawledProperty(e);
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
        case "RECURRENCE-ID":
          recurrenceId = RecurrenceIdProperty.fromCrawledProperty(e);
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
          // ignore: avoid_print
          print("Unknown property encountered in JournalComponent: ${e.name}");
      }
    }

    return JournalComponent(
      classification: classification,
      dateTimeCreated: dateTimeCreated,
      description: description,
      dateTimeStart: dateTimeStart,
      dateTimeStamp: dateTimeStamp,
      lastModified: lastModified,
      organizer: organizer,
      recurrenceId: recurrenceId,
      sequence: sequence,
      status: status,
      summary: summary,
      uniqueIdentifier: uniqueIdentifier,
      url: url,
      uriAttachments: uriAttachments,
      binaryAttachments: binaryAttachments,
      attendees: attendees,
      categories: categories,
      comments: comments,
      contacts: contacts,
      exceptionDateTimes: exceptionDateTimes,
      exceptionRules: exceptionRules,
      relatedTo: relatedTo,
      recurrenceDateTimes: recurrenceDateTimes,
      recurrenceRules: recurrenceRules,
      requestStatuses: requestStatuses,
    );
  }

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return [
      ...(<CalendarProperty<CalendarValue>?>[
        classification,
        dateTimeCreated,
        description,
        dateTimeStart,
        dateTimeStamp,
        lastModified,
        organizer,
        recurrenceId,
        sequence,
        status,
        summary,
        uniqueIdentifier,
        url,
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
        relatedTo,
        recurrenceDateTimes,
        recurrenceRules,
        requestStatuses,
      ]
          .where((element) => element != null)
          .map((e) => e!)
          .expand((element) => element)
          .toList()),
    ];
  }
}
