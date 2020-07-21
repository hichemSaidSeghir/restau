import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/util/restau.dart';
import 'package:restaurant_ui_kit/widgets/cart_item.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen >{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView.builder(
          itemCount: restaurant == null ? 0 :restaurant.length,
          itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
            Map restau = restaurant[index];
//                print(foods);
//                print(foods.length);
            return CartItem(
              img: restau['img'],
              isFav: false,
              name: restau['name'],
              rating: 5.0,
              raters: 23,
            );
          },
        ),
      ),


    );
  }

  @override
  bool get wantKeepAlive => true;
}
