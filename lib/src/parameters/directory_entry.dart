// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../calendar_parameter.dart';
import '../models/craweled_parameter.dart';
import '../values/uri.dart';

/// RFC2445 Section 4.2.6
class DirectoryEntryParameter extends CalendarParameter<UriParameterValue> {
  final Uri uri;

  DirectoryEntryParameter(this.uri) : super("DIR", UriParameterValue(uri));

  factory DirectoryEntryParameter.fromCrawledParameter(
      CrawledParameter parameter) {
    assert(
      testCrawledParameter(parameter),
      "Received invalid parameter: ${parameter.name}",
    );
    return DirectoryEntryParameter(
      UriValue.fromCrawledStringValue(parameter.value).value,
    );
  }

  static bool testCrawledParameter(CrawledParameter parameter) =>
      parameter.name.toUpperCase() == "DIR";
}
