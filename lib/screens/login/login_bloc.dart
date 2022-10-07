import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/models/loginModel.dart';
import 'package:flutter_shop/network/remote.dart';
import 'package:flutter_shop/screens/login/login.dart';
import 'package:flutter_shop/screens/login/login_states.dart';

class LoginBloc extends Cubit<LoginStates> {
  LoginBloc() : super(InitState());

  static LoginBloc get(BuildContext context) {
    return BlocProvider.of(context);
  }
late LoginModel model;
  void getLOginData({required String email, required String password}) {
    emit(LoadingState());
    DioHelper.postData(
        url: "login",
        data: {"email": email, "password": password}).then((value) {
          model=LoginModel.fromjson(value.data);
          emit(LoginSuccessState(model));
          print(model.massege);
      print(value.toString());
    });
  }
}
