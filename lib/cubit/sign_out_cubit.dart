import 'package:appnote/cubit/sign_out_state.dart';
import 'package:appnote/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutState(false, ''));

  Future<void> signOut() async {
    emit(SignOutState(true, 'prepare'));
    await sharedPref.clear();
    emit(SignOutState(false, 'done'));
  }
}
