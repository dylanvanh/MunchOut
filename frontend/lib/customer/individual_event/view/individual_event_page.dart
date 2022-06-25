import 'dart:ui';

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
    final deviceHeight = MediaQuery.of(context).size.height;
    const textColor = Color.fromRGBO(27, 92, 151, 1);

    return Scaffold(
      backgroundColor: Colors.white,
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
                    Stack(
                      children: [
                        Container(
                          height: deviceHeight / 2.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(state.eventDetails!.image_url!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            height: deviceHeight * 0.01,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Text(
                                state.eventDetails!.name!,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                state.eventDetails!.description!,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    state.eventDetails!.date!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(color: Colors.blueAccent),
                              Text(
                                state.restaurantDetails!.name!,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
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
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                state.restaurantDetails!.description!,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
