import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/customer/individual_event/individual_event.dart';

class IndividualEventPage extends StatelessWidget {
  const IndividualEventPage({Key? key}) : super(key: key);

  //Route takes in information
  static Route<void> route({
    required int eventId,
    required int restaurantId,
  }) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => IndividualEventBloc(
          eventId: eventId,
          restaurantId: restaurantId,
          customerRepository:
              RepositoryProvider.of<CustomerRepository>(context),
        ),
        child: const IndividualEventPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const IndividualEventView();
  }
}

class IndividualEventView extends StatelessWidget {
  const IndividualEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
