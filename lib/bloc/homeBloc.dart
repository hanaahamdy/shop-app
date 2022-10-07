import 'package:bloc/bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/home_states.dart';
import 'package:flutter_shop/models/CartModel.dart';
import 'package:flutter_shop/models/category_model.dart';
import 'package:flutter_shop/models/getFavourite_data.dart';
import 'package:flutter_shop/models/home_model.dart';
import 'package:flutter_shop/network/remote.dart';
import 'package:flutter_shop/screens/category.dart';
import 'package:flutter_shop/screens/const.dart';
import 'package:flutter_shop/screens/favourite.dart';
import 'package:flutter_shop/screens/home.dart';
import 'package:flutter_shop/screens/login/login.dart';
import 'package:flutter_shop/screens/on_board.dart';

import '../models/favorite_model.dart';
import '../models/loginModel.dart';
import '../network/local.dart';
import '../screens/cart.dart';
import '../screens/setting.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(InitialState());

  static HomeBloc get(BuildContext context) {
    return BlocProvider.of(context);
  }

  HomeModel? homeModel;
  Map favorites = {};
  Map cart = {};

  void getHomData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data?.products.forEach((element) {
        favorites.addAll({element.id: element.favorites});
        cart.addAll({element.id: element.in_cart});
        emit(HomeSuccessState());
      });

      print(favorites);
      print(cart);
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  FavoriteModel? cartModel;

  void addOrDeleteToCart(int productId) {
    cart[productId] = !cart[productId];
    emit(AddToOrDeleteCartLoadingState());

    DioHelper.postData(
        url: "carts",
        token: token,
        data: {"product_id": productId}).then((value) {
      cartModel = FavoriteModel.fromJson(value.data);
      if (cartDataModel?.status == false) {
        cart[productId] = !cart[productId];
      } else {
        getCartData();
      }
      emit(AddToOrDeleteCartSuccessState());
      print(cartModel?.message);
    }).catchError((onError) {
      emit(AddToOrDeleteCartErrorState());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    emit(CategoryLoadingState());
    DioHelper.getData(url: "categories").then((value) {
      emit(CategorySuccessState());
      categoryModel = CategoryModel.fromJson(value.data);
      print(categoryModel?.data?.item[0].image);
    }).catchError((onError) {
      emit(CategoryErrorState());
      print(onError);
    });
  }

  CartModel? cartDataModel;

  void getCartData() {
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: "carts",
      token: token,
    ).then((value) {
      cartDataModel = CartModel.fromJson(value.data);
      print(cartDataModel?.data?.cart_items.length);
      emit(GetCartSuccessState());
    }).catchError((onError) {
      emit(GetCartErrorState());
      print(onError.toString());
    });
  }

  FavoriteModel? favoriteModel;

  void changeFavourite(int productID) {
    favorites[productID] = !(favorites[productID]!);
    emit(FavouriteChangeSuccessState());
    DioHelper.postData(
            url: "favorites", data: {"product_id": productID}, token: token)
        .then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      if (favoriteModel?.status == false) {
        favorites[productID] = !favorites[productID]!;
      } else {
        getFavoriteData();
      }
      print(value.data['message']);
      emit(FavouriteSuccessState());
    }).catchError((onError) {
      favorites[productID] = !(favorites[productID]!);
      emit(FavouriteErrorState());
      print(onError);
    });
  }

  GetFavouriteDataModel? favouriteDataModel;

  void getFavoriteData() {
    emit(GETFAVOURITEDATALoadingState());
    DioHelper.getData(
      url: "favorites",
      token: token,
    ).then((value) {
      emit(GETFAVOURITEDATASuccessState());
//print(value.data);
      favouriteDataModel = GetFavouriteDataModel.fromJson(value.data);
      print(favouriteDataModel?.data?.data[0].product?.id);
    }).catchError((onError) {
      print(onError.toString());
      emit(GETFAVOURITEDATAErrorState());
    });
  }

  List<Widget> screens = [Home(), Category(), Favourite(), Cart(), Settings()];

  int currentIndex = 0;

  void navChange(int index) {
    currentIndex = index;
    emit(NavigationState());
  }

  List<TabItem<Icon>> items = [
    TabItem(
        icon: Icon(
          Icons.home,
          color: Colors.grey,
        ),
        title: "home"),
    TabItem(icon: Icon(Icons.category, color: Colors.grey), title: "category"),
    TabItem(icon: Icon(Icons.favorite, color: Colors.grey), title: "favourite"),
    TabItem(icon: Icon(Icons.shopping_cart, color: Colors.grey), title: "Cart"),
    TabItem(icon: Icon(Icons.settings, color: Colors.grey), title: "settings")
  ];
  LoginModel? getUserData;

  void getUserProfileData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(url: "profile", token: token).then((value) {
      getUserData = LoginModel.fromjson(value.data);
      emit(GetUserDataSuccessState(getUserData!));
    }).catchError((onError) {
      emit(GetCartErrorState());
      print(onError.toString());
    });
  }

  void singOut(context) {
    LocalHelper.removeData(token).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OnBoard()),
            (route) => false);
      }
    });
  }
}
