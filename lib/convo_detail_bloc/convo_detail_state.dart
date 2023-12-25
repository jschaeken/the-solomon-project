part of 'convo_detail_bloc.dart';

sealed class ConvoDetailState extends Equatable {}

final class ConvoDetailInitial extends ConvoDetailState {
  @override
  List<Object?> get props => [];
}

final class ConvoDetailLoading extends ConvoDetailState {
  @override
  List<Object?> get props => [];
}

final class ConvoDetailLoaded extends ConvoDetailState {
  final String id;
  final String title;
  final List<Message> messages;
  final bool isSolomon;

  ConvoDetailLoaded({
    required this.id,
    required this.title,
    required this.messages,
    required this.isSolomon,
  });

  @override
  List<Object?> get props => [id, title, messages, isSolomon];
}

final class ConvoDetailError extends ConvoDetailState {
  final String message;
  ConvoDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
