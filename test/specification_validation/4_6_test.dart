import 'package:test/test.dart';
import 'package:i_calendar/i_calendar.dart';

void main() {
  /// RFC 2445 Section 4.6: Calendar Components
  /// This section defines the different types of calendar components that can be
  /// included in an iCalendar object: VEVENT, VTODO, VJOURNAL, VFREEBUSY, VTIMEZONE, and VALARM.
  group('4.6 - Calendar Components', () {
    
    /// Test VEVENT component (Event Component)
    /// Section 4.6.1: Event components are used to group properties that describe an event
    group('4.6.1 - Event Component (VEVENT)', () {
      test('Should create basic event component', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Test Event"),
          uniqueIdentifier: UniqueIdentifierProperty(value: "test-event-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VEVENT'));
        expect(output, contains('SUMMARY:Test Event'));
        expect(output, contains('UID:test-event-001@example.com'));
        expect(output, contains('END:VEVENT'));
      });

      test('Should support event with date/time properties', () {
        final startDate = DateTime(2024, 1, 15, 10, 0, 0);
        final endDate = DateTime(2024, 1, 15, 11, 0, 0);
        
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          uniqueIdentifier: UniqueIdentifierProperty(value: "meeting-001@example.com"),
          dateTimeStart: DateTimeStartProperty(startDate),
          end: DateTimeEndProperty(endDate),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VEVENT'));
        expect(output, contains('SUMMARY:Meeting'));
        expect(output, contains('DTSTART;'));
        expect(output, contains('DTEND;'));
        expect(output, contains('END:VEVENT'));
      });

      test('Should support event with attendees', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Team Meeting"),
          uniqueIdentifier: UniqueIdentifierProperty(value: "team-meeting-001@example.com"),
          attendees: [
            AttendeeProperty(
              "john@example.com",
              commonName: "John Doe",
              userType: CalendarUserType.individual,
            ),
            AttendeeProperty(
              "jane@example.com",
              commonName: "Jane Smith",
              userType: CalendarUserType.individual,
            ),
          ],
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VEVENT'));
        expect(output, contains('ATTENDEE;'));
        expect(output, contains('CN=John Doe'));
        expect(output, contains('CN=Jane Smith'));
        expect(output, contains('END:VEVENT'));
      });
    });

    /// Test VTODO component (To-Do Component)
    /// Section 4.6.2: To-Do components are used to group properties that describe a to-do
    group('4.6.2 - To-Do Component (VTODO)', () {
      test('Should create basic todo component', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(TodoComponent(
          summary: SummaryProperty("Complete project"),
          uniqueIdentifier: UniqueIdentifierProperty(value: "todo-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VTODO'));
        expect(output, contains('SUMMARY:Complete project'));
        expect(output, contains('UID:todo-001@example.com'));
        expect(output, contains('END:VTODO'));
      });

      test('Should support todo with due date and priority', () {
        final dueDate = DateTime(2024, 2, 1, 17, 0, 0);
        
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(TodoComponent(
          summary: SummaryProperty("Important Task"),
          uniqueIdentifier: UniqueIdentifierProperty(value: "task-001@example.com"),
          dateTimeDue: DateTimeDueProperty(dueDate),
          priority: PriorityProperty(1), // High priority
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VTODO'));
        expect(output, contains('SUMMARY:Important Task'));
        expect(output, contains('DUE;VALUE=DATE-TIME:20240201T220000Z'));
        expect(output, contains('PRIORITY:1'));
        expect(output, contains('END:VTODO'));
      });

      test('Should support todo with percent complete', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(TodoComponent(
          summary: SummaryProperty("In Progress Task"),
          uniqueIdentifier: UniqueIdentifierProperty(value: "progress-task-001@example.com"),
          percentComplete: PercentCompleteProperty(50),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VTODO'));
        expect(output, contains('PERCENT-COMPLETE:50'));
        expect(output, contains('END:VTODO'));
      });
    });

    /// Test VJOURNAL component (Journal Component)
    /// Section 4.6.3: Journal components are used to group properties that describe a journal entry
    group('4.6.3 - Journal Component (VJOURNAL)', () {
      test('Should create basic journal component', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(JournalComponent(
          summary: SummaryProperty("Daily Notes"),
          uniqueIdentifier: UniqueIdentifierProperty(value: "journal-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VJOURNAL'));
        expect(output, contains('SUMMARY:Daily Notes'));
        expect(output, contains('UID:journal-001@example.com'));
        expect(output, contains('END:VJOURNAL'));
      });

      test('Should support journal with description and date', () {
        final journalDate = DateTime(2024, 1, 10, 9, 0, 0);
        
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(JournalComponent(
          summary: SummaryProperty("Project Thoughts"),
          uniqueIdentifier: UniqueIdentifierProperty(value: "thoughts-001@example.com"),
          description: DescriptionProperty("Today I worked on the new feature implementation..."),
          dateTimeStart: DateTimeStartProperty(journalDate),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VJOURNAL'));
        expect(output, contains('DESCRIPTION:Today I worked on the new feature implementation...'));
        expect(output, contains('DTSTART;VALUE=DATE-TIME:20240110T140000Z'));
        expect(output, contains('END:VJOURNAL'));
      });
    });

    /// Test VFREEBUSY component (Free/Busy Component)
    /// Section 4.6.4: Free/Busy components are used to group properties that describe free or busy time
    group('4.6.4 - Free/Busy Component (VFREEBUSY)', () {
      test('Should create basic freebusy component', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(FreeBusyComponent(
          uniqueIdentifier: UniqueIdentifierProperty(value: "freebusy-001@example.com"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VFREEBUSY'));
        expect(output, contains('UID:freebusy-001@example.com'));
        expect(output, contains('END:VFREEBUSY'));
      });

      test('Should support freebusy with organizer and attendee', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(FreeBusyComponent(
          uniqueIdentifier: UniqueIdentifierProperty(value: "freebusy-002@example.com"),
          organizer: OrganizerProperty(
            "organizer@example.com",
            commonName: "Meeting Organizer",
          ),
          attendees: [
            AttendeeProperty(
              "attendee@example.com",
              commonName: "Attendee Name",
            ),
          ],
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VFREEBUSY'));
        expect(output, contains('ORGANIZER;'));
        expect(output, contains('CN=Meeting Organizer'));
        expect(output, contains('ATTENDEE;'));
        expect(output, contains('CN=Attendee Name'));
        expect(output, contains('END:VFREEBUSY'));
      });
    });

    /// Test VTIMEZONE component (Time Zone Component)
    /// Section 4.6.5: Time Zone components are used to group properties that define time zones
    group('4.6.5 - Time Zone Component (VTIMEZONE)', () {
      test('Should create basic timezone component', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(TimeZoneComponent(
          standardTimeZones: [],
          timeZoneIdentifier: TimeZoneIdentifierProperty("America/New_York"),
        ));
        
        final output = ical.toString();
        
        expect(output, contains('BEGIN:VTIMEZONE'));
        expect(output, contains('TZID:America/New_York'));
        expect(output, contains('END:VTIMEZONE'));
      });
    });

    /// Test multiple components in one calendar
    test('Should support multiple components in one calendar', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      
      ical.addComponent(EventComponent(
        summary: SummaryProperty("Meeting"),
        uniqueIdentifier: UniqueIdentifierProperty(value: "event-001@example.com"),
      ));
      
      ical.addComponent(TodoComponent(
        summary: SummaryProperty("Task"),
        uniqueIdentifier: UniqueIdentifierProperty(value: "todo-001@example.com"),
      ));
      
      ical.addComponent(JournalComponent(
        summary: SummaryProperty("Notes"),
        uniqueIdentifier: UniqueIdentifierProperty(value: "journal-001@example.com"),
      ));
      
      final output = ical.toString();
      
      expect(output, contains('BEGIN:VEVENT'));
      expect(output, contains('END:VEVENT'));
      expect(output, contains('BEGIN:VTODO'));
      expect(output, contains('END:VTODO'));
      expect(output, contains('BEGIN:VJOURNAL'));
      expect(output, contains('END:VJOURNAL'));
    });

    /// Test component validation
    test('Should require at least one component', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      
      expect(() => ical.toString(), throwsA(isA<AssertionError>()));
    });

    /// Test component parsing
    test('Should parse calendar with multiple components correctly', () {
      final originalIcal = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      
      originalIcal.addComponent(EventComponent(
        summary: SummaryProperty("Test Event"),
        uniqueIdentifier: UniqueIdentifierProperty(value: "event-001@example.com"),
      ));
      
      originalIcal.addComponent(TodoComponent(
        summary: SummaryProperty("Test Task"),
        uniqueIdentifier: UniqueIdentifierProperty(value: "todo-001@example.com"),
      ));
      
      final output = originalIcal.toString();
      final parsedCalendars = ICalendar.fromICalendarString(output);
      
      expect(parsedCalendars.length, equals(1));
      final parsedIcal = parsedCalendars.first;
      expect(parsedIcal.components.length, equals(2));
      
      final eventComponent = parsedIcal.components.firstWhere((c) => c is EventComponent) as EventComponent;
      final todoComponent = parsedIcal.components.firstWhere((c) => c is TodoComponent) as TodoComponent;
      
      expect(eventComponent.summary?.value.value, equals("Test Event"));
      expect(todoComponent.summary?.value.value, equals("Test Task"));
    });
  });
}