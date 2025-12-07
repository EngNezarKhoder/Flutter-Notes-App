import 'package:appnote/constant/link_server.dart';
import 'package:appnote/cubit/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appnote/widgets/crud.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState(false, ''));
  final Crud _crud = Crud();
  Future<void> signUp(String username, String email, String password) async {
    emit(SignUpState(true, "loading"));
    try {
      var res = await _crud.postRequest(signUpLink,
          {"username": username, "email": email, "password": password});
      if (res['status'] == 'success') {
        emit(SignUpState(false, 'done'));
      } else if (res['status'] == 'email_exist') {
        emit(SignUpState(false, 'email_exist'));
      } else {
        emit(SignUpState(false, 'error'));
      }
    } catch (e) {
      emit(SignUpState(false, 'error_connect'));
    }
  }
}
