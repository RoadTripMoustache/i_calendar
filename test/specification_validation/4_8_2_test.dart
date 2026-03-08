import 'package:test/test.dart';
import 'package:i_calendar/i_calendar.dart';

void main() {
  /// RFC 2445 Section 4.8.2: Date and Time Component Properties
  /// This section defines properties that specify date and time information for calendar components.
  /// These properties include DTSTART, DTEND, DUE, DTSTAMP, CREATED, LAST-MODIFIED, etc.
  group('4.8.2 - Date and Time Component Properties', () {
    
    /// Test DTSTART property (Date/Time Start)
    /// Section 4.8.2.4: This property specifies when the calendar component begins
    group('4.8.2.4 - Date/Time Start Property (DTSTART)', () {
      test('Should include DTSTART property with date-time value', () {
        final startDateTime = DateTime.utc(2024, 3, 15, 10, 30, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          dateTimeStart: DateTimeStartProperty(startDateTime),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DTSTART'));
        expect(output, contains('20240315T103000Z'));
      });

      test('Should support DTSTART with date-only value', () {
        final startDate = DateTime.utc(2024, 3, 15);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("All Day Event"),
          dateTimeStart: DateTimeStartProperty(startDate),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-002@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DTSTART;VALUE=DATE-TIME:20240315'));
      });

      test('Should support DTSTART with timezone', () {
        final startDateTime = DateTime(2024, 3, 15, 10, 30, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting with Timezone"),
          dateTimeStart: DateTimeStartProperty(
            startDateTime,
            timeZoneIdentifier: "America/New_York",
          ),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-003@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DTSTART'));
        expect(output, contains('TZID=America/New_York:20240315T103000'));
      });
    });

    /// Test DTEND property (Date/Time End)
    /// Section 4.8.2.2: This property specifies the date and time that a calendar component ends
    group('4.8.2.2 - Date/Time End Property (DTEND)', () {
      test('Should include DTEND property with date-time value', () {
        final startDateTime = DateTime.utc(2024, 3, 15, 10, 30, 0);
        final endDateTime = DateTime.utc(2024, 3, 15, 11, 30, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          dateTimeStart: DateTimeStartProperty(startDateTime),
          end: DateTimeEndProperty(endDateTime),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DTSTART;VALUE=DATE-TIME:20240315T103000'));
        expect(output, contains('DTEND;VALUE=DATE-TIME:20240315T113000'));
      });

      test('Should support DTEND with date-only value', () {
        final startDate = DateTime.utc(2024, 3, 15);
        final endDate = DateTime.utc(2024, 3, 16);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Multi-day Event"),
          dateTimeStart: DateTimeStartProperty(startDate),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-002@example.com"),
          end: DateTimeEndProperty(endDate),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DTSTART;VALUE=DATE-TIME:20240315'));
        expect(output, contains('DTEND;VALUE=DATE-TIME:20240316'));
      });
    });

    /// Test DUE property (Date/Time Due)
    /// Section 4.8.2.3: This property defines the date and time that a to-do is expected to be completed
    group('4.8.2.3 - Date/Time Due Property (DUE)', () {
      test('Should include DUE property in todo component', () {
        final dueDateTime = DateTime.utc(2024, 3, 20, 17, 0, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(TodoComponent(
          summary: SummaryProperty("Complete Report"),
          dateTimeDue: DateTimeDueProperty(dueDateTime),
          uniqueIdentifier: UniqueIdentifierProperty(value: "todo-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DUE;VALUE=DATE-TIME:20240320T170000'));
      });

      test('Should support DUE with date-only value', () {
        final dueDate = DateTime.utc(2024, 3, 20);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(TodoComponent(
          summary: SummaryProperty("Submit Application"),
          dateTimeDue: DateTimeDueProperty(dueDate),
          uniqueIdentifier: UniqueIdentifierProperty(value: "todo-002@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DUE;VALUE=DATE-TIME:20240320'));
      });
    });

    /// Test DTSTAMP property (Date/Time Stamp)
    /// Section 4.8.2.5: This property specifies the date and time that the calendar object was created
    group('4.8.2.5 - Date/Time Stamp Property (DTSTAMP)', () {
      test('Should include DTSTAMP property', () {
        final stampDateTime = DateTime.utc(2024, 3, 10, 8, 0, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          dateTimeStamp: DateTimeStampProperty(stampDateTime),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DTSTAMP:20240310T080000'));
      });

      test('Should support DTSTAMP in UTC format', () {
        final stampDateTime = DateTime.utc(2024, 3, 10, 8, 0, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("UTC Meeting"),
          dateTimeStamp: DateTimeStampProperty(stampDateTime),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-002@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('DTSTAMP:20240310T080000Z'));
      });
    });

    /// Test CREATED property (Date/Time Created)
    /// Section 4.8.2.1: This property specifies the date and time that the calendar information was created
    group('4.8.2.1 - Date/Time Created Property (CREATED)', () {
      test('Should include CREATED property', () {
        final createdDateTime = DateTime.utc(2024, 3, 5, 14, 30, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Created Event"),
          dateTimeCreated: DateTimeCreatedProperty(createdDateTime),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('CREATED:20240305T143000'));
      });
    });

    /// Test LAST-MODIFIED property (Date/Time Last Modified)
    /// Section 4.8.2.6: This property specifies the date and time that the information was last revised
    group('4.8.2.6 - Last Modified Property (LAST-MODIFIED)', () {
      test('Should include LAST-MODIFIED property', () {
        final modifiedDateTime = DateTime.utc(2024, 3, 12, 16, 45, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Modified Event"),
          lastModified: LastModifiedProperty(modifiedDateTime),
          uniqueIdentifier: UniqueIdentifierProperty(value: "event-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('LAST-MODIFIED:20240312T164500'));
      });
    });

    /// Test COMPLETED property (Date/Time Completed)
    /// Section 4.8.2.1: This property defines the date and time that a to-do was actually completed
    group('4.8.2.1 - Date/Time Completed Property (COMPLETED)', () {
      test('Should include COMPLETED property in todo component', () {
        final completedDateTime = DateTime.utc(2024, 3, 18, 15, 30, 0);
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(TodoComponent(
          summary: SummaryProperty("Completed Task"),
          dateTimeCompleted: DateTimeCompletedProperty(completedDateTime),
          uniqueIdentifier: UniqueIdentifierProperty(value: "todo-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('COMPLETED:20240318T153000'));
      });
    });

    /// Test date-time format validation
    test('Should format date-time values correctly', () {
      final dateTime = DateTime.utc(2024, 12, 31, 23, 59, 59);
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("New Year Event"),
        dateTimeStart: DateTimeStartProperty(dateTime),
        uniqueIdentifier: UniqueIdentifierProperty(value: "newyear-2024@example.com"),
      ));
      
      final output = ical.toString();
      
      // Should format as YYYYMMDDTHHMMSS
      expect(output, contains('DTSTART;VALUE=DATE-TIME:20241231T235959Z'));
    });

    /// Test date format validation
    test('Should format date values correctly', () {
      final date = DateTime(2024, 1, 1);
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("New Year Day"),
        dateTimeStart: DateTimeStartProperty(date),
        uniqueIdentifier: UniqueIdentifierProperty(value: "newyear-day-2024@example.com"),
      ));
      
      final output = ical.toString();
      
      // Should format as YYYYMMDD with VALUE=DATE parameter
      expect(output, contains('DTSTART;VALUE=DATE-TIME:20240101'));
    });

    /// Test multiple date/time properties together
    test('Should support multiple date/time properties in one component', () {
      final createdDateTime = DateTime.utc(2024, 3, 1, 9, 0, 0);
      final startDateTime = DateTime.utc(2024, 3, 15, 10, 0, 0);
      final endDateTime = DateTime.utc(2024, 3, 15, 11, 0, 0);
      final modifiedDateTime = DateTime.utc(2024, 3, 10, 14, 30, 0);
      
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("Complex Event"),
        dateTimeCreated: DateTimeCreatedProperty(createdDateTime),
        dateTimeStart: DateTimeStartProperty(startDateTime),
        end: DateTimeEndProperty(endDateTime),
        lastModified: LastModifiedProperty(modifiedDateTime),
        uniqueIdentifier: UniqueIdentifierProperty(value: "complex-event@example.com"),
      ));
      
      final output = ical.toString();
      
      expect(output, contains('CREATED:20240301T090000'));
      expect(output, contains('DTSTART;VALUE=DATE-TIME:20240315T100000'));
      expect(output, contains('DTEND;VALUE=DATE-TIME:20240315T110000'));
      expect(output, contains('LAST-MODIFIED:20240310T143000'));
    });

    /// Test parsing of date/time properties
    test('Should parse date/time properties correctly', () {
      final startDateTime = DateTime.utc(2024, 6, 15, 14, 30, 0);
      final endDateTime = DateTime.utc(2024, 6, 15, 15, 30, 0);
      
      final originalIcal = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      originalIcal.addComponent(EventComponent(
        summary: SummaryProperty("Test Event"),
        dateTimeStart: DateTimeStartProperty(startDateTime),
        end: DateTimeEndProperty(endDateTime),
        uniqueIdentifier: UniqueIdentifierProperty(value: "test-event@example.com"),
      ));
      
      final output = originalIcal.toString();
      final parsedCalendars = ICalendar.fromICalendarString(output);
      
      expect(parsedCalendars.length, equals(1));
      final parsedEvent = parsedCalendars.first.components.first as EventComponent;
      
      expect(parsedEvent.dateTimeStart?.value.value, equals(startDateTime));
    });

    /// Test UTC date/time handling
    test('Should handle UTC date/time values correctly', () {
      final utcDateTime = DateTime.utc(2024, 7, 4, 12, 0, 0);
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("UTC Event"),
        dateTimeStart: DateTimeStartProperty(utcDateTime),
        uniqueIdentifier: UniqueIdentifierProperty(value: "utc-event@example.com"),
      ));
      
      final output = ical.toString();
      
      // UTC times should end with 'Z'
      expect(output, contains('DTSTART;VALUE=DATE-TIME:20240704T120000Z'));
    });
  });
}