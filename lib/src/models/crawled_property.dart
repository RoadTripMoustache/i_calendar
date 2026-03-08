import 'package:equatable/equatable.dart';

import 'craweled_parameter.dart';

class CrawledProperty extends Equatable {
  final String name;
  final String value;
  final List<CrawledParameter> parameters;

  const CrawledProperty({
    required this.name,
    required this.value,
    required this.parameters,
  });

  @override
  List<Object?> get props => [];
}
