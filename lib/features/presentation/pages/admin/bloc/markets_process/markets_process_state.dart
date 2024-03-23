part of 'markets_process_bloc.dart';
@immutable
sealed class MarketsProcessState{
  const MarketsProcessState();
  
}

final class MarketsProcessLoading extends MarketsProcessState {
  const MarketsProcessLoading();
 
}

final class MarketsProcessFailure extends MarketsProcessState {
  final String? error;
  const MarketsProcessFailure({this.error});

}

final class MarketsProcessSuccess extends MarketsProcessState {
  
  final List<MarketModel>? marketsProcessList;

  const MarketsProcessSuccess({this.marketsProcessList});
}

