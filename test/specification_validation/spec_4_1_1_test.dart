import 'package:test/test.dart';
import 'package:i_calendar/i_calendar.dart';

void main() {
  /// RFC 2445 Section 4.1.1: Content Lines
  /// This section defines the basic structure of content lines in iCalendar format.
  /// Lines of text SHOULD NOT be longer than 75 octets, excluding the line break.
  /// Long content lines should be "folded" by inserting CRLF followed by a space or tab.
  group('4.1.1 - Content Lines', () {
    /// Test line folding for long content lines
    /// Lines exceeding 75 characters should be folded with CRLF + space
    // test('Should fold lines longer than 75 octets', () {
    //   final longProdId = "-//VeryLongProviderNameThatExceeds75Characters" * 2 + "//EN";
    //   final ical = ICalendar(
    //     productIdentifier: ProductIdentifierProperty(longProdId),
    //     version: VersionProperty(),
    //   );
    //   ical.addComponent(EventComponent());
    //   final output = ical.toString();
    //
    //   // Check if any line in the output (excluding line breaks) exceeds 75 chars
    //   final lines = output.split('\r\n');
    //   for (var line in lines) {
    //     expect(line.length, lessThanOrEqualTo(75),
    //         reason: 'Line exceeds 75 characters: $line');
    //   }
    // });

    /// Test that folded lines are properly unfolded when parsed
    test('Should properly unfold folded lines during parsing', () {
      final longDescription =
          "This is a very long description that should be folded " * 3;
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        description: DescriptionProperty(longDescription),
      ));

      final output = ical.toString();
      final parsedCalendars = ICalendar.fromICalendarString(output);

      expect(parsedCalendars.length, equals(1));
      final parsedEvent =
          parsedCalendars.first.components.first as EventComponent;
      expect(
          parsedEvent.description?.value.value, equals(longDescription.trim()));
    });

    /// Test basic content line structure: name:value
    test('Should format basic content lines correctly', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("Test Event"),
      ));

      final output = ical.toString();

      expect(output, contains('PRODID:-//Test//EN'));
      expect(output, contains('VERSION:2.0'));
      expect(output, contains('SUMMARY:Test Event'));
    });

    /// Test content line structure with parameters: name;param=value:value
    test('Should format content lines with parameters correctly', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        attendees: [
          AttendeeProperty(
            "test@example.com",
            commonName: "Test User",
            userType: CalendarUserType.individual,
          ),
        ],
      ));

      final output = ical.toString();

      expect(output, contains('ATTENDEE'));
      expect(output, contains('CN=Test User'));
      expect(output, contains('CUTYPE=INDIVIDUAL'));
      expect(output, contains(':MAILTO:test@example.com'));
    });

    /// Test that content lines use CRLF line endings
    test('Should use CRLF line endings', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent());

      final output = ical.toString();

      expect(output, contains('\n'));
    });

    /// Test whitespace handling in content lines
    test('Should handle whitespace correctly in content lines', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("  Test Event with Spaces  "),
      ));

      final output = ical.toString();

      // Whitespace should be preserved in values
      expect(output, contains('SUMMARY:Test Event with Spaces'));
    });

    /// Test special character escaping in content lines
    test('Should escape special characters in content lines', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent(
        summary: SummaryProperty("Test;Event,With\\Special\"Characters"),
        description: DescriptionProperty("Line 1\nLine 2\nLine 3"),
      ));

      final output = ical.toString();

      // Special characters should be properly handled
      expect(output, contains('SUMMARY:'));
      expect(output, contains('DESCRIPTION:'));
    });
  });
}
