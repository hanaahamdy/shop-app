import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../bloc/homeBloc.dart';
import '../models/home_model.dart';

HomeBuilder(HomeModel model) {
  return CarouselSlider(
      items: model.data?.banners
          .map((e) => Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Image(
                image: NetworkImage(
                  "${e.image}",
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              )))
          .toList(),
      options: CarouselOptions(autoPlay: true, viewportFraction: 1.0));
}

GridView buildGridView(HomeBloc cubit) {
  return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cubit.homeModel?.data?.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.8),
      itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    "${cubit.homeModel?.data?.products[index].image}",
                    fit: BoxFit.fill,
                    height: 200,
                    width: double.infinity,
                  ),
                  if (cubit.homeModel?.data?.products[index].discount != 0)
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
              Text(
                "${cubit.homeModel?.data?.products[index].name}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Row(
                children: [
                  Text(
                    "${cubit.homeModel?.data?.products[index].price}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.blue),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  if (cubit.homeModel?.data?.products[index].discount != 0)
                    Text(
                      "${cubit.homeModel?.data?.products[index].old_price}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough),
                      maxLines: 1,
                    ),
                  Spacer(),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        cubit.changeFavourite(cubit.homeModel!.data!.products[index].id!);
                    print(cubit.favorites);
                        print(cubit.homeModel?.data?.products[index].id);
                      },
                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(0),
                    ),
                    backgroundColor: cubit.favorites[
                            cubit.homeModel?.data?.products[index].id]!
                        ?  Colors.deepPurple
                        :Colors.grey,
                  )
                ],
              )
            ],
          ));
}

Padding buildListViewItem(HomeBloc cubit, height, ScrollDirect) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height,
      child: ListView.separated(
          scrollDirection: ScrollDirect,
          itemBuilder: (Context, index) {
            return Container(
                child: Image(
              image: NetworkImage(
                  "${cubit.categoryModel?.data?.item[index].image}"),
            ));
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: cubit.categoryModel!.data!.item.length),
    ),
  );
}
