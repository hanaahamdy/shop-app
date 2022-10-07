import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/home_states.dart';

import '../bloc/homeBloc.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
        builder: (context, state) {
          var cubit = HomeBloc.get(context);
          return BuildCondition(
            condition: cubit.favouriteDataModel?.data?.data.length != 0,
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            builder: (context) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.deepPurple)),
                        height: 150,
                        child: Row(children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                image: NetworkImage(
                                  "${cubit.favouriteDataModel?.data?.data[index].product?.image}",
                                ),
                                fit: BoxFit.fill,
                                width: 150,
                                height: 128,
                              ),
                              if (cubit.favouriteDataModel?.data?.data[index]
                                      .product?.discount !=
                                  0)
                                Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(3),
                                  color: Colors.red,
                                  child: Text(
                                    "Discount",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${cubit.favouriteDataModel?.data?.data[index].product?.name} ",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.height * .5,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${cubit.favouriteDataModel?.data?.data[index].product?.price}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.blue),
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        if (HomeBloc.get(context)
                                                .favouriteDataModel
                                                ?.data
                                                ?.data[index]
                                                .product
                                                ?.discount !=
                                            0)
                                          Text(
                                            "${cubit.favouriteDataModel?.data?.data[index].product?.old_price}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                            maxLines: 1,
                                          ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            cubit.addOrDeleteToCart(cubit
                                                .favouriteDataModel!
                                                .data!
                                                .data[index]
                                                .product!
                                                .id!);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: cubit.cart[cubit
                                                      .favouriteDataModel!
                                                      .data!
                                                      .data[index]
                                                      .product
                                                      ?.id]
                                                  ? Colors.deepPurple
                                                  : Colors.grey),
                                          child: Text("add to cart")),
                                      Spacer(),
                                      CircleAvatar(
                                        child: IconButton(
                                          onPressed: () {
                                            cubit.changeFavourite(cubit
                                                .favouriteDataModel!
                                                .data!
                                                .data[index]
                                                .product!
                                                .id!);
                                            // print(HomeBloc.get(context).favorites);
                                          },
                                          icon: Icon(
                                            Icons.favorite_outline,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(0),
                                        ),
                                        backgroundColor: cubit.favorites[cubit
                                                .favouriteDataModel!
                                                .data!
                                                .data[index]
                                                .product!
                                                .id]!
                                            ? Colors.deepPurple
                                            : Colors.grey,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      child: Divider(),
                    );
                  },
                  itemCount: cubit.favouriteDataModel!.data!.data.length);
            },
          );
        },
        listener: (context, state) {});
  }
}
