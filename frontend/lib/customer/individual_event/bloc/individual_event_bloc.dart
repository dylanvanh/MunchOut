import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';

part 'individual_event_event.dart';
part 'individual_event_state.dart';

class IndividualEventBloc
    extends Bloc<IndividualEventEvent, IndividualEventState> {
  IndividualEventBloc({
    required int eventId,
    required int restaurantId,
    required CustomerRepository customerRepository,
  })  : _eventId = eventId,
        _restaurantId = restaurantId,
        _customerRepository = customerRepository,
        super(IndividualEventLoading()) {
    on<LoadIndividualEvent>(_onLoadIndividualEvent);
  }

  final int _eventId;
  final int _restaurantId;
  final CustomerRepository _customerRepository;

  Future<void> _onLoadIndividualEvent(
    LoadIndividualEvent event,
    Emitter<IndividualEventState> emit,
  ) async {
    try {
      //retrieve details about the event
      final eventDetails = await _customerRepository.getIndividualEventDetails(
        eventId: _eventId,
      );

      //retrieve details about the restaurant
      final restaurantDetails =
          await _customerRepository.getIndividualRestaurantDetails(
        restaurantId: _restaurantId,
      );

      emit(IndividualEventLoaded(eventDetails, restaurantDetails));
    } on Exception {
      //change to error state
      emit(IndividualEventErrorEncountered());
    }
  }
}
