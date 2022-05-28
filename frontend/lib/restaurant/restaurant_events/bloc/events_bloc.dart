import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({
    required UserRepository userRepository,
    required RestaurantRepository restaurantRepository,
  })  : _userRepository = userRepository,
        _restaurantRepository = restaurantRepository,
        // initial state on bloc load
        super(EventsLoading()) {
    on<LoadEvents>(_onLoadEvents);
  }

  final UserRepository _userRepository;
  final RestaurantRepository _restaurantRepository;

  //fetches the list of states
  Future<void> _onLoadEvents(
    LoadEvents event,
    Emitter<EventsState> emit,
  ) async {
    try {
      final restaurantId = _userRepository.getUser().id!;

      final eventsList = await _restaurantRepository.getEvents(
        restaurantId: restaurantId,
      );

      emit(EventsLoaded(eventsList));
    } on Exception {
      //change to error encountered state
      emit(EventsErrorEncountered());
    }
  }
}
