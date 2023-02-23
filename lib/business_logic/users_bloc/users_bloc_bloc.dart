import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/users_calls.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

part 'users_bloc_event.dart';
part 'users_bloc_state.dart';

class UsersBlocBloc extends Bloc<UsersBlocEvent, UsersBlocState> {
  final UserService userService;
  NonTitulaire? currentUser;
  String? imagePath;
  UsersBlocBloc({required this.userService})
      : super(const UsersBlocInitial(null)) {
    on<AddUser>((event, emit) async {
      await userService.creerNonTitulaire(event._user);
      currentUser = event._user;
      emit(UserAdded(event._user));
    });
    on<GetCurrentUser>((event, emit) async {
      try {
        final DocumentSnapshot<Map<String, dynamic>>? userDoc =
            await userService.getCurrentUser();
        if (userDoc == null || !userDoc.exists) {
          throw Exception("user doc doesn't exist");
        }
        currentUser = NonTitulaire.fromJson(userDoc.data()!);
        print("wa alooooo");
        emit(UserAdded(currentUser));
      } catch (e) {
        print("exception throwns");
        emit(const NoUserState(null));
      }
    });
    on<ChangeDroits>((event, emit) async {
      currentUser!.droitOffres = currentUser!.droitOffres;
      emit(UserAdded(currentUser));
    });
    on<ChangeConditions>((event, emit) async {
      currentUser!.accepterConditions = currentUser!.accepterConditions;
      emit(UserAdded(currentUser));
    });
  }
}
