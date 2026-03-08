import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/text.dart';

/// RFC2445 Section 4.2.16
class ParticipationRoleParameter extends CalendarParameter<TextParameterValue> {
  final ParticipationRoleType type;

  ParticipationRoleParameter(this.type)
      : super("ROLE", TextParameterValue(type.value));

  factory ParticipationRoleParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return ParticipationRoleParameter(
      ParticipationRoleType.values.firstWhere(
        (element) =>
            element.value.toUpperCase() ==
            TextValue.fromCrawledStringValue(parameter.value)
                .value
                .toUpperCase(),
      ),
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "ROLE";
}

enum ParticipationRoleType {
  chair,
  reqParticipant,
  optParticipant,
  nonParticipant,
}

extension ParticipationRoleTypeStringValue on ParticipationRoleType {
  String get value {
    switch (this) {
      case ParticipationRoleType.chair:
        return "CHAIR";
      case ParticipationRoleType.reqParticipant:
        return "REQ-PARTICIPANT";
      case ParticipationRoleType.optParticipant:
        return "OPT-PARTICIPANT";
      case ParticipationRoleType.nonParticipant:
        return "NON-PARTICIPANT";
    }
  }
}
