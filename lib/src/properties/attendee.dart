// Copyright (c) 2023 Brian Tutovic All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:intl/locale.dart';

import '../calendar_parameter.dart';
import '../calendar_parameter_value.dart';
import '../calendar_property.dart';
import '../models/crawled_property.dart';
import '../parameters/calendar_user_type.dart';
import '../parameters/common_name.dart';
import '../parameters/delegatees.dart';
import '../parameters/delegators.dart';
import '../parameters/directory_entry.dart';
import '../parameters/group_or_list_membership.dart';
import '../parameters/language.dart';
import '../parameters/participation_role.dart';
import '../parameters/participation_status.dart';
import '../parameters/rsvp_expectation.dart';
import '../parameters/sent_by.dart';
import '../values/calendar_user_address.dart';

/// RFC2445 Section 4.8.4.1
class AttendeeProperty extends CalendarProperty<CalendarUserAddressValue> {
  final Locale? locale;
  final CalendarUserType? userType;
  final List<String>? membershipEmails;
  final ParticipationRoleType? participationRoleType;
  final ParticipationStatusType? participationStatusType;
  final bool? rsvpExpectation;
  final List<String>? delegateeEmails;
  final List<String>? delegatorEmails;
  final String? sentByEmail;
  final String? commonName;
  final Uri? directoryEntryUri;

  AttendeeProperty(
    String email, {
    this.locale,
    this.userType,
    this.membershipEmails,
    this.participationRoleType,
    this.participationStatusType,
    this.rsvpExpectation,
    this.delegateeEmails,
    this.delegatorEmails,
    this.sentByEmail,
    this.commonName,
    this.directoryEntryUri,
  }) : super("ATTENDEE", CalendarUserAddressValue(email));

  factory AttendeeProperty.fromCrawledProperty(CrawledProperty property) {
    assert(
      property.name.toUpperCase() == "ATTENDEE",
      "Received invalid property: ${property.name}",
    );

    return AttendeeProperty(
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
      userType: property.parameters
              .where(CalendarUserTypeParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(CalendarUserTypeParameter.testCrawledParameter)
              .map((e) => CalendarUserTypeParameter.fromCrawledParameter(e))
              .first
              .type,
      membershipEmails: property.parameters
              .where(GroupOrListMembershipParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(GroupOrListMembershipParameter.testCrawledParameter)
              .map(
                  (e) => GroupOrListMembershipParameter.fromCrawledParameter(e))
              .first
              .emails,
      participationRoleType: property.parameters
              .where(ParticipationRoleParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(ParticipationRoleParameter.testCrawledParameter)
              .map((e) => ParticipationRoleParameter.fromCrawledParameter(e))
              .first
              .type,
      participationStatusType: property.parameters
              .where(ParticipationStatusParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(ParticipationStatusParameter.testCrawledParameter)
              .map((e) => ParticipationStatusParameter.fromCrawledParameter(e))
              .first
              .type,
      rsvpExpectation: property.parameters
              .where(RSVPExpectationParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(RSVPExpectationParameter.testCrawledParameter)
              .map((e) => RSVPExpectationParameter.fromCrawledParameter(e))
              .first
              .rsvp,
      delegateeEmails: property.parameters
              .where(DelegateesParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(DelegateesParameter.testCrawledParameter)
              .map((e) => DelegateesParameter.fromCrawledParameter(e))
              .first
              .emails,
      delegatorEmails: property.parameters
              .where(DelegatorsParameter.testCrawledParameter)
              .isEmpty
          ? null
          : property.parameters
              .where(DelegatorsParameter.testCrawledParameter)
              .map((e) => DelegatorsParameter.fromCrawledParameter(e))
              .first
              .emails,
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
      if (userType != null) CalendarUserTypeParameter(userType!),
      if (membershipEmails != null && membershipEmails!.isNotEmpty)
        GroupOrListMembershipParameter(membershipEmails!),
      if (participationRoleType != null)
        ParticipationRoleParameter(participationRoleType!),
      if (participationStatusType != null)
        ParticipationStatusParameter(participationStatusType!),
      if (rsvpExpectation != null) RSVPExpectationParameter(rsvpExpectation!),
      if (delegateeEmails != null && delegateeEmails!.isNotEmpty)
        DelegateesParameter(delegateeEmails!),
      if (delegatorEmails != null && delegatorEmails!.isNotEmpty)
        DelegatorsParameter(delegatorEmails!),
      if (sentByEmail != null) SentByParameter(sentByEmail!),
      if (commonName != null) CommonNameParameter(commonName!),
      if (directoryEntryUri != null)
        DirectoryEntryParameter(directoryEntryUri!),
    ];
  }
}
