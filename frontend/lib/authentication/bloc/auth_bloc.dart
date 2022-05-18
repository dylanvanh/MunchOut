import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UnauthorisedState()) {
    // on<ValidateLoginDetailsEvent>(_onValidateLoginDetails);
    on<GetActiveUserDetailsEvent>(_onGetActiveUserDetail);
    on<LogoutEvent>(_onLogout);
    on<AuthoriseUserEvent>(_onAuthoriseUserEvent);

    //when the login bloc updates the "User _validatedUser" in UserRepository
    // stream pushes new user object
    _userSubscription = _userRepository.user.listen(
      (user) => add(
        GetActiveUserDetailsEvent(user: user),
      ),
    );
  }

  final UserRepository _userRepository;
  late final StreamSubscription<User> _userSubscription;

  Future<void> _onGetActiveUserDetail(
    GetActiveUserDetailsEvent event,
    Emitter<AuthState> emit,
  ) async {
    final activeUser = event.user;
    if (activeUser.authStatus == AuthenticationStatus.authenticated) {
      emit(AuthorisedState(validatedUser: activeUser));
    } else {
      emit(UnauthorisedState());
    }
  }

  Future<void> _onAuthoriseUserEvent(
      AuthoriseUserEvent event, Emitter<AuthState> emit) async {
    if (event.user.authStatus == AuthenticationStatus.authenticated) {
      emit(AuthorisedState(validatedUser: event.user));
    } else {
      emit(UnauthorisedState());
    }
  }

  //Change state to unauthorised, clear details
  void _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) {
    //set state back to unauthorised
    emit(UnauthorisedState());
  }
}
