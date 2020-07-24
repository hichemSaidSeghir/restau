import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';
import 'package:restaurant_ui_kit/widgets/home_category.dart';
import 'package:restaurant_ui_kit/widgets/slider_item.dart';
import 'package:restaurant_ui_kit/util/restau.dart';
import 'package:restaurant_ui_kit/util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home>{

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "restaurants",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),

              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here

            CarouselSlider(
              height: MediaQuery.of(context).size.height/2.4,
              items: map<Widget>(
                restaurant,
                    (index, i){
                      Map food = restaurant[index];
                  return SliderItem(
                    img: food['img'],
                    isFav: false,
                    name: food['name'],

                  );
                },
              ).toList(),
              autoPlay: true,
//                enlargeCenterPage: true,
              viewportFraction: 1.0,
//              aspectRatio: 2.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),

        SizedBox(height: 20.0),

            Text(
              "restaurant Categories",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                shrinkWrap: true,
                itemCount: categories == null?0:categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];

                  return HomeCategory(
                    icon: cat['icon'],
                    title: cat['name'],
                    items: cat['items'].toString(),
                    isHome: true,

                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Popular restaurants",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),


              ],
            ),
            SizedBox(height: 10.0),

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: restaurant == null ? 0 :restaurant.length,
              itemBuilder: (BuildContext context, int index) {

                Map food = restaurant[index];
                return GridProduct(
                 // img: food['img'],
                  isFav: false,
                  name: food['name'],

                );
              },
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
