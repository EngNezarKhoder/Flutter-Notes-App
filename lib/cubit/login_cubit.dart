import 'package:appnote/constant/link_server.dart';
import 'package:appnote/cubit/login_state.dart';
import 'package:appnote/main.dart';
import 'package:appnote/widgets/crud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(false, ''));
  final Crud _crud = Crud();
  Future<void> login(String email, String password) async {
    emit(LoginState(true, 'loading'));
    try {
      var res = await _crud
          .postRequest(loginLink, {"email": email, "password": password});
      if (res['status'] == 'success') {
        emit(LoginState(false, 'done'));
        sharedPref.setString("id", res['data']['user_id'].toString());
        sharedPref.setString("email", res['data']['user_email']);
        sharedPref.setString("password", res['data']['user_name']);
      } else if (res['status'] == 'password') {
        emit(LoginState(false, 'password'));
      } else {
        emit(LoginState(false, 'account'));
      }
    } catch (e) {
      emit(LoginState(false, 'error'));
    }
  }
}
