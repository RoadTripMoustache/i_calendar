import 'package:equatable/equatable.dart';

class PeriodOfTime extends Equatable {
  final DateTime start;
  final DateTime? end;
  final Duration? duration;

  const PeriodOfTime({
    required this.start,
    this.end,
    this.duration,
  });

  @override
  List<Object?> get props => [start, end, duration];
}
