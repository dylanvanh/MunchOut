import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/customer/available_events/available_events.dart';
import 'package:itdma3_mobile_app/customer/individual_event/individual_event.dart';
import 'package:itdma3_mobile_app/customer/navigation_bar/view/customer_nav_bar.dart';
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
/// A "right swipe" opens the Dialog screen and requests number of attendees
/// A "left swipe" ignores the event and shows the next event
class AvailableEventsView extends StatelessWidget {
  const AvailableEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final textColor = const Color.fromRGBO(27, 92, 151, 1);

    return Scaffold(
      bottomNavigationBar: NavBar(navIndex: 1),
      body: BlocBuilder<AvailableEventsBloc, AvailableEventsState>(
        builder: (context, state) {
          if (state is AvailableEventsLoading) {
            //fetches the data on page load
            context.read<AvailableEventsBloc>().add(LoadAvailableEvents());
            return const Center(child: CircularProgressIndicator());
          } else if (state is AvailableEventsLoaded) {
            return Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Events',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.cookie,
                      color: textColor,
                      size: 30,
                    )
                  ],
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
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
                        //if last event in list , show an empty container
                        : Container(),
                    child: EventCard(
                      availableEvent:
                          state.availableEventsList![state.eventIndex],
                    ),
                    onDragEnd: (drag) async {
                      if (drag.velocity.pixelsPerSecond.dx < 0) {
                        context.read<AvailableEventsBloc>().add(
                              SwipeLeft(
                                availableEventsList: state.availableEventsList,
                                currentEventIndex: state.eventIndex,
                              ),
                            );
                      } else {
                        final result = await showDialog<BookingStatus>(
                          context: context,
                          builder: (context) => ConfirmBookingAlert(
                            eventId: state
                                .availableEventsList![state.eventIndex]
                                .event_id!,
                          ),
                        );

                        if (result == BookingStatus.success) {
                          context.read<AvailableEventsBloc>().add(
                                SuccessfulBooking(),
                              );
                        }
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
                    InkWell(
                      onTap: () {
                        context.read<AvailableEventsBloc>().add(
                              SwipeLeft(
                                availableEventsList: state.availableEventsList,
                                currentEventIndex: state.eventIndex,
                              ),
                            );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 15,
                              offset: const Offset(2, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.clear_rounded,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      onTap: () async {
                        final result = await showDialog<BookingStatus>(
                          context: context,
                          builder: (context) => ConfirmBookingAlert(
                            eventId: state
                                .availableEventsList![state.eventIndex]
                                .event_id!,
                          ),
                        );

                        if (result == BookingStatus.success) {
                          context.read<AvailableEventsBloc>().add(
                                SuccessfulBooking(),
                              );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 15,
                              offset: const Offset(2, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.block_rounded,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
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
