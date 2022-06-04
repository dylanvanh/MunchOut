part of 'customer_nav_bar_bloc.dart';

enum PageName {
  eventsPageState,
  profilePageState,
  bookingsPageState,
}

class CustomerNavBarState extends Equatable {
  const CustomerNavBarState({
    this.navIndex = 1,
    this.pageName = PageName.eventsPageState,
  });

  final PageName pageName;
  final int navIndex;

  @override
  List<Object> get props => [pageName, navIndex];
}
