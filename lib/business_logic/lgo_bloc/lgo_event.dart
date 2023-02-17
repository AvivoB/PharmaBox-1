part of 'lgo_bloc.dart';

@immutable
abstract class LgoEvent {}


class InitialiseLgo extends LgoEvent {
   List<Lgo> _lgos;

  InitialiseLgo({
    required List<Lgo> lgos
  }) : _lgos = lgos;
}

class AddLocalLgo extends LgoEvent {
   Lgo _lgo;
  AddLocalLgo({
    required Lgo lgo,
  }) : _lgo = lgo;
}

class RemoveLocalLgo extends LgoEvent {
   Lgo _lgo;
  RemoveLocalLgo({
    required Lgo lgo,
  }) : _lgo = lgo;
}

class AddRemoteLgo extends LgoEvent {
   Lgo _lgo;
  AddRemoteLgo({
    required Lgo lgo,
  }) : _lgo = lgo;
}

class RemoveRemoteLgo extends LgoEvent {
  final Lgo _lgo;
  RemoveRemoteLgo({
    required Lgo lgo,
  }) : _lgo = lgo;
}

class UpdateLgo extends LgoEvent {

}
class Init extends LgoEvent{}

