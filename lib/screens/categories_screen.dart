import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/util/categories.dart';
import 'package:restaurant_ui_kit/util/restau.dart';
import 'package:restaurant_ui_kit/widgets/grid_product.dart';
import 'package:restaurant_ui_kit/widgets/home_category.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final String apiUrl =
      "https://medicalspace.000webhostapp.com/api/restaurant/getRestaurant/";

  int _type;

  Future<List<dynamic>> fetchRestaurants(String id) async {
    final apiToken =
        "CkQFAycSRlu14k2ivRM2CjmWO4KAJgaBO1a5P2O65ESdqBFWBTRikzIsthrsUjFThk22Z6Sd4XAlicgm";
    var result = await http.get(apiUrl + id, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiToken',
    });
    Map<String, dynamic> map = json.decode(result.body);
    List<dynamic> data = map["data"];
    return data;
  }

  String catie = "italian";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Categories",
        ),
        elevation: 0.0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
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
                    isHome: false,
                    tap: (){

                      setState((){catie = "${cat['name']}";});
                      _type=index+1;

                    },
                  );



                  },

              ),
            ),

            SizedBox(height: 20.0),

            Text(
              "$catie",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            Divider(),
            SizedBox(height: 10.0),

            FutureBuilder <List<dynamic>>(
            future: fetchRestaurants(_type.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.hasData){
                   return  GridView.builder(

                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.25),
                      ),
                     itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index ) {



                        Map restau = snapshot.data[index];
                       // Map food = restaurant[3];

                        return GridProduct(

                          //img: food['img'],
                          isFav: false,
                          name: restau['name'],

                        );
                      },
                    );

                  }
                  else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
            ),


          ],
        ),
      ),
    );
  }
}
