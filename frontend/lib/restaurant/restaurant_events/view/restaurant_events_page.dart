import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/event_bookings/event_bookings.dart';
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
      child: const RestaurantEventsView(),
    );
  }
}

class RestaurantEventsView extends StatelessWidget {
  const RestaurantEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant  Events Page'),
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
                    title: Text(event.name!),
                    subtitle: Text(
                      event.description!,
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
