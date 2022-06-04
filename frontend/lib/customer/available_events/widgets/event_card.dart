import 'dart:ui';

import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({Key? key, required this.availableEvent}) : super(key: key);

  final AvailableEvent availableEvent;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: deviceHeight * 0.60,
              width: deviceWidth * 0.9,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    availableEvent.event_image_url!,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            //details goes here
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 30),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: deviceHeight * .15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              availableEvent.event_name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              availableEvent.restaurant_name!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.network(
                              availableEvent.restaurant_image_url!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
