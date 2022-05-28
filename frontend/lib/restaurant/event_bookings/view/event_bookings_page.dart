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
      appBar: AppBar(
        title: const Text('Restaurant Active Events Page'),
      ),
      body: BlocBuilder<EventBookingsBloc, EventBookingsState>(
        builder: (context, state) {
          if (state is EventBookingsLoading) {
            //fetches the data on page load
            context.read<EventBookingsBloc>().add(LoadEventBookings());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is EventBookingsLoaded) {
            if (state.customersBookedList!.isEmpty) {
              return const Center(
                child: Text('No bookings found'),
              );
            } else {
              return ListView(
                children: [
                  for (final booking in state.customersBookedList!) ...[
                    ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        child: Text('${booking.numAttendees}'),
                      ),
                      title: Text(booking.customer_name!),
                      subtitle: Text(
                        booking.phone_number!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(),
                  ],
                ],
              );
            }
          } else {
            return const Text('An error has occured');
          }
        },
      ),
    );
  }
}
