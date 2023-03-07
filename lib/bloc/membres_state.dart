part of 'membres_bloc.dart';

@immutable
abstract class MembresState {}

class MembresInitial extends MembresState {}
class MembresReady extends MembresState{
  List<NonTitulaire> membres;
  MembresReady({required this.membres});
}
class ExplorerMembresReady extends MembresState{
  List<NonTitulaire> membres;
  ExplorerMembresReady({required this.membres});
}