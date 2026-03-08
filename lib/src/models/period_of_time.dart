// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

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
