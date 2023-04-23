// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'membres_bloc.dart';

@immutable
abstract class MembresState {}

class MembresInitial extends MembresState {}

class MembresReady extends MembresState {
  List<NonTitulaire> membres;
  MembresReady({required this.membres});
}

class ExplorerMembresReady extends MembresState {
  List<NonTitulaire> membres;
  ExplorerMembresReady({required this.membres});
}

class MembresProfileReady extends MembresState {
  final List<NonTitulaire> membres;
  MembresProfileReady({
    required this.membres,
  });
}
