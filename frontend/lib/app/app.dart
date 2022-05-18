import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/authentication/authentication.dart';
import 'package:itdma3_mobile_app/error/error.dart';
import 'package:itdma3_mobile_app/home/home.dart';
import 'package:itdma3_mobile_app/launch/launch.dart';
import 'package:itdma3_mobile_app/login/login.dart';
import 'package:itdma3_mobile_app/signup/signup.dart';
import 'package:itdma3_mobile_app/splash/splash.dart';
import 'package:user_repository/user_repository.dart';

/// App is responsible for creating/providing the AuthenticationBloc which will be consumed by the AppView
/// App is also responsible for routing
class App extends StatelessWidget {
  const App({
    Key? key,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(key: key);

  // receives _userRepository instance created in bootstrap.dart
  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    //RepositoryProvider is used to provide the single instance
    //of AuthenticationRepository to the entire application
    return RepositoryProvider.value(
      value: _userRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            //creates the bloc
            create: (_) => AuthBloc(
              //passes required dependancies to bloc
              userRepository: _userRepository,
            ),
          ),
          BlocProvider(
            create: (context) => LoginBloc(
              userRepository: _userRepository,
            ),
          ),
          BlocProvider(
            create: (_) => SignupBloc(
              userRepository: _userRepository,
            ),
          )
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthorisedState) {
              _navigator.pushAndRemoveUntil<void>(
                HomePage.route(),
                (route) => false,
              );
            } else if (state is UnauthorisedState) {
              _navigator.pushAndRemoveUntil<void>(
                LaunchPage.route(),
                (route) => false,
              );
            } else {
              _navigator.pushAndRemoveUntil<void>(
                ErrorPage.route(),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
