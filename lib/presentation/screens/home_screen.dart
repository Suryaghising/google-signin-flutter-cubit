import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login_bloc/utils/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../cubit/home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.googleSignInAccount}) : super(key: key);

  final GoogleSignInAccount googleSignInAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: googleSignInAccount.photoUrl == null
                            ? Theme.of(context).primaryColor
                            : Colors.transparent),
                    child: googleSignInAccount.photoUrl == null? Text('${googleSignInAccount.displayName?.substring(0,1)}'): ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          googleSignInAccount.photoUrl!,
                          fit: BoxFit.fill,
                        )),
                  ),
                  const SizedBox(height: 16),
                  Text('Welcome ${googleSignInAccount.displayName}'),
                  const SizedBox(height: 16),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<HomeCubit>(context).logOut();
                      },
                      child: const Text('Log Out'))
                ],
              ),
            ),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is LogoutFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is LogoutSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, ROOT, (route) => false);
                }
              },
              builder: (context, state) {
                if (state is HomeLoading) {
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
