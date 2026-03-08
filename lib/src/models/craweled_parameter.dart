// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:equatable/equatable.dart';

class CrawledParameter extends Equatable {
  final String name;
  final String value;

  const CrawledParameter(this.name, this.value);

  @override
  List<Object?> get props => [name, value];
}
