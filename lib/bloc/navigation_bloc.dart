import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';
import 'package:pharmabox/enums/user_type.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  UsersBlocBloc authenticationBloc;
  NavigationBloc({required this.authenticationBloc})
      : super(NavigationInitial()) {
    on<NavItemClicked>((event, emit) {
      if (event.currentIndex == 0) {
        emit(NavigationInitial());
      } else if (event.currentIndex == 1) {
        print(authenticationBloc.currentUser!.poste);
        if (authenticationBloc.currentUser!.poste == UserType.tutor) {
          emit(PharmaJobTituState());
        } else {
          emit(PharmaJobNonTituState());
        }
      } else {
        print("we here");
        emit(ProfileState());
      }
    });
    on<Reset>((event, emit) {
      emit(NavigationInitial());
    });
  }
}
