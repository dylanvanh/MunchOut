part of 'customer_nav_bar_bloc.dart';

abstract class CustomerNavBarEvent extends Equatable {
  const CustomerNavBarEvent();

  @override
  List<Object> get props => [];
}

class UpdateNavBarIndex extends CustomerNavBarEvent {
  const UpdateNavBarIndex(this.navIndex);
  final int navIndex;

  @override
  List<Object> get props => [navIndex];
}
