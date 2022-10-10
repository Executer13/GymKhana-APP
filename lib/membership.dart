
import 'package:flutter/material.dart';
import 'package:testing/smart/widgets/header_widget.dart';

import 'htmlSubs.dart';

// ignore: camel_case_types
class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen>
    with SingleTickerProviderStateMixin {
  final colorstheme = Color(0xff4b4b87);

  late TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 1, vsync: this, initialIndex: 0)
      ..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    
      body: SafeArea(
        child: Column(
          children: [
          
           
            Expanded(
              child: TabBarView(
                
                controller: _tabController, children: [
                  
                CardWidget(),
                
              ]),
            ),
            
          ],
        ),

        
      ),
    );
  }
}