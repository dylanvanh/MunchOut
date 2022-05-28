import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/customer/bookings/bloc/events_bloc.dart';
import 'package:user_repository/user_repository.dart';

/// Displays list of events bookings the user has made for the day
class CustomerBookingsPage extends StatelessWidget {
  const CustomerBookingsPage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const CustomerBookingsPage(),
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
      appBar: AppBar(
        title: const Text('Customer Bookings Page'),
      ),
      body: BlocBuilder<BookingsBloc, BookingsState>(
        builder: (context, state) {
          if (state is BookingsLoading) {
            //fetches the data on page load
            context.read<BookingsBloc>().add(LoadBookings());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BookingsLoaded) {
            return ListView(
              children: [
                for (final booking in state.bookingsList!) ...[
                  ListTile(
                    isThreeLine: true,
                    // when Event is tapped -> ROUTE TO EventBookings page
                    // pass the Event information in the route function
                    // onTap: () {
                    //   Navigator.of(context).push(
                    //     EventBookingsPage.route(event: event),
                    //   );
                    // },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(booking.event_image_url!),
                    ),
                    title: Text(booking.event_name!),
                    subtitle: Text(
                      booking.event_date!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
