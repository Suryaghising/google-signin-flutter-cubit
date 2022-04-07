import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void loginWithGoogle() async {
    emit(LoginLoading());
    final googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if(googleSignInAccount == null) {
      emit(LoginCancelled());
    } else {
      emit(LoginSuccess(googleSignInAccount: googleSignInAccount));
    }

  }
}
