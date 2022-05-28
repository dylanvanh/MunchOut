import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/active_events/bloc/active_events_bloc.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

/// List of all active restaurant events for the day
/// On event tap -> route to individual event page
class RestaurantActiveEventsPage extends StatelessWidget {
  const RestaurantActiveEventsPage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantActiveEventsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActiveEventsBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        restaurantRepository:
            RepositoryProvider.of<RestaurantRepository>(context),
      ),
      child: const RestaurantActiveEventsView(),
    );
  }
}

class RestaurantActiveEventsView extends StatelessWidget {
  const RestaurantActiveEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Active Events Page'),
      ),
      body: BlocBuilder<ActiveEventsBloc, ActiveEventsState>(
        builder: (context, state) {
          if (state is ActiveEventsLoading) {
            //fetches the data on page load
            context.read<ActiveEventsBloc>().add(LoadActiveEvents());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ActiveEventsLoaded) {
            return ListView(
              children: [
                for (final event in state.activeEventList!) ...[
                  ListTile(
                    isThreeLine: true,
                    // when Event is tapped -> ROUTE TO individual details page
                    // pass the Event information in the route function
                    onTap: () {
                      // Navigator.of(context).push(
                      //   CrewMemberDetailsPage.route(crewMember: crewMember),
                      // );
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
