import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottomBarView.dart';

class StatisticsView extends StatefulWidget {
  @override
  _StatisticsViewState createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      bottomNavigationBar: BottomBarView(),
    );
  }
}
