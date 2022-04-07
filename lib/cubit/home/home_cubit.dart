import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void logOut() async{
    emit(HomeLoading());
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final response = await googleSignIn.disconnect();
      if(response == null) {
        emit(LogoutSuccess());
      }
    } catch (e) {
      emit(LogoutFailure(message: e.toString()));
    }
  }
}
