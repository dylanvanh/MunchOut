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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details Page'),
      ),
      body: BlocBuilder<IndividualEventBloc, IndividualEventState>(
        builder: (context, state) {
          if (state is IndividualEventLoading) {
            //fetches the data on page load
            context.read<IndividualEventBloc>().add(LoadIndividualEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is IndividualEventLoaded) {
            if (state.eventDetails!.name == '' ||
                state.restaurantDetails!.name == '') {
              return const Center(
                child: Text('Error Loading data'),
              );
            } else {
              //valid data
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.network(
                        state.eventDetails!.image_url!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, Object exception, stackTrace) {
                          return const Center(
                            child: Text(
                              'Error loading imageUrl',
                            ),
                          );
                        },
                      ),
                      // child: Image.network(
                      //   state.eventDetails!.image_url!,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          state.eventDetails!.name!,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Text(state.eventDetails!.date!),
                      ],
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: Text(state.eventDetails!.description!),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            state.restaurantDetails!.name!,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 150,
                            child: ClipOval(
                              child: Image.network(
                                state.restaurantDetails!.image_url!,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, Object exception, stackTrace) {
                                  return const Center(
                                    child: Text(
                                      'Error loading imageUrl',
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              state.restaurantDetails!.description!,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
