import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/bording_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@immutable
class BoardingScreen extends StatefulWidget {
  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final pagerController = PageController();
  bool isLastPage = false;
  final List<BoardingModel> _boardingList = [
    BoardingModel(
        image: 'assets/images/shopping_app.svg',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/images/add_to_cart.svg',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/images/delivery_truck.svg',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'),
    BoardingModel(
        image: 'assets/images/order_confirmed.svg',
        title: 'On Board 4 Title',
        body: 'On Board 4 body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPressed: _submit, title: 'skip', textColor: defaultColor)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(children: [
          Expanded(
              child: PageView.builder(
            onPageChanged: (index) {
              if (index == _boardingList.length - 1) {
                setState(() {
                  isLastPage = true;
                });
              } else {
                setState(() {
                  isLastPage = false;
                });
              }
            },
            physics: BouncingScrollPhysics(),
            controller: pagerController,
            itemBuilder: (context, index) =>
                buildBoardingItem(_boardingList[index]),
            itemCount: _boardingList.length,
          )),
          SizedBox(
            height: 40.0,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                controller: pagerController,
                count: _boardingList.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: defaultColor,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.0,
                ),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (isLastPage) {
                    _submit();
                  } else {
                    pagerController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ]),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boardingItem) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset(
              boardingItem.image,
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            boardingItem.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            boardingItem.body,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30.0),
        ],
      );

  void _submit() {
    CacheHelper.setData(key: IS_FIRST_TIME, value: false).then((value) {
      if (value == true) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }
}
