import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({Key? key, required this.availableEvent}) : super(key: key);

  final AvailableEvent availableEvent;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'event_card',
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.35,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.network(
                availableEvent.event_image_url!,
                fit: BoxFit.cover,
                height: double.infinity,
                //if the url is incorrect or fails to load
                errorBuilder: (context, Object exception, stackTrace) {
                  return const Center(
                    child: Text(
                      'Error loading imageUrl',
                    ),
                  );
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${availableEvent.event_name}',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      '${availableEvent.event_date}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
