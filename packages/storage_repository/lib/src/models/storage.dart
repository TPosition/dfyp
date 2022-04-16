import 'package:equatable/equatable.dart';

class Storage extends Equatable {
  const Storage({
    required this.path,
  });

  final String path;

  @override
  List<Object?> get props => [path];
}
