import 'package:equatable/equatable.dart';

sealed class ActivityDetailsEvent extends Equatable {}

class DeleteActivityEvent extends ActivityDetailsEvent {
  final String id;

  new({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
