import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/homeBloc.dart';
import 'package:flutter_shop/bloc/home_states.dart';
import 'package:flutter_shop/models/home_model.dart';
import 'package:flutter_shop/widgets/homeWidgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
        builder: (context, state) {
          var cubit = HomeBloc.get(context);
          return BuildCondition(
            condition: cubit.homeModel != null,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      HomeBuilder(cubit.homeModel!),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      buildListViewItem(cubit,150.0, Axis.horizontal),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      buildGridView(cubit),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
        listener: (context, state) => {});
  }


}
