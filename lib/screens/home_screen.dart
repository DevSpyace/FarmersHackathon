import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../screens/cart_screen.dart';
import '../widgets/product_carousel.dart';
import '../profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var fruits = [];
  var vegetables = [];
  var kharif = [];
  var rabi = [];

  void updateCart() {
    setState(() {});
  }

  FirebaseFirestore fs = FirebaseFirestore.instance;
  getData(String category, List a) async {
    var ref = fs.collection("Products").doc(category);
    ref.get().then((value) {
      value.data().forEach((key, value) {
        print(key);
        print(value);
        var v = Map.from(value);
        a.add([v["Image"], v["Name"]]);
      });
      setState(() {
        print(a);
      });
    });
  }

  setData() async {
    await getData("Fruits", fruits);
    await getData("Vegetables", vegetables);
    await getData("Kharif Cereals", kharif);
    await getData("Rabi Cereals", rabi);
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 12.0, right: 20.0),
                child: InkResponse(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(
                        update: updateCart,
                      ),
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_basket,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                bottom: 8.0,
                right: 16.0,
                child: InkResponse(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(
                        update: updateCart,
                      ),
                    ),
                  ),
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    child: Center(
                      child: Text(
                        '${cart.length}', //cart length var here!!
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: InkResponse(
              onTap: () => print('Search'),
              child: Icon(
                Icons.search,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image(
                image: AssetImage('images/samsung_gear_vr.jpg'),
              ),
              Positioned(
                left: 20.0,
                bottom: 30.0,
                right: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'POPULAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'The future of',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'virtual reality',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      height: 70.0,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/gear_vr.jpg'),
                            height: 50.0,
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Samsung Gear VR',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'FOR GAMERS',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: 60.0,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(10.0),
                                    onPressed: () => print('Go troo product'),
                                    color: Colors.orange,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15.0),
          ProductCarousel(
            title: 'Fruits',
            products: fruits,
            update: updateCart,
          ),
          ProductCarousel(
            title: 'Vegetables',
            products: vegetables,
            update: updateCart,
          ),
          ProductCarousel(
            title: 'Kharif',
            products: kharif,
            update: updateCart,
          ),
          ProductCarousel(
            title: 'Rabi',
            products: rabi,
            update: updateCart,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('<Buyer Name>'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.account_box),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Purchase history'),
              leading: Icon(Icons.history),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
