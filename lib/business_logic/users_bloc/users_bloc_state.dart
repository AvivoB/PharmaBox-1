part of 'users_bloc_bloc.dart';

@immutable
abstract class UsersBlocState {
  final NonTitulaire? _user;
  const UsersBlocState(final NonTitulaire? user) : _user = user;
  NonTitulaire? get user => _user;
}

class UsersBlocInitial extends UsersBlocState {
  const UsersBlocInitial(super.user);
}

class UserAdded extends UsersBlocState {
  const UserAdded(super.user);
}

class NoUserState extends UsersBlocState {
  const NoUserState(super.user);
}
