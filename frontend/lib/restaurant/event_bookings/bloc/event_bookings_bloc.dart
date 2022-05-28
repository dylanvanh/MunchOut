import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'event_bookings_event.dart';
part 'event_bookings_state.dart';

class EventBookingsBloc extends Bloc<EventBookingsEvent, EventBookingsState> {
  EventBookingsBloc({
    required Event event,
    required RestaurantRepository restaurantRepository,
  })  : _event = event,
        _restaurantRepository = restaurantRepository,
        super(EventBookingsLoading()) {
    on<LoadEventBookings>(_onLoadEventBookings);
  }

  final Event _event;

  Future<void> _onLoadEventBookings(
    LoadEventBookings event,
    Emitter<EventBookingsState> emit,
  ) async {
    try {
      final customerBookingsList = await _restaurantRepository.getEventBookings(
        eventId: _event.event_id!,
      );

      emit(EventBookingsLoaded(customerBookingsList));
    } on Exception {
      //change to error encountered state
      emit(EventBookingsErrorEncountered());
    }
  }

  final RestaurantRepository _restaurantRepository;
}
