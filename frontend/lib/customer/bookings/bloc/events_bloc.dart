import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  BookingsBloc({
    required UserRepository userRepository,
    required CustomerRepository customerRepository,
  })  : _userRepository = userRepository,
        _customerRepository = customerRepository,
        // initial state on bloc load
        super(BookingsLoading()) {
    on<LoadBookings>(_onLoadBookings);
  }

  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;

  //fetches the list of bookings
  Future<void> _onLoadBookings(
    LoadBookings event,
    Emitter<BookingsState> emit,
  ) async {
    try {
      final customerId = _userRepository.getUser().id!;

      final bookingsList = await _customerRepository.getBookings(
        customerId: customerId,
      );

      for (final booking in bookingsList) {
        print(booking);
      }

      emit(BookingsLoaded(bookingsList));
    } on Exception {
      //change to error encountered state
      emit(BookingsErrorEncountered());
    }
  }
}
