part of 'restaurant_nav_bar_bloc.dart';

abstract class RestaurantNavBarEvent extends Equatable {
  const RestaurantNavBarEvent();

  @override
  List<Object> get props => [];
}

class UpdateNavBarIndex extends RestaurantNavBarEvent {
  const UpdateNavBarIndex(this.navIndex);
  final int navIndex;

  @override
  List<Object> get props => [navIndex];
}
