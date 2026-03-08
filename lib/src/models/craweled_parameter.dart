import 'package:equatable/equatable.dart';

class CrawledParameter extends Equatable {
  final String name;
  final String value;

  const CrawledParameter(this.name, this.value);

  @override
  List<Object?> get props => [name, value];
}
