import 'package:test/test.dart';
import 'package:ics/ics.dart';

void main() {
  /// RFC 2445 Section 4.8.4: Relationship Component Properties
  /// This section defines properties that specify relationships between calendar components
  /// and other entities. These properties include ATTENDEE, ORGANIZER, RELATED-TO, etc.
  group('4.8.4 - Relationship Component Properties', () {
    /// Test ATTENDEE property
    /// Section 4.8.4.1: This property defines an "Attendee" within a calendar component
    group('4.8.4.1 - Attendee Property (ATTENDEE)', () {
      test('Should include basic ATTENDEE property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty("john.doe@example.com"),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('ATTENDEE:MAILTO:john.doe@example.com'));
      });

      test('Should support ATTENDEE with common name parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty(
              "john.doe@example.com",
              commonName: "John Doe",
            ),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output,
            contains('ATTENDEE;CN=John Doe:MAILTO:john.doe@example.com'));
      });

      test('Should support ATTENDEE with calendar user type parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty(
              "john.doe@example.com",
              userType: CalendarUserType.individual,
            ),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output,
            contains('ATTENDEE;CUTYPE=INDIVIDUAL:MAILTO:john.doe@example.com'));
      });

      test('Should support ATTENDEE with participation role parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty(
              "chair@example.com",
              participationRoleType: ParticipationRoleType.chair,
            ),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(
            output, contains('ATTENDEE;ROLE=CHAIR:MAILTO:chair@example.com'));
      });

      test('Should support ATTENDEE with participation status parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty(
              "attendee@example.com",
              participationStatusType: ParticipationStatusType.accepted,
            ),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output,
            contains('ATTENDEE;PARTSTAT=ACCEPTED:MAILTO:attendee@example.com'));
      });

      test('Should support ATTENDEE with RSVP expectation parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty(
              "attendee@example.com",
              rsvpExpectation: true,
            ),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(
            output, contains('ATTENDEE;RSVP=TRUE:MAILTO:attendee@example.com'));
      });

      test('Should support ATTENDEE with multiple parameters', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty(
              "john.doe@example.com",
              commonName: "John Doe",
              userType: CalendarUserType.individual,
              participationRoleType: ParticipationRoleType.reqParticipant,
              participationStatusType: ParticipationStatusType.needsAction,
              rsvpExpectation: true,
            ),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('ATTENDEE;'));
        expect(output, contains('CN=John Doe'));
        expect(output, contains('CUTYPE=INDIVIDUAL'));
        expect(output, contains('ROLE=REQ-PARTICIPANT'));
        expect(output, contains('PARTSTAT=NEEDS-ACTION'));
        expect(output, contains('RSVP=TRUE'));
        expect(output, contains(':MAILTO:john.doe@example.com'));
      });

      test('Should support multiple ATTENDEE properties', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Team Meeting"),
          attendees: [
            AttendeeProperty(
              "john.doe@example.com",
              commonName: "John Doe",
              participationRoleType: ParticipationRoleType.chair,
            ),
            AttendeeProperty(
              "jane.smith@example.com",
              commonName: "Jane Smith",
              participationRoleType: ParticipationRoleType.reqParticipant,
            ),
            AttendeeProperty(
              "bob.wilson@example.com",
              commonName: "Bob Wilson",
              participationRoleType: ParticipationRoleType.optParticipant,
            ),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('CN=John Doe'));
        expect(output, contains('CN=Jane Smith'));
        expect(output, contains('CN=Bob Wilson'));
        expect(output, contains('ROLE=CHAIR'));
        expect(output, contains('ROLE=REQ-PARTICIPANT'));
        expect(output, contains('ROLE=OPT-PARTICIPANT'));
      });
    });

    /// Test ORGANIZER property
    /// Section 4.8.4.3: This property defines the organizer for a calendar component
    group('4.8.4.3 - Organizer Property (ORGANIZER)', () {
      test('Should include basic ORGANIZER property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          organizer: OrganizerProperty("organizer@example.com"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('ORGANIZER:MAILTO:organizer@example.com'));
      });

      test('Should support ORGANIZER with common name parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          organizer: OrganizerProperty(
            "organizer@example.com",
            commonName: "Meeting Organizer",
          ),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(
            output,
            contains(
                'ORGANIZER;CN=Meeting Organizer:MAILTO:organizer@example.com'));
      });

      test('Should support ORGANIZER with sent-by parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          organizer: OrganizerProperty(
            "boss@example.com",
            commonName: "Boss",
            sentByEmail: "assistant@example.com",
          ),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('ORGANIZER;'));
        expect(output, contains('CN=Boss'));
        expect(output, contains('SENT-BY="MAILTO:assistant@example.com"'));
        expect(output, contains(':MAILTO:boss@example.com'));
      });

      test('Should support ORGANIZER with directory entry parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          organizer: OrganizerProperty(
            "organizer@example.com",
            commonName: "Organizer",
            directoryEntryUri:
                Uri.parse("ldap://example.com/cn=organizer,dc=example,dc=com"),
          ),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('ORGANIZER;'));
        expect(output, contains('CN=Organizer'));
        expect(
            output,
            contains(
                'DIR="ldap://example.com/cn=organizer,dc=example,dc=com"'));
        expect(output, contains(':MAILTO:organizer@example.com'));
      });
    });

    /// Test RELATED-TO property
    /// Section 4.8.4.5: This property is used to represent a relationship or reference between one calendar component and another
    group('4.8.4.5 - Related To Property (RELATED-TO)', () {
      test('Should include basic RELATED-TO property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Follow-up Meeting"),
          relatedTo: [
            RelatedToProperty("original-meeting-001@example.com"),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "followup-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('RELATED-TO:original-meeting-001@example.com'));
      });

      test('Should support RELATED-TO with relationship type parameter', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Child Task"),
          relatedTo: [
            RelatedToProperty(
              "parent-task-001@example.com",
              type: RelationshipType.parent,
            ),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "child-task-001@example.com"),
        ));

        final output = ical.toString();

        expect(output,
            contains('RELATED-TO;RELTYPE=PARENT:parent-task-001@example.com'));
      });

      test('Should support different relationship types', () {
        final relationshipTypes = [
          RelationshipType.parent,
          RelationshipType.child,
          RelationshipType.sibling,
        ];

        for (final relType in relationshipTypes) {
          final ical = ICalendar(
            productIdentifier: ProductIdentifierProperty("-//Test//EN"),
            version: VersionProperty(),
          );
          ical.addComponent(EventComponent(
            summary: SummaryProperty("Related Event"),
            relatedTo: [
              RelatedToProperty(
                "related-event@example.com",
                type: relType,
              ),
            ],
            uniqueIdentifier: UniqueIdentifierProperty(
                value: "event-${relType.name}@example.com"),
          ));

          final output = ical.toString();

          expect(
              output,
              contains(
                  'RELATED-TO;RELTYPE=${relType.name.toUpperCase()}:related-event@example.com'));
        }
      });
    });

    /// Test URL property
    /// Section 4.8.4.6: This property defines a Uniform Resource Locator (URL) associated with the iCalendar object
    group('4.8.4.6 - URL Property (URL)', () {
      test('Should include URL property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Conference"),
          url: URLProperty(Uri.parse("https://example.com/conference")),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "conference-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('URL:https://example.com/conference'));
      });

      test('Should support different URL schemes', () {
        final urls = [
          "https://example.com/event",
          "http://example.com/meeting",
          "ftp://files.example.com/documents",
          "mailto:info@example.com",
        ];

        for (final url in urls) {
          final ical = ICalendar(
            productIdentifier: ProductIdentifierProperty("-//Test//EN"),
            version: VersionProperty(),
          );
          ical.addComponent(EventComponent(
            summary: SummaryProperty("Event with URL"),
            url: URLProperty(Uri.parse(url)),
            uniqueIdentifier: UniqueIdentifierProperty(
                value: "event-url-${urls.indexOf(url)}@example.com"),
          ));

          final output = ical.toString();

          expect(output, contains('URL:$url'));
        }
      });
    });

    /// Test UID property (Unique Identifier)
    /// Section 4.8.4.7: This property defines the persistent, globally unique identifier for the calendar component
    group('4.8.4.7 - Unique Identifier Property (UID)', () {
      test('Should include UID property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "unique-meeting-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('UID:unique-meeting-001@example.com'));
      });

      test('Should support different UID formats', () {
        final uids = [
          "simple-id@example.com",
          "20240315T103000Z-001@example.com",
          "uuid-12345678-1234-1234-1234-123456789012@example.com",
          "event.2024.03.15.meeting@company.example.com",
        ];

        for (final uid in uids) {
          final ical = ICalendar(
            productIdentifier: ProductIdentifierProperty("-//Test//EN"),
            version: VersionProperty(),
          );
          ical.addComponent(EventComponent(
            summary: SummaryProperty("Event with UID"),
            uniqueIdentifier: UniqueIdentifierProperty(value: uid),
          ));

          final output = ical.toString();

          expect(output, contains('UID:$uid'));
        }
      });
    });

    /// Test combination of relationship properties
    test('Should support multiple relationship properties together', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("Complex Meeting"),
        organizer: OrganizerProperty(
          "organizer@example.com",
          commonName: "Meeting Organizer",
        ),
        attendees: [
          AttendeeProperty(
            "attendee1@example.com",
            commonName: "Attendee One",
            participationRoleType: ParticipationRoleType.reqParticipant,
            rsvpExpectation: true,
          ),
          AttendeeProperty(
            "attendee2@example.com",
            commonName: "Attendee Two",
            participationRoleType: ParticipationRoleType.optParticipant,
          ),
        ],
        relatedTo: [
          RelatedToProperty(
            "parent-meeting@example.com",
            type: RelationshipType.parent,
          ),
        ],
        url: URLProperty(Uri.parse("https://example.com/meeting-details")),
        uniqueIdentifier:
            UniqueIdentifierProperty(value: "complex-meeting@example.com"),
      ));

      final output = ical.toString();

      expect(
          output,
          contains(
              'ORGANIZER;CN=Meeting Organizer:MAILTO:organizer@example.com'));
      expect(
          output,
          contains(
              'ATTENDEE;CN=Attendee One;ROLE=REQ-PARTICIPANT;RSVP=TRUE:MAILTO:attendee1@example.com'));
      expect(
          output,
          contains(
              'ATTENDEE;CN=Attendee Two;ROLE=OPT-PARTICIPANT:MAILTO:attendee2@example.com'));
      expect(output,
          contains('RELATED-TO;RELTYPE=PARENT:parent-meeting@example.com'));
      expect(output, contains('URL:https://example.com/meeting-details'));
      expect(output, contains('UID:complex-meeting@example.com'));
    });

    /// Test parsing of relationship properties
    test('Should parse relationship properties correctly', () {
      final originalIcal = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      originalIcal.addComponent(EventComponent(
        summary: SummaryProperty("Test Meeting"),
        organizer: OrganizerProperty(
          "organizer@example.com",
          commonName: "Test Organizer",
        ),
        attendees: [
          AttendeeProperty(
            "attendee@example.com",
            commonName: "Test Attendee",
            participationRoleType: ParticipationRoleType.reqParticipant,
          ),
        ],
        uniqueIdentifier:
            UniqueIdentifierProperty(value: "test-meeting@example.com"),
      ));

      final output = originalIcal.toString();
      final parsedCalendars = ICalendar.fromICalendarString(output);

      expect(parsedCalendars.length, equals(1));
      final parsedEvent =
          parsedCalendars.first.components.first as EventComponent;

      expect(
          parsedEvent.organizer?.value.value, equals("organizer@example.com"));
      expect(parsedEvent.organizer?.commonName, equals("Test Organizer"));
      expect(parsedEvent.attendees?.length, equals(1));
      expect(parsedEvent.attendees?.first.value.value,
          equals("attendee@example.com"));
      expect(parsedEvent.attendees?.first.commonName, equals("Test Attendee"));
      expect(parsedEvent.uniqueIdentifier?.value.value,
          equals("test-meeting@example.com"));
    });

    /// Test calendar user types
    test('Should support all calendar user types', () {
      final userTypes = [
        CalendarUserType.individual,
        CalendarUserType.group,
        CalendarUserType.resource,
        CalendarUserType.room,
      ];

      for (final userType in userTypes) {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty(
              "user@example.com",
              userType: userType,
            ),
          ],
          uniqueIdentifier: UniqueIdentifierProperty(
              value: "meeting-${userType.name}@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('CUTYPE=${userType.name.toUpperCase()}'));
      }
    });

    /// Test participation statuses
    test('Should support all participation statuses', () {
      final statuses = [
        ParticipationStatusType.needsAction,
        ParticipationStatusType.accepted,
        ParticipationStatusType.declined,
        ParticipationStatusType.tentative,
        ParticipationStatusType.delegated,
      ];

      for (final status in statuses) {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          attendees: [
            AttendeeProperty(
              "attendee@example.com",
              participationStatusType: status,
            ),
          ],
          uniqueIdentifier: UniqueIdentifierProperty(
              value: "meeting-${status.name}@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('PARTSTAT=${status.value}'));
      }
    });
  });
}
