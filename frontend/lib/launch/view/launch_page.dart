import 'package:flutter/material.dart';
import 'package:itdma3_mobile_app/customer/login/login.dart';
import 'package:itdma3_mobile_app/customer/signup/signup.dart';
import 'package:itdma3_mobile_app/restaurant/login/login.dart';
import 'package:itdma3_mobile_app/restaurant/signup/signup.dart';

///first page shown when the user launches the app
/// Routes to login/signup
class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  static Route<LaunchPage> route() {
    return MaterialPageRoute(
      builder: (context) => const LaunchPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/restaurant.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  //Design
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    side: const BorderSide(width: 3, color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(200, 60),
                    maximumSize: const Size(200, 70),
                  ),
                  //Design END
                  child: const Text(
                    'Customer Login',
                    style: TextStyle(fontSize: 21),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    CustomerLoginPage.route(),
                  ),
                ),
                const Card(),
                const Card(),
                ElevatedButton(
                  //Design
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    side: const BorderSide(width: 3, color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(202, 60),
                    maximumSize: const Size(202, 60),
                  ),
                  //Design END
                  child: const Text(
                    'Customer Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    CustomerSignupPage.route(),
                  ),
                ),
                const Card(),
                const Card(),
                ElevatedButton(
                  //Design
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    side: const BorderSide(width: 3, color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(202, 60),
                    maximumSize: const Size(202, 60),
                  ),
                  //Design END
                  child: const Text(
                    'Restaurant Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    RestaurantLoginPage.route(),
                  ),
                ),
                const Card(),
                const Card(),
                ElevatedButton(
                  //Design
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    side: const BorderSide(width: 3, color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(150, 60),
                  ),
                  //Design END
                  child: const Text(
                    'Restaurant Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    RestaurantSignupPage.route(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
