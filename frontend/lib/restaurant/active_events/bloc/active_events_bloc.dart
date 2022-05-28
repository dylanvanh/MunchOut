import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'active_events_event.dart';
part 'active_events_state.dart';

class ActiveEventsBloc extends Bloc<ActiveEventsEvent, ActiveEventsState> {
  ActiveEventsBloc({
    required UserRepository userRepository,
    required RestaurantRepository restaurantRepository,
  })  : _userRepository = userRepository,
        _restaurantRepository = restaurantRepository,
        // initial state on bloc load
        super(ActiveEventsLoading()) {
    on<LoadActiveEvents>(_onLoadActiveEvents);
  }

  final UserRepository _userRepository;
  final RestaurantRepository _restaurantRepository;

  //fetches the list of states
  Future<void> _onLoadActiveEvents(
    LoadActiveEvents event,
    Emitter<ActiveEventsState> emit,
  ) async {
    try {
      final restaurantId = _userRepository.getUser().id!;

      final activeEventList = await _restaurantRepository.getActiveEvents(
        restaurantId: restaurantId,
      );

      emit(ActiveEventsLoaded(activeEventList));
    } on Exception {
      //change to error encountered state
      emit(ActiveEventsErrorEncountered());
    }
  }
}
