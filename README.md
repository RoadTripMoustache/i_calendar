# I_Calendar

> Code based on https://gitlab.com/powerbuilding/opensource/mobile/support-libraries/icalendar-dart
> 
> Thanks to [Brian Tutovic](https://gitlab.com/brian.tutovic) for this 1st version !

Serializes and Deserializes ICalendar text. Offers 99+% coverage of the [ICalendar RFC](https://www.ietf.org/rfc/rfc2445.txt).

**Note:** Non-standard Parameters/Properties/Components (ie: x-\* named things) and IANA-Token based names do not have first class support at the moment. Feel free to submit an PR or extend one of the abstract classes within your project to support your usecase.

---

## How-to use it ?

To use this plugin, add `i_calendar` as a dependency in your pubspec.yaml file.

Most of the objects have built-in asserts that "assert" the RFC2445 spec. The idea is we don't break production code, we just throw out the stuff that doesn't make sense. There's a lot of different custom implementations of the ICalendar spec out there, if we threw an exception on every bad ICalendar object as we deserialized we wouldn't be able to deserialize anything. Maybe an opt-in "Strict Mode" flag could be on the cards in the future though.

### Deserialization

**Note:** Deserialization will add "no-op" default parameter values for free (where applicable) to better adhere to the RFC2445 spec. We won't modify any values, just assert what's already there.

```dart
import 'package:i_calendar/i_calendar.dart';

final testString = """
BEGIN:VCALENDAR
PRODID:-//xyz Corp//NONSGML PDA Calendar Version 1.0//EN
VERSION:2.0
BEGIN:VEVENT
DTSTAMP:19960704T120000Z
UID:uid1@example.com
ORGANIZER:mailto:jsmith@example.com
DTSTART:19960918T143000Z
DTEND:19960920T220000Z
STATUS:CONFIRMED
CATEGORIES:CONFERENCE
SUMMARY:Networld+Interop Conference
DESCRIPTION:Networld+Interop Conference and Exhibit\nAtlanta World Atlanta\, Georgia
END:VEVENT
END:VCALENDAR
""";

void main() {
    // Deserialize
    final calendars = ICalendar.fromICalendarString(testString);

    // Serialize
    for (var cal in calendars) {
        print("=====================");
        print(cal);
        print("=====================");
    }
}

```

### Serialization

```dart
import 'package:i_calendar/i_calendar.dart';

void main() {
  final ical = ICalendar(
    productIdentifier: ProductIdentifierProperty(
      "-//Powerbuilding//COACHAPP SCHED Calendar Version 1.0//EN",
    ),
    version: VersionProperty(), // Defaults to "2.0"
  );

  ical.addComponent(
    EventComponent(
      attendees: [
        AttendeeProperty(
          "btutovic@gmail.com",
          commonName: "Brian",
          rsvpExpectation: true,
          userType: CalendarUserType.individual,
        ),
      ],
      recurrenceRules: [
        RecurrenceRuleProperty(
          frequency: RecurrenceFrequency.daily,
          count: 2,
        ),
      ],
    ),
  );

  // Serialize to String
  final icalText = ical.toString();

  print(icalText);

  // Prints:
  // BEGIN:VCALENDAR
  // PRODID:-//Powerbuilding//COACHAPP SCHED Calendar Version 1.0//EN
  // VERSION:2.0
  // CALSCALE:GREGORIAN
  // BEGIN:VEVENT
  // ATTENDEE;CUTYPE=INDIVIDUAL;RSVP=TRUE;CN=Brian:MAILTO:btutovic@gmail.com
  // RRULE:FREQ=DAILY;COUNT=2;INTERVAL=1;WKST=MO
  // END:VEVENT
  // END:VCALENDAR
}
```

