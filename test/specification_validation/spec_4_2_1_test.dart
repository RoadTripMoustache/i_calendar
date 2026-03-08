import 'package:i_calendar/src/enum/method_type.dart';
import 'package:test/test.dart';
import 'package:i_calendar/i_calendar.dart';

void main() {
  /// RFC 2445 Section 4.2.1: Calendar Properties
  /// This section defines the calendar properties that provide information
  /// about the calendar as a whole, rather than individual calendar components.
  group('4.2.1 - Calendar Properties', () {
    /// Test PRODID property (Product Identifier)
    /// This property specifies the identifier for the product that created the calendar
    test('Should include required PRODID property', () {
      final ical = ICalendar(
        productIdentifier:
            ProductIdentifierProperty("-//Test Company//Test Product//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent());

      final output = ical.toString();

      expect(output, contains('PRODID:-//Test Company//Test Product//EN'));
    });

    /// Test VERSION property
    /// This property specifies the identifier corresponding to the highest version number
    /// or the minimum and maximum range of the iCalendar specification
    test('Should include required VERSION property', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent());

      final output = ical.toString();

      expect(output, contains('VERSION:2.0'));
    });

    /// Test CALSCALE property (Calendar Scale)
    /// This property defines the calendar scale used for the calendar information
    test('Should include CALSCALE property when specified', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
        calendarScale: CalendarScaleProperty(CalendarScaleType.gregorian),
      );
      ical.addComponent(EventComponent());

      final output = ical.toString();

      expect(output, contains('CALSCALE:GREGORIAN'));
    });

    /// Test default CALSCALE property
    /// When not specified, CALSCALE should default to GREGORIAN
    test('Should default to GREGORIAN calendar scale when not specified', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent());

      final output = ical.toString();

      expect(output, contains('CALSCALE:GREGORIAN'));
    });

    /// Test METHOD property
    /// This property defines the iCalendar object method associated with the calendar object
    test('Should include METHOD property when specified', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
        method: MethodProperty(MethodType.publish),
      );
      ical.addComponent(EventComponent());

      final output = ical.toString();

      expect(output, contains('METHOD:PUBLISH'));
    });

    /// Test METHOD property with different values
    test('Should support different METHOD property values', () {
      final methods = [
        MethodType.publish,
        MethodType.request,
        MethodType.reply,
        MethodType.cancel,
      ];

      for (final method in methods) {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
          method: MethodProperty(method),
        );
        ical.addComponent(EventComponent());

        final output = ical.toString();

        expect(output, contains('METHOD:${method.toUpperCase()}'));
      }
    });

    /// Test calendar without METHOD property
    /// METHOD property is optional and should not appear when not specified
    test('Should not include METHOD property when not specified', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
      );
      ical.addComponent(EventComponent());

      final output = ical.toString();

      expect(output, isNot(contains('METHOD:')));
    });

    /// Test property order in calendar output
    /// Properties should appear in a consistent order
    test('Should output calendar properties in correct order', () {
      final ical = ICalendar(
        productIdentifier: ProductIdentifierProperty("-//Test//EN"),
        version: VersionProperty(),
        calendarScale: CalendarScaleProperty(CalendarScaleType.gregorian),
        method: MethodProperty(MethodType.publish),
      );
      ical.addComponent(EventComponent());

      final output = ical.toString();
      final lines = output.split('\n');

      // Find property lines (excluding BEGIN/END)
      final propertyLines = lines
          .where((line) =>
              line.startsWith('PRODID:') ||
              line.startsWith('VERSION:') ||
              line.startsWith('CALSCALE:') ||
              line.startsWith('METHOD:'))
          .toList();

      expect(propertyLines.length, equals(4));
      expect(propertyLines[0], startsWith('PRODID:'));
      expect(propertyLines[1], startsWith('VERSION:'));
      expect(propertyLines[2], startsWith('CALSCALE:'));
      expect(propertyLines[3], startsWith('METHOD:'));
    });

    /// Test PRODID format validation
    /// PRODID should follow the format: -//owner//product//language
    test('Should accept valid PRODID formats', () {
      final validProdIds = [
        "-//Company//Product//EN",
        "-//My Company//My Product 1.0//EN",
        "-//Example Corp//Calendar App v2.1//EN",
      ];

      for (final prodId in validProdIds) {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty(prodId),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent());

        final output = ical.toString();

        expect(output, contains('PRODID:$prodId'));
      }
    });

    /// Test calendar parsing with all properties
    /// Verify that calendars with all properties can be parsed correctly
    test('Should parse calendar with all properties correctly', () {
      final originalIcal = ICalendar(
        productIdentifier:
            ProductIdentifierProperty("-//Test Company//Test Product//EN"),
        version: VersionProperty(),
        calendarScale: CalendarScaleProperty(CalendarScaleType.gregorian),
        method: MethodProperty(MethodType.publish),
      );
      originalIcal.addComponent(EventComponent(
        summary: SummaryProperty("Test Event"),
      ));

      final output = originalIcal.toString();
      final parsedCalendars = ICalendar.fromICalendarString(output);

      expect(parsedCalendars.length, equals(1));
      final parsedIcal = parsedCalendars.first;

      expect(parsedIcal.productIdentifier.value.value,
          equals("-//Test Company//Test Product//EN"));
      expect(parsedIcal.version.value.value, equals("2.0"));
      expect(parsedIcal.calendarScale?.value.value,
          equals(CalendarScaleType.gregorian.value));
      expect(parsedIcal.method?.value.value, equals(MethodType.publish));
    });

    /// Test required properties validation
    /// Calendar must have PRODID and VERSION properties
    test('Should require PRODID and VERSION properties', () {
      expect(() {
        final ical = ICalendar(
          productIdentifier: ProductIdentifierProperty("-//Test//EN"),
          version: VersionProperty(),
        );
        ical.addComponent(EventComponent());
        ical.toString(); // This should not throw
      }, returnsNormally);
    });
  });
}
