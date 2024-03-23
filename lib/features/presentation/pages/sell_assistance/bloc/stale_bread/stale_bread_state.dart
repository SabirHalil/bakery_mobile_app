part of 'stale_bread_bloc.dart';

sealed class StaleBreadState{
  const StaleBreadState();
  
 get staleBreadList => null;
}

final class StaleBreadLoading extends StaleBreadState {
  const StaleBreadLoading();
}

final class StaleBreadFailure extends StaleBreadState {
  final String? error;
  const StaleBreadFailure({this.error});
}

final class StaleBreadSuccess extends StaleBreadState {
  
  @override
  final List<StaleBreadAddedModel>? staleBreadList;
  
  const StaleBreadSuccess(
      {this.staleBreadList});
}

