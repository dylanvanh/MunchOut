part of 'restaurant_nav_bar_bloc.dart';

enum PageName {
  eventsPageState,
  profilePageState,
}

class RestaurantNavBarState extends Equatable {
  const RestaurantNavBarState({
    this.navIndex = 0,
    this.pageName = PageName.eventsPageState,
  });

  final PageName pageName;
  final int navIndex;

  @override
  List<Object> get props => [pageName, navIndex];
}
