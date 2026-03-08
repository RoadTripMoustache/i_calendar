import 'package:equatable/equatable.dart';

import 'calendar_parameter.dart';

abstract class CalendarValue<InnerType> extends Equatable {
  final InnerType value;
  final ValueType type;

  const CalendarValue(this.value, this.type);

  void validate() {}

  String sanitizeToString() {
    return value.toString();
  }

  List<CalendarParameter> getInlineParameters() => [];

  @override
  String toString() {
    validate();
    return sanitizeToString();
  }

  @override
  List<Object?> get props => [
        value,
        type,
        getInlineParameters(),
      ];
}

enum ValueType {
  binary,
  boolean,
  calAddress,
  date,
  dateTime,
  duration,
  float,
  integer,
  period,
  recur,
  text,
  time,
  uri,
  utcOffset,
}

extension CalendarValueStringRepresentation on ValueType {
  String get value {
    switch (this) {
      case ValueType.binary:
        return "BINARY";
      case ValueType.boolean:
        return "BOOLEAN";
      case ValueType.calAddress:
        return "CAL-ADDRESS";
      case ValueType.date:
        return "DATE";
      case ValueType.dateTime:
        return "DATE-TIME";
      case ValueType.duration:
        return "DURATION";
      case ValueType.float:
        return "FLOAT";
      case ValueType.integer:
        return "INTEGER";
      case ValueType.period:
        return "PERIOD";
      case ValueType.recur:
        return "RECUR";
      case ValueType.text:
        return "TEXT";
      case ValueType.time:
        return "TIME";
      case ValueType.uri:
        return "URI";
      case ValueType.utcOffset:
        return "UTC-OFFSET";
    }
  }
}
