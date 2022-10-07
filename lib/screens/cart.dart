import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/home_states.dart';

import '../bloc/homeBloc.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
        builder: (context, state) {
          var cubit = HomeBloc.get(context);
          return Scaffold(
            body:BuildCondition(builder: (context)=> ListView.separated(
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
                                "${cubit.cartDataModel?.data?.cart_items[index]
                                    .product?.image}",
                              ),
                              fit: BoxFit.fill,
                              width: 150,
                              height: 128,
                            ),
                            if (cubit.cartDataModel?.data?.cart_items[index].product?.discount
                                 !=
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
                                  "${cubit.cartDataModel?.data
                                      ?.cart_items[index].product?.name} ",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .5,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "${cubit.cartDataModel?.data?.cart_items[index].product?.price}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.blue),
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      if (cubit.cartDataModel?.data?.cart_items[index].product?.discount !=
                                          0)
                                        Text(
                                          "${cubit.cartDataModel?.data?.cart_items[index].product?.old_price}",
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
                                    Expanded(
                                      child: Card(
                                        color: Colors.grey[350],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: ()
                                              { "${cubit.cartDataModel!.data!.cart_items[index].quantity!+1}";
                                              },
                                              icon: Icon(
                                                Icons.add,
                                              ),
                                            ),
                                            Text(
                                                "${cubit.cartDataModel!.data!.cart_items[index].quantity!}"),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                    Icons.minimize_rounded))
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      onPressed: () {cubit.addOrDeleteToCart(cubit.cartDataModel!.data!.cart_items[index].product!.id!);},
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
                itemCount: cubit.cartDataModel!.data!.cart_items.length),
              condition: cubit.cartDataModel?.data?.cart_items.length!=0,fallback: (context){return Center(child: CircularProgressIndicator(),);},)
          );
        },
        listener: (context, state) => {});
  }
}
