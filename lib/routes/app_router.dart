import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login_bloc/cubit/home/home_cubit.dart';
import 'package:google_login_bloc/presentation/screens/home_screen.dart';
import 'package:google_login_bloc/presentation/screens/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/constants.dart';
import '../cubit/login/login_cubit.dart';

class AppRouter {

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROOT:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (BuildContext context) => LoginCubit(),
                child: const LoginScreen(),
              ),
        );

      case HOME:
        final googleSignInAccount = settings.arguments as GoogleSignInAccount;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => HomeCubit(),
              child: HomeScreen(googleSignInAccount: googleSignInAccount),
            ));
      default:
        return null;
    }
  }
}
