import 'package:appnote/cubit/password_sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordSignUpCubit extends Cubit<PasswordSignUpState> {
  PasswordSignUpCubit() : super(PasswordSignUpState(true));

  void toggle() {
    emit(PasswordSignUpState(!state.obscure));
  }
}
