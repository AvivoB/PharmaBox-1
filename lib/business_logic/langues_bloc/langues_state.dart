part of 'langues_bloc.dart';

@immutable
abstract class LanguesState {
   List<Langue> _langues;
   LanguesState( List<Langue> langues) : _langues = langues;
  List<Langue> get langues => _langues;
}

//empty state
class LanguesInitial extends LanguesState {
   LanguesInitial(super.langues);
}

class LanguesReady extends LanguesState {
   LanguesReady(super.langues);
}
