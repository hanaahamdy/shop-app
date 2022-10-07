import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/homeBloc.dart';
import 'package:flutter_shop/bloc/home_states.dart';
import 'package:flutter_shop/widgets/homeWidgets.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
        builder: (context, state) {
          var cubit = HomeBloc.get(context);
          return
            ListView.separated(itemBuilder: (context, index) {
              return
                ListTile(contentPadding: EdgeInsets.all(20),
                  trailing: Icon(Icons.navigate_next),
                  leading: Image(
                    image: NetworkImage(
                    "${cubit.categoryModel?.data?.item[index].image}"),fit: BoxFit.cover,),
                  title: Text("${cubit.categoryModel?.data?.item[index].name}"),);
            },
                separatorBuilder: (context, index) {
                  return SizedBox(child: Divider(),);
                },
                itemCount: cubit.categoryModel!.data!.item.length);
        },
        listener: (context, state) {});
  }
}
