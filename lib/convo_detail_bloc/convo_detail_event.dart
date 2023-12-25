part of 'convo_detail_bloc.dart';

sealed class ConvoDetailEvent extends Equatable {}

class ConvoDetailLoad extends ConvoDetailEvent {
  final String convoId;

  ConvoDetailLoad({required this.convoId});

  @override
  List<Object?> get props => [convoId];
}

class NewConvo extends ConvoDetailEvent {
  @override
  List<Object?> get props => [];
}

class UpdateConvoTitle extends ConvoDetailEvent {
  final String title;

  UpdateConvoTitle({required this.title});

  @override
  List<Object?> get props => [title];
}

class SendMessage extends ConvoDetailEvent {
  final Message message;

  SendMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

class SwitchPerson extends ConvoDetailEvent {
  final bool toSolomon;

  SwitchPerson({required this.toSolomon});

  @override
  List<Object?> get props => [toSolomon];
}
