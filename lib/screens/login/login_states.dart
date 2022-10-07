import '../../models/loginModel.dart';

abstract class LoginStates{}
class InitState extends LoginStates{}
class LoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel model;

  LoginSuccessState(this.model);

}
class LoginErrorState extends LoginStates{}
