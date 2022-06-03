import 'package:flutter/material.dart';
import 'package:itdma3_mobile_app/customer/login/login.dart';
import 'package:itdma3_mobile_app/restaurant/login/login.dart';

///first page shown when the user launches the app
/// Routes to login/signup
class LaunchPage extends StatelessWidget {
  LaunchPage({Key? key}) : super(key: key);

  static Route<LaunchPage> route() {
    return MaterialPageRoute(
      builder: (context) => LaunchPage(),
    );
  }

  final Color gradientTopLeft = const Color.fromRGBO(62, 55, 96, 1);
  final Color gradientBottomRight = const Color.fromRGBO(22, 98, 157, 1);
  final Color logoBackground = const Color.fromRGBO(208, 208, 208, 100);
  final Color textColor = const Color.fromRGBO(27, 92, 151, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Container(
              width: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: logoBackground,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    100,
                  ),
                ),
              ),
              child: Image.asset('assets/logo.png'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            Text(
              'MunchOut',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            const Text(
              'Local Events Daily',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            const Text(
              'Cape Town Only',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradientTopLeft,
                    gradientBottomRight,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 14,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CustomerLoginPage.route(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onSurface: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 18,
                      bottom: 18,
                    ),
                    child: Text('Customer'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradientTopLeft,
                    gradientBottomRight,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 14,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      RestaurantLoginPage.route(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onSurface: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 18,
                      bottom: 18,
                    ),
                    child: Text('Restaurant'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 16,
                child: Image.asset('assets/github.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
