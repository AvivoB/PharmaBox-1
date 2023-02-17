part of 'lgo_bloc.dart';

@immutable
abstract class LgoState {
  final List<Lgo> _lgos;
  const LgoState(final List<Lgo> lgos)
      : _lgos = lgos;
  List<Lgo> get lgos => _lgos;
}

//empty state
class LgosInitial extends LgoState {
  const LgosInitial(super.lgos);
}

class LgosReady extends LgoState {
  const LgosReady(super.lgos);
}
