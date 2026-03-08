// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_component.dart';
import '../calendar_property.dart';
import '../calendar_value.dart';
import '../models/crawled_block.dart';
import '../properties/attendee.dart';
import '../properties/comment.dart';
import '../properties/contact.dart';
import '../properties/date_time_end.dart';
import '../properties/date_time_stamp.dart';
import '../properties/date_time_start.dart';
import '../properties/duration.dart';
import '../properties/free_busy_time.dart';
import '../properties/organizer.dart';
import '../properties/request_status.dart';
import '../properties/unique_identifier.dart';
import '../properties/url.dart';

/// RFC2445 Section 4.6.4
class FreeBusyComponent extends CalendarComponent {
  final ContactProperty? contact;
  final DateTimeStartProperty? dateTimeStart;
  final DateTimeEndProperty? dateTimeEnd;
  final DurationProperty? duration;
  final DateTimeStampProperty? dateTimeStamp;
  final OrganizerProperty? organizer;
  final UniqueIdentifierProperty? uniqueIdentifier;
  final URLProperty? url;
  final List<AttendeeProperty>? attendees;
  final List<CommentProperty>? comments;
  final List<FreeBusyTimeProperty>? freeBusyTimes;
  final List<RequestStatusProperty>? requestStatuses;

  const FreeBusyComponent({
    this.contact,
    this.dateTimeStart,
    this.dateTimeEnd,
    this.duration,
    this.dateTimeStamp,
    this.organizer,
    this.uniqueIdentifier,
    this.url,
    this.attendees,
    this.comments,
    this.freeBusyTimes,
    this.requestStatuses,
  }) : super("VFREEBUSY");

  factory FreeBusyComponent.fromCrawledBlock(CrawledBlock block) {
    assert(
      block.blockName.toUpperCase() == "VFREEBUSY",
      "Received invalid block: ${block.blockName}",
    );

    ContactProperty? contact;
    DateTimeStartProperty? dateTimeStart;
    DateTimeEndProperty? dateTimeEnd;
    DurationProperty? duration;
    DateTimeStampProperty? dateTimeStamp;
    OrganizerProperty? organizer;
    UniqueIdentifierProperty? uniqueIdentifier;
    URLProperty? url;
    List<AttendeeProperty>? attendees;
    List<CommentProperty>? comments;
    List<FreeBusyTimeProperty>? freeBusyTimes;
    List<RequestStatusProperty>? requestStatuses;

    for (var e in block.properties) {
      switch (e.name.toUpperCase()) {
        case "DTSTART":
          dateTimeStart = DateTimeStartProperty.fromCrawledProperty(e);
          break;
        case "ORGANIZER":
          organizer = OrganizerProperty.fromCrawledProperty(e);
          break;
        case "DTSTAMP":
          dateTimeStamp = DateTimeStampProperty.fromCrawledProperty(e);
          break;
        case "UID":
          uniqueIdentifier = UniqueIdentifierProperty.fromCrawledProperty(e);
          break;
        case "URL":
          url = URLProperty.fromCrawledProperty(e);
          break;
        case "DTEND":
          dateTimeEnd = DateTimeEndProperty.fromCrawledProperty(e);
          break;
        case "DURATION":
          duration = DurationProperty.fromCrawledProperty(e);
          break;
        case "ATTENDEE":
          attendees ??= [];
          attendees.add(AttendeeProperty.fromCrawledProperty(e));
          break;
        case "COMMENT":
          comments ??= [];
          comments.add(CommentProperty.fromCrawledProperty(e));
          break;
        case "CONTACT":
          contact = ContactProperty.fromCrawledProperty(e);
          break;
        case "REQUEST-STATUS":
          requestStatuses ??= [];
          requestStatuses.add(RequestStatusProperty.fromCrawledProperty(e));
          break;
        case "FREEBUSY":
          freeBusyTimes ??= [];
          freeBusyTimes.add(FreeBusyTimeProperty.fromCrawledProperty(e));
          break;
        default:
          // ignore: avoid_print
          print("Unknown property encountered in FreeBusyComponent: ${e.name}");
      }
    }

    return FreeBusyComponent(
      contact: contact,
      dateTimeStart: dateTimeStart,
      dateTimeEnd: dateTimeEnd,
      duration: duration,
      dateTimeStamp: dateTimeStamp,
      organizer: organizer,
      uniqueIdentifier: uniqueIdentifier,
      url: url,
      attendees: attendees,
      comments: comments,
      freeBusyTimes: freeBusyTimes,
      requestStatuses: requestStatuses,
    );
  }

  @override
  List<CalendarProperty<CalendarValue>> getProperties() {
    return [
      ...(<CalendarProperty<CalendarValue>?>[
        contact,
        dateTimeStart,
        dateTimeEnd,
        duration,
        dateTimeStamp,
        organizer,
        uniqueIdentifier,
        url,
      ].where((element) => element != null).map((e) => e!).toList()),
      ...(<List<CalendarProperty<CalendarValue>>?>[
        attendees,
        comments,
        freeBusyTimes,
        requestStatuses,
      ]
          .where((element) => element != null)
          .map((e) => e!)
          .expand((element) => element)
          .toList())
    ];
  }
}
