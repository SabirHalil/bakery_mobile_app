part of 'dough_factory_bloc.dart';

@immutable
sealed class DoughFactoryState{
  const DoughFactoryState();
}

final class DoughFactoryLoading extends DoughFactoryState {
  const DoughFactoryLoading();
}

final class DoughFactoryFailure extends DoughFactoryState {
  final String? error;
  const DoughFactoryFailure({this.error});
}

final class DoughGetListsSuccess extends DoughFactoryState {
 
  final List<DoughListModel>? doughLists;
  const DoughGetListsSuccess({this.doughLists});

}
