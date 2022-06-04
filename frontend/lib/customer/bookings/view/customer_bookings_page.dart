import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/customer/bookings/bloc/events_bloc.dart';
import 'package:itdma3_mobile_app/customer/individual_event/individual_event.dart';
import 'package:itdma3_mobile_app/customer/navigation_bar/customer_nav_bar.dart';
import 'package:itdma3_mobile_app/customer/navigation_bar/view/customer_nav_bar.dart';
import 'package:user_repository/user_repository.dart';

/// Displays list of events bookings the user has made for the day
class CustomerBookingsPage extends StatelessWidget {
  const CustomerBookingsPage({Key? key}) : super(key: key);

  static Route<CustomerBookingsPage> route() {
    return MaterialPageRoute(
      builder: (context) => const CustomerBookingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingsBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        customerRepository: RepositoryProvider.of<CustomerRepository>(context),
      ),
      child: const CustomerBookingsView(),
    );
  }
}

class CustomerBookingsView extends StatelessWidget {
  const CustomerBookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(test: 2),
      body: BlocBuilder<BookingsBloc, BookingsState>(
        builder: (context, state) {
          if (state is BookingsLoading) {
            //fetches the data on page load
            context.read<BookingsBloc>().add(LoadBookings());
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BookingsLoaded) {
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                    child: Text(
                  'Bookings',
                  style: TextStyle(fontSize: 30),
                )),
                const SizedBox(
                  height: 20,
                ),
                for (final booking in state.bookingsList!) ...[
                  ListTile(
                    isThreeLine: true,
                    // when Event is tapped -> ROUTE TO EventBookings page
                    // pass the Event information in the route function
                    onTap: () {
                      Navigator.of(context).push(
                        IndividualEventPage.route(
                          eventId: booking.event_id!,
                          restaurantId: booking.restaurant_id!,
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(booking.restaurant_image_url!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    tileColor: Colors.white70,
                    title: Text(
                      booking.event_name!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.people),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${booking.booking_num_attendees} Attendees',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${booking.event_date}',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right_sharp),
                  ),
                  const Divider(),
                ],
              ],
            );
          } else {
            return const Text('An error has occured');
          }
        },
      ),
    );
  }
}
