import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/homeBloc.dart';
import 'package:flutter_shop/const/bloc_observer.dart';
import 'package:flutter_shop/network/local.dart';
import 'package:flutter_shop/network/remote.dart';
import 'package:flutter_shop/screens/const.dart';
import 'package:flutter_shop/screens/homeLayout/homeLayout.dart';
import 'package:flutter_shop/screens/login/login.dart';
import 'package:flutter_shop/screens/on_board.dart';

void main() async {
  Widget widget;
  WidgetsFlutterBinding.ensureInitialized();
  await LocalHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  token = await LocalHelper.getData(key: "token");
  var onBoard = LocalHelper.getData(key: "onBoard");
  print(token);

  if (onBoard != null) {
    if (token != null)
      widget = HomeLayout();
    else
      widget = LoginScreen();
  } else
    widget = OnBoard();

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..getHomData()
        ..getCategoryData()
        ..getFavoriteData()
        ..getCartData()
        ..getUserProfileData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: startWidget),
    );
  }
}
