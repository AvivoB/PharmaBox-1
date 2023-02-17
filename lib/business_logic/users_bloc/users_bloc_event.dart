part of 'users_bloc_bloc.dart';

@immutable
abstract class UsersBlocEvent {}

class AddUser extends UsersBlocEvent {
  final NonTitulaire _user;
  AddUser({
    required NonTitulaire user,
  }) : _user = user;
}
class GetCurrentUser extends UsersBlocEvent{}
class ChangeDroits extends UsersBlocEvent{}
class ChangeConditions extends UsersBlocEvent{}