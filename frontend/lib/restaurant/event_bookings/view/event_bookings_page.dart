import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/event_bookings/bloc/event_bookings_bloc.dart';
import 'package:restaurant_repository/restaurant_repository.dart';

class EventBookingsPage extends StatelessWidget {
  const EventBookingsPage({Key? key}) : super(key: key);

  //Route takes in information
  static Route<void> route({
    required Event event,
  }) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => EventBookingsBloc(
          event: event,
          restaurantRepository:
              RepositoryProvider.of<RestaurantRepository>(context),
        ),
        child: const EventBookingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const EventBookingsView();
  }
}

class EventBookingsView extends StatelessWidget {
  const EventBookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EventBookingsBloc, EventBookingsState>(
        builder: (context, state) {
          if (state is EventBookingsLoading) {
            //fetches the data on page load
            context.read<EventBookingsBloc>().add(LoadEventBookings());
            return Center(
              child: Column(
                children: [
                  Align(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          }
          if (state is EventBookingsLoaded) {
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Customers Booked',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.event_rounded,
                      size: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                for (final customer in state.customersBookedList!) ...[
                  ListTile(
                    isThreeLine: true,
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.png'),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    tileColor: Colors.white70,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.person,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          customer.customer_name!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${customer.phone_number}',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.format_list_numbered_sharp),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${customer.numAttendees}',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ],
            );
          } else {
            return const Center(
              child: Text('No customer bookings found'),
            );
          }
        },
      ),
    );
  }
}
