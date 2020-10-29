import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String image, category, name;
  ProductPage({this.image, this.category, this.name});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: widget.name,
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 10.0,
                  ),
                ],
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
          Text(widget.category),
          Text(widget.name),
        ],
      ),
    );
  }
}
