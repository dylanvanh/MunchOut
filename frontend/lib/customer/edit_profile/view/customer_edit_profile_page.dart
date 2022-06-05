import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/authentication/authentication.dart';
import 'package:itdma3_mobile_app/customer/edit_profile/edit_profile.dart';
import 'package:itdma3_mobile_app/customer/navigation_bar/view/customer_nav_bar.dart';
import 'package:user_repository/user_repository.dart';

/// Edit user screen form , allows the user to change their
/// name,password,phonenumber
class CustomerEditProfilePage extends StatelessWidget {
  CustomerEditProfilePage({Key? key}) : super(key: key);

  static Route<CustomerEditProfilePage> route() {
    return MaterialPageRoute(
      builder: (context) => CustomerEditProfilePage(),
    );
  }

  final Color gradientTopLeft = const Color.fromRGBO(62, 55, 96, 1);
  final Color gradientBottomRight = const Color.fromRGBO(22, 98, 157, 1);
  final Color logoBackground = const Color.fromRGBO(208, 208, 208, 100);
  final Color textColor = const Color.fromRGBO(27, 92, 151, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(navIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.person_pin_circle_rounded,
                  size: 30,
                  color: textColor,
                ),
              ],
            ),
            Container(
              margin:
                  EdgeInsets.only(left: MediaQuery.of(context).size.height / 3),
              child: IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                  size: 35,
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: BlocProvider(
                create: (context) {
                  return EditProfileBloc(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                    customerRepository:
                        RepositoryProvider.of<CustomerRepository>(context),
                  );
                },
                child: CustomerEditProfileForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
