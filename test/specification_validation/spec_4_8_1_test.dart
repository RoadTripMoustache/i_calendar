import 'package:test/test.dart';
import 'package:ics/ics.dart';

void main() {
  /// RFC 2445 Section 4.8.1: Descriptive Component Properties
  /// This section defines properties that provide descriptive information about calendar components.
  /// These properties include SUMMARY, DESCRIPTION, COMMENT, CATEGORIES, etc.
  group('4.8.1 - Descriptive Component Properties', () {
    /// Test SUMMARY property
    /// Section 4.8.1.12: This property defines a short summary or subject for the calendar component
    group('4.8.1.12 - Summary Property (SUMMARY)', () {
      test('Should include SUMMARY property in event', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Team Meeting"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('SUMMARY:Team Meeting'));
      });

      test('Should support SUMMARY with special characters', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting: Q&A Session (Important!)"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-002@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('SUMMARY:Meeting: Q&A Session (Important!)'));
      });

      test('Should support SUMMARY in different components', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );

        ical.addComponent(EventComponent(
          summary: SummaryProperty("Event Summary"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        ical.addComponent(TodoComponent(
          summary: SummaryProperty("Task Summary"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "todo-001@example.com"),
        ));

        ical.addComponent(JournalComponent(
          summary: SummaryProperty("Journal Summary"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "journal-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('SUMMARY:Event Summary'));
        expect(output, contains('SUMMARY:Task Summary'));
        expect(output, contains('SUMMARY:Journal Summary'));
      });
    });

    /// Test DESCRIPTION property
    /// Section 4.8.1.5: This property provides a more complete description of the calendar component
    group('4.8.1.5 - Description Property (DESCRIPTION)', () {
      test('Should include DESCRIPTION property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          description: DescriptionProperty(
              "This is a detailed description of the meeting agenda and objectives."),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(
            output,
            contains(
                'DESCRIPTION:This is a detailed description of the meeting agenda and objectives.'));
      });

      test('Should support multi-line DESCRIPTION', () {
        final multiLineDescription =
            "Line 1: Meeting overview\nLine 2: Agenda items\nLine 3: Expected outcomes";
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Multi-line Meeting"),
          description: DescriptionProperty(multiLineDescription),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-002@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('DESCRIPTION:'));
        // Multi-line content should be properly handled
        expect(output, contains('Line 1: Meeting overview'));
      });

      test('Should support DESCRIPTION with special characters', () {
        final specialDescription =
            "Meeting with special chars: àáâãäåæçèéêë & symbols: @#\$%^&*()";
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Special Chars Meeting"),
          description: DescriptionProperty(specialDescription),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-003@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('DESCRIPTION:'));
      });
    });

    /// Test COMMENT property
    /// Section 4.8.1.4: This property specifies non-processing information intended to provide a comment
    group('4.8.1.4 - Comment Property (COMMENT)', () {
      test('Should include COMMENT property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          comments: [
            CommentProperty("This is a comment about the meeting"),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('COMMENT:This is a comment about the meeting'));
      });

      test('Should support multiple COMMENT properties', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Meeting"),
          comments: [
            CommentProperty("First comment"),
            CommentProperty("Second comment"),
            CommentProperty("Third comment"),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('COMMENT:First comment'));
        expect(output, contains('COMMENT:Second comment'));
        expect(output, contains('COMMENT:Third comment'));
      });
    });

    /// Test CATEGORIES property
    /// Section 4.8.1.2: This property defines the categories for a calendar component
    group('4.8.1.2 - Categories Property (CATEGORIES)', () {
      test('Should include CATEGORIES property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Business Meeting"),
          categories: [
            CategoriesProperty(["BUSINESS", "MEETING"]),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('CATEGORIES:BUSINESS,MEETING'));
      });

      test('Should support single category', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Personal Event"),
          categories: [
            CategoriesProperty(["PERSONAL"]),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-002@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('CATEGORIES:PERSONAL'));
      });

      test('Should support multiple categories', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Conference"),
          categories: [
            CategoriesProperty(
                ["BUSINESS", "CONFERENCE", "NETWORKING", "EDUCATION"]),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-003@example.com"),
        ));

        final output = ical.toString();

        expect(output,
            contains('CATEGORIES:BUSINESS,CONFERENCE,NETWORKING,EDUCATION'));
      });
    });

    /// Test LOCATION property
    /// Section 4.8.1.7: This property defines the intended venue for the activity
    group('4.8.1.7 - Location Property (LOCATION)', () {
      test('Should include LOCATION property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Team Meeting"),
          location: LocationProperty("Conference Room A"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('LOCATION:Conference Room A'));
      });

      test('Should support detailed location information', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Client Meeting"),
          location: LocationProperty(
              "123 Business St, Suite 456, Business City, BC 12345"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-002@example.com"),
        ));

        final output = ical.toString();

        expect(
            output.replaceAll("\\,", ","),
            contains(
                'LOCATION:123 Business St, Suite 456, Business City, BC 12345'));
      });

      test('Should support virtual location', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Virtual Meeting"),
          location: LocationProperty("https://meet.example.com/room/123456"),
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-003@example.com"),
        ));

        final output = ical.toString();

        expect(
            output, contains('LOCATION:https://meet.example.com/room/123456'));
      });
    });

    /// Test RESOURCES property
    /// Section 4.8.1.10: This property defines the equipment or resources anticipated for an activity
    group('4.8.1.10 - Resources Property (RESOURCES)', () {
      test('Should include RESOURCES property', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Presentation"),
          resources: [
            ResourcesProperty(["PROJECTOR", "LAPTOP"]),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-001@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('RESOURCES:PROJECTOR,LAPTOP'));
      });

      test('Should support single resource', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Video Call"),
          resources: [
            ResourcesProperty(["WEBCAM"]),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-002@example.com"),
        ));

        final output = ical.toString();

        expect(output, contains('RESOURCES:WEBCAM'));
      });

      test('Should support multiple resources', () {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent(
          summary: SummaryProperty("Workshop"),
          resources: [
            ResourcesProperty([
              "PROJECTOR",
              "WHITEBOARD",
              "MARKERS",
              "FLIPCHART",
              "MICROPHONE"
            ]),
          ],
          uniqueIdentifier:
              UniqueIdentifierProperty(value: "event-003@example.com"),
        ));

        final output = ical.toString();

        expect(
            output,
            contains(
                'RESOURCES:PROJECTOR,WHITEBOARD,MARKERS,FLIPCHART,MICROPHONE'));
      });
    });

    /// Test combination of descriptive properties
    test('Should support multiple descriptive properties together', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("Annual Company Meeting"),
        description: DescriptionProperty(
            "Annual meeting to discuss company performance and future plans."),
        location: LocationProperty("Main Conference Room"),
        categories: [
          CategoriesProperty(["BUSINESS", "ANNUAL", "COMPANY"]),
        ],
        resources: [
          ResourcesProperty(["PROJECTOR", "MICROPHONE"]),
        ],
        comments: [
          CommentProperty("Please bring your laptops"),
          CommentProperty("Refreshments will be provided"),
        ],
        uniqueIdentifier:
            UniqueIdentifierProperty(value: "annual-meeting-2024@example.com"),
      ));

      final output = ical.toString();

      expect(output, contains('SUMMARY:Annual Company Meeting'));
      expect(
          output,
          contains(
              'DESCRIPTION:Annual meeting to discuss company performance and future plans.'));
      expect(output, contains('LOCATION:Main Conference Room'));
      expect(output, contains('CATEGORIES:BUSINESS,ANNUAL,COMPANY'));
      expect(output, contains('RESOURCES:PROJECTOR,MICROPHONE'));
      expect(output, contains('COMMENT:Please bring your laptops'));
      expect(output, contains('COMMENT:Refreshments will be provided'));
    });

    /// Test parsing of descriptive properties
    test('Should parse descriptive properties correctly', () {
      final originalIcal = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      originalIcal.addComponent(EventComponent(
        summary: SummaryProperty("Test Event"),
        description: DescriptionProperty("Test Description"),
        location: LocationProperty("Test Location"),
        categories: [
          CategoriesProperty(["TEST", "CATEGORY"]),
        ],
        uniqueIdentifier:
            UniqueIdentifierProperty(value: "test-event@example.com"),
      ));

      final output = originalIcal.toString();
      final parsedCalendars = ICalendar.fromICalendarString(output);

      expect(parsedCalendars.length, equals(1));
      final parsedEvent =
          parsedCalendars.first.components.first as EventComponent;

      expect(parsedEvent.summary?.value.value, equals("Test Event"));
      expect(parsedEvent.description?.value.value, equals("Test Description"));
      expect(parsedEvent.location?.value.value, equals("Test Location"));
      expect(
          parsedEvent.categories?.first.value.values[0].value, equals("TEST"));
      expect(parsedEvent.categories?.first.value.values[1].value,
          equals("CATEGORY"));
    });

    /// Test empty and null descriptive properties
    test('Should handle optional descriptive properties correctly', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("Minimal Event"),
        uniqueIdentifier:
            UniqueIdentifierProperty(value: "minimal-event@example.com"),
        // No description, location, categories, etc.
      ));

      final output = ical.toString();

      expect(output, contains('SUMMARY:Minimal Event'));
      expect(output, isNot(contains('DESCRIPTION:')));
      expect(output, isNot(contains('LOCATION:')));
      expect(output, isNot(contains('CATEGORIES:')));
      expect(output, isNot(contains('RESOURCES:')));
      expect(output, isNot(contains('COMMENT:')));
    });
  });
}
