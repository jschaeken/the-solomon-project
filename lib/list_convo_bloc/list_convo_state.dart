part of 'list_convo_bloc.dart';

sealed class ListConvoState {}

final class ListConvoInitial extends ListConvoState {}

final class ListConvoLoading extends ListConvoState {}

final class ListConvoLoaded extends ListConvoState {
  final List<ConvoPreview> convos;

  ListConvoLoaded(this.convos);
}
