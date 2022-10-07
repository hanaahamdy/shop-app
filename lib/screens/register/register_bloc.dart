import 'package:bloc/bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/network/remote.dart';
import 'package:flutter_shop/screens/register/register_states.dart';

import '../../models/loginModel.dart';

class RegisterBloc extends Cubit<RegisterStates> {
  RegisterBloc() : super(RegisterInitState());

  static RegisterBloc get(BuildContext context) {
    return BlocProvider.of(context);
  }

  LoginModel? registerModel;

  void Register(
      {String? name, String? email,String? phone,String? password}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: "register", data: {
      "password":password,
      "name": name,
      "email": email,
      "phone": phone
    }).then((value) {
      registerModel = LoginModel.fromjson(value.data);
      emit(RegisterSuccessState(registerModel!));

      print(value.data);
      print(registerModel?.data?.name);
    }).catchError((onError) {
      emit(RegisterErrorState());
    });
  }
}
