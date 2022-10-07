import 'package:flutter_shop/models/loginModel.dart';

abstract class RegisterStates{}
class RegisterInitState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LoginModel registerModel;

  RegisterSuccessState(this.registerModel);

}
class RegisterErrorState extends RegisterStates{}