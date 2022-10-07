import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/homeBloc.dart';
import 'package:flutter_shop/bloc/home_states.dart';
import 'package:flutter_shop/screens/cart.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
        builder: (context, state) {
          var cubit = HomeBloc.get(context);
          return Scaffold(body: cubit.screens[cubit.currentIndex],
            appBar: AppBar(actions: [IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
            }, icon: Icon(Icons.shopping_cart))
            ],),

            bottomNavigationBar: ConvexAppBar(
              color: Colors.grey, backgroundColor: Colors.deepPurple,
              onTap: (index) {
                cubit.navChange(index);
              },
              items: cubit.items,
            ),
          );
        },
        listener: (context, state) {});
  }
}
