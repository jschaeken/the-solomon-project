part of 'list_convo_bloc.dart';

sealed class ListConvoEvent {}

final class ListConvoLoad extends ListConvoEvent {}

final class ListConvoAdd extends ListConvoEvent {
  final ConvoPreview convo;

  ListConvoAdd(this.convo);
}

final class ListConvoRemove extends ListConvoEvent {
  final String id;

  ListConvoRemove(this.id);
}

final class ListConvoUpdate extends ListConvoEvent {
  final ConvoPreview convo;

  ListConvoUpdate(this.convo);
}
