import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'restaurant_nav_bar_event.dart';
part 'restaurant_nav_bar_state.dart';

class RestaurantNavBarBloc
    extends Bloc<RestaurantNavBarEvent, RestaurantNavBarState> {
  RestaurantNavBarBloc() : super(const RestaurantNavBarState()) {
    on<UpdateNavBarIndex>(_onChangeIndex);
  }

  void _onChangeIndex(
    UpdateNavBarIndex event,
    Emitter<RestaurantNavBarState> emit,
  ) {
    if (event.navIndex == 0) {
      //profile page selected
      emit(
        RestaurantNavBarState(
          navIndex: event.navIndex,
          pageName: PageName.eventsPageState,
        ),
      );
    } else if (event.navIndex == 1) {
      //eventsPage selected
      emit(
        RestaurantNavBarState(
          navIndex: event.navIndex,
          pageName: PageName.profilePageState,
        ),
      );
    }
  }
}
