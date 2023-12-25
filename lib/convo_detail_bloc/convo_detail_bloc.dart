import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_solomon_project/entities/message.dart';

part 'convo_detail_event.dart';
part 'convo_detail_state.dart';

class ConvoDetailBloc extends Bloc<ConvoDetailEvent, ConvoDetailState> {
  ConvoDetailBloc() : super(ConvoDetailInitial()) {
    on<ConvoDetailEvent>((event, emit) {
      if (event is ConvoDetailLoad) {
        emit(ConvoDetailLoaded(
          title: 'Moving Out',
          id: event.convoId,
          messages: [
            Message(
              text: 'Should I move out?',
              createdAt: DateTime.now(),
              id: '0',
              fromSoloman: false,
            ),
            Message(
              text: 'I think you should...',
              createdAt: DateTime.now(),
              id: '1',
              fromSoloman: true,
            ),
          ],
          isSolomon: false,
        ));
      }
      if (event is NewConvo) {
        emit(ConvoDetailLoaded(
          title: 'New Convo',
          id: 'new',
          messages: const [],
          isSolomon: false,
        ));
      }
      if (event is UpdateConvoTitle) {
        if (state is ConvoDetailLoaded) {
          final currentState = state as ConvoDetailLoaded;

          emit(ConvoDetailLoaded(
            id: currentState.id,
            title: event.title,
            messages: currentState.messages,
            isSolomon: currentState.isSolomon,
          ));
        }
      }
      if (event is SendMessage) {
        if (state is ConvoDetailLoaded) {
          final currentState = state as ConvoDetailLoaded;

          emit(ConvoDetailLoaded(
            id: currentState.id,
            title: currentState.title,
            messages: [
              ...currentState.messages,
              event.message,
            ],
            isSolomon: currentState.isSolomon,
          ));
        }
      }
      if (event is SwitchPerson) {
        if (state is ConvoDetailLoaded) {
          final currentState = state as ConvoDetailLoaded;
          emit(ConvoDetailLoaded(
            id: currentState.id,
            title: currentState.title,
            messages: currentState.messages,
            isSolomon: event.toSolomon,
          ));
        }
      }
    });
  }
}
