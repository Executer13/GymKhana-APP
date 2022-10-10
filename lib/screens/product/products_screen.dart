import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import 'components/body.dart';
import 'constants.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('Choose Membership'),
   
    );
  }
}
