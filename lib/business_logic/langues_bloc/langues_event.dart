part of 'langues_bloc.dart';

@immutable
abstract class LanguesEvent {}

class InitialiseLangue extends LanguesEvent {
  List<Langue> _langues;

  InitialiseLangue({required List<Langue> langues}) : _langues = langues;
}

class AddLocalLangue extends LanguesEvent {
  Langue _langue;
  AddLocalLangue({
    required Langue langue,
  }) : _langue = langue;
}

class RemoveLocalLangue extends LanguesEvent {
  String _langue;
  RemoveLocalLangue({
    required String langue,
  }) : _langue = langue;
}

class AddRemoteLangue extends LanguesEvent {
  Langue _langue;
  AddRemoteLangue({
    required Langue langue,
  }) : _langue = langue;
}

class RemoveRemoteLangue extends LanguesEvent {
  Langue _langue;
  RemoveRemoteLangue({
    required Langue langue,
  }) : _langue = langue;
}

class UpdateLangue extends LanguesEvent {}

class Init extends LanguesEvent {}
