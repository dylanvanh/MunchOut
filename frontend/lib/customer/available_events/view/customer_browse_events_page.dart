import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/customer/available_events/available_events.dart';
import 'package:itdma3_mobile_app/customer/individual_event/individual_event.dart';
import 'package:user_repository/user_repository.dart';

class AvailableEventsPage extends StatelessWidget {
  const AvailableEventsPage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AvailableEventsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AvailableEventsBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            customerRepository:
                RepositoryProvider.of<CustomerRepository>(context),
          ),
        ),
      ],
      child: const AvailableEventsView(),
    );
  }
}

/// Tinder like swipe screen with all available restaurant events for the day
/// A "right swipe" begins the booking process
/// A "left swipe" ignores the event and shows the next event
class AvailableEventsView extends StatelessWidget {
  const AvailableEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User browse events page'),
      ),
      body: BlocBuilder<AvailableEventsBloc, AvailableEventsState>(
        builder: (context, state) {
          if (state is AvailableEventsLoading) {
            //fetches the data on page load
            context.read<AvailableEventsBloc>().add(LoadAvailableEvents());
            return const Center(child: CircularProgressIndicator());
          } else if (state is AvailableEventsLoaded) {
            return Column(
              children: [
                InkWell(
                  onDoubleTap: () {
                    Navigator.of(context).push(
                      IndividualEventPage.route(
                        eventId: state
                            .availableEventsList![state.eventIndex].event_id!,
                        restaurantId: state
                            .availableEventsList![state.eventIndex]
                            .restaurant_id!,
                      ),
                    );
                  },
                  child: Draggable<EventCard>(
                    feedback: EventCard(
                      availableEvent:
                          state.availableEventsList![state.eventIndex],
                    ),
                    childWhenDragging: (state.numEvents - 1 > state.eventIndex)
                        ? EventCard(
                            availableEvent: state
                                .availableEventsList![state.eventIndex + 1],
                          )
                        : Container(),
                    child: EventCard(
                      availableEvent:
                          state.availableEventsList![state.eventIndex],
                    ),
                    onDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dx < 0) {
                        context.read<AvailableEventsBloc>().add(
                              SwipeLeft(
                                availableEventsList: state.availableEventsList,
                                currentEventIndex: state.eventIndex,
                              ),
                            );
                      } else {
                        showDialog<void>(
                          context: context,
                          //pass the eventId to dialog
                          builder: (context) => ConfirmBookingAlert(
                            eventId: state
                                .availableEventsList![state.eventIndex]
                                .event_id!,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //dislike / swipe left
                    ElevatedButton(
                      onPressed: () {
                        context.read<AvailableEventsBloc>().add(
                              SwipeLeft(
                                availableEventsList: state.availableEventsList,
                                currentEventIndex: state.eventIndex,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(50, 50),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(Icons.thumb_down),
                    ),
                    // refresh / swipe down
                    ElevatedButton(
                      onPressed: () {
                        context.read<AvailableEventsBloc>().add(
                              RefreshEvents(),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(50, 50),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(Icons.refresh),
                    ),
                    // like / swipe right
                    ElevatedButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => ConfirmBookingAlert(
                            eventId: state
                                .availableEventsList![state.eventIndex]
                                .event_id!,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(50, 50),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(Icons.thumb_up),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is AvailableEventsEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('No more events found! Please come back later.'),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Try pulling down on your screen to refresh events',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AvailableEventsBloc>().add(
                            RefreshEvents(),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(50, 50),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Error loading event details'),
            );
          }
        },
      ),
    );
  }
}
