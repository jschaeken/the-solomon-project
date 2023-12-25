import 'package:bloc/bloc.dart';
import 'package:the_solomon_project/entities/convo_preview.dart';

part 'list_convo_event.dart';
part 'list_convo_state.dart';

class ListConvoBloc extends Bloc<ListConvoEvent, ListConvoState> {
  ListConvoBloc() : super(ListConvoInitial()) {
    on<ListConvoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
