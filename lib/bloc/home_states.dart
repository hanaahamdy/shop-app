import '../models/loginModel.dart';

abstract class HomeStates{

}
class InitialState extends HomeStates{}
class HomeLoadingState extends HomeStates{}
class HomeSuccessState extends HomeStates{}
class HomeErrorState extends HomeStates{}
class CategoryLoadingState extends HomeStates{}
class CategorySuccessState extends HomeStates{}
class CategoryErrorState extends HomeStates{}
class GETFAVOURITEDATALoadingState extends HomeStates{}
class GETFAVOURITEDATASuccessState extends HomeStates{}
class GETFAVOURITEDATAErrorState extends HomeStates{}
class FavouriteSuccessState extends HomeStates{}
class FavouriteChangeSuccessState  extends HomeStates{}
class FavouriteErrorState extends HomeStates{}
class AddToOrDeleteCartSuccessState extends HomeStates{}
class AddToOrDeleteCartLoadingState  extends HomeStates{}
class AddToOrDeleteCartErrorState extends HomeStates{}
class GetUserDataSuccessState extends HomeStates{
  final LoginModel userData;

  GetUserDataSuccessState(this.userData);

}
class GetUserDataLoadingState  extends HomeStates{}
class GetUserDataErrorState extends HomeStates{}
class GetCartSuccessState extends HomeStates{}
class GetCartLoadingState  extends HomeStates{}
class GetCartErrorState extends HomeStates{}
class NavigationState extends HomeStates{}
class IncreaseQuantityState extends HomeStates{}
class DecreaseQuantityState extends HomeStates{}
