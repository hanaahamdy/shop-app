import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/login/login.dart';
import 'package:flutter_shop/screens/register/register.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/onBoard_model.dart';
import '../network/local.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  PageController controller = PageController();
  List<OnBoardModel> boards = [
    OnBoardModel(image: 'images/onboard1.jpg', bodyText2: ''),
    OnBoardModel(image: 'images/onboard2.jpg', bodyText2: ''),
    OnBoardModel(image: 'images/onboard3.jpg', bodyText2: '')
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
              child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == boards.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: controller,
                  itemCount: 3,
                  itemBuilder: (context, index) =>
                      onboardComponent(context, boards[index]))),
          Row(
            children: [
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                    expansionFactor: 3,
                    activeDotColor: Colors.deepPurple,
                    dotHeight: 10),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (isLast) {
                    LocalHelper.setData(key: "onBoard", value: true)
                        .then((value) {
                     if(value){ Navigator.of(context).pushAndRemoveUntil(
                         MaterialPageRoute(
                             builder: (context) =>RegisterScreen()),
                             (route) => false);}
                    });
                  } else {
                    controller.nextPage(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeInOutCubicEmphasized);
                  }
                },
                child: Icon(Icons.arrow_forward_ios_sharp),
              )
            ],
          )
        ],
      ),
    ));
  }

  Column onboardComponent(BuildContext context, OnBoardModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage("${model.image}"),
          fit: BoxFit.contain,
        )),
        Text("${model.bodyText1}",
            style: Theme.of(context).textTheme.headline6),
        Text("${model.bodyText2}", style: Theme.of(context).textTheme.headline6)
      ],
    );
  }
}
