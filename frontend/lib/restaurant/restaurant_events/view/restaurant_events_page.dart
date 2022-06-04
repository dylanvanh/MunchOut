import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/event_bookings/event_bookings.dart';
import 'package:itdma3_mobile_app/restaurant/navigation_bar/customer_nav_bar.dart';
import 'package:itdma3_mobile_app/restaurant/restaurant_events/restaurant_events.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

/// List of all active restaurant events for the day
/// On event tap -> route to individual event page
class RestaurantEventsPage extends StatelessWidget {
  const RestaurantEventsPage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantEventsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventsBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        restaurantRepository:
            RepositoryProvider.of<RestaurantRepository>(context),
      ),
      child: RestaurantEventsView(),
    );
  }
}

class RestaurantEventsView extends StatelessWidget {
  RestaurantEventsView({Key? key}) : super(key: key);
  final textColor = const Color.fromRGBO(27, 92, 151, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        navIndex: 0,
      ),
      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            //fetches the data on page load
            context.read<EventsBloc>().add(LoadEvents());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is EventsLoaded) {
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Created Events',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.event_rounded,
                      color: textColor,
                      size: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                for (final event in state.eventsList!) ...[
                  ListTile(
                    isThreeLine: true,
                    // when Event is tapped -> ROUTE TO EventBookings page
                    // pass the Event information in the route function
                    onTap: () {
                      Navigator.of(context).push(
                        EventBookingsPage.route(event: event),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(event.image_url!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    tileColor: Colors.white70,
                    title: Text(
                      event.name!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${event.date}',
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
