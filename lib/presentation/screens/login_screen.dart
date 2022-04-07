import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login_bloc/utils/constants.dart';

import '../../cubit/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: TextButton(
                child: const Text('Login with Google'),
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).loginWithGoogle();
                },
              ),
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginCancelled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Google login cancelled.')));
                } else if(state is LoginSuccess) {
                  Navigator.pushNamed(context, HOME, arguments: state.googleSignInAccount);
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
