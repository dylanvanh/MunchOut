import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customer_nav_bar_event.dart';
part 'customer_nav_bar_state.dart';

class CustomerNavBarBloc
    extends Bloc<CustomerNavBarEvent, CustomerNavBarState> {
  CustomerNavBarBloc() : super(const CustomerNavBarState()) {
    on<UpdateNavBarIndex>(_onChangeIndex);
  }

  void _onChangeIndex(
    UpdateNavBarIndex event,
    Emitter<CustomerNavBarState> emit,
  ) {
    if (event.navIndex == 0) {
      //profile page selected
      emit(
        CustomerNavBarState(
          navIndex: event.navIndex,
          pageName: PageName.profilePageState,
        ),
      );
    } else if (event.navIndex == 1) {
      //eventsPage selected
      emit(
        CustomerNavBarState(
          navIndex: event.navIndex,
          pageName: PageName.eventsPageState,
        ),
      );
    } else if (event.navIndex == 2) {
      //bookings page selected
      CustomerNavBarState(
        navIndex: event.navIndex,
        pageName: PageName.bookingsPageState,
      );
    }
  }
}
