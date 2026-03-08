// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:intl/locale.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../parameters/common_name.dart';
import '../parameters/directory_entry.dart';
import '../parameters/language.dart';
import '../parameters/sent_by.dart';
import '../values/calendar_user_address.dart';

/// RFC2445 Section 4.8.4.3
class OrganizerProperty extends CalendarProperty<CalendarUserAddressValue> {
  final Locale? locale;
  final String? commonName;
  final Uri? directoryEntryUri;
  final String? sentByEmail;

  OrganizerProperty(
    String email, {
    this.locale,
    this.commonName,
    this.directoryEntryUri,
    this.sentByEmail,
  }) : super("ORGANIZER", CalendarUserAddressValue(email));

  factory OrganizerProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "ORGANIZER",
      "Received invalid property: ${property.name}",
    );

    return OrganizerProperty(
      CalendarUserAddressValue.fromCrawledStringValue(property.value).value,
      locale: property.parameters
              .where(LanguageParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(LanguageParameter.testCrawledParameter)
              .map((e) => LanguageParameter.fromCrawledParameter(e))
              .first
              .locale,
      sentByEmail: property.parameters
              .where(SentByParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(SentByParameter.testCrawledParameter)
              .map((e) => SentByParameter.fromCrawledParameter(e))
              .first
              .email,
      commonName: property.parameters
              .where(CommonNameParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(CommonNameParameter.testCrawledParameter)
              .map((e) => CommonNameParameter.fromCrawledParameter(e))
              .first
              .commonName,
      directoryEntryUri: property.parameters
              .where(DirectoryEntryParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(DirectoryEntryParameter.testCrawledParameter)
              .map((e) => DirectoryEntryParameter.fromCrawledParameter(e))
              .first
              .uri,
    );
  }

  @override
  List<CalendarParameter<CalendarParameterValue>> getParameters() {
    return [
      if (locale != null) LanguageParameter(locale!),
      if (commonName != null) CommonNameParameter(commonName!),
      if (directoryEntryUri != null)
        DirectoryEntryParameter(directoryEntryUri!),
      if (sentByEmail != null) SentByParameter(sentByEmail!),
    ];
  }
}
