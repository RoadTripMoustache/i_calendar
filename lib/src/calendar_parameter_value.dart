import 'calendar_value.dart';

mixin CalendarParameterValue<InnerType> on CalendarValue<InnerType> {
  @override
  void validate() {
    assert(!sanitizeToString().contains("\""),
        "RFC2445 Section 4.2 prevents double quotes inside parameter values");
    super.validate();
  }

  @override
  String toString() {
    final sanitized = super.toString();
    // RFC2445 Section 4.1.1 requires parameter values
    // containing a COLON (:), SEMICOLON (;), or COMMA (,)
    // to be surrounded by double quotes
    return sanitized.contains(":") ||
            sanitized.contains(";") ||
            sanitized.contains(",")
        ? "\"$sanitized\""
        : sanitized;
  }
}
