import 'package:appnote/cubit/password_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordLoginCubit extends Cubit<PasswordLoginState> {
  PasswordLoginCubit() : super(PasswordLoginState(true));

  void toggle() {
    emit(PasswordLoginState(!state.obscure));
  }
}
