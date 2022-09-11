import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/ViewModel/bottomBarViewModel.dart';
import 'package:provider/provider.dart';

class BottomBarView extends StatefulWidget {
  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  @override
  Widget build(BuildContext context) {
    BottomBarViewModel _bottomBarViewModel =
        Provider.of<BottomBarViewModel>(context, listen: true);
    return Container(
      child: _getNavBar(context, _bottomBarViewModel),
    );
  }
}

_getNavBar(context, BottomBarViewModel _bottomBarViewModel) {
  return FutureBuilder(builder: (context, AsyncSnapshot snap) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6.5,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: NavBarClipper(),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.teal,
                        Colors.teal.shade900,
                      ]),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildNavItem(
                    context,
                    Icons.inventory,
                    _bottomBarViewModel.isStockActive,
                    "Stock",
                    1,
                    _bottomBarViewModel),
                SizedBox(width: 1),
                _buildNavItem(
                    context,
                    Icons.shopping_cart_rounded,
                    _bottomBarViewModel.isOrderActive,
                    "Order",
                    2,
                    _bottomBarViewModel),
                SizedBox(width: 1),
                _buildNavItem(
                    context,
                    Icons.stacked_bar_chart,
                    _bottomBarViewModel.isStatisticsActive,
                    "statistics",
                    3,
                    _bottomBarViewModel),
              ],
            ),
          ),
        ],
      ),
    );
  });
}

_buildNavItem(BuildContext context, IconData icon, bool active, String btnText,
    int pressAction, BottomBarViewModel _bottomBarViewModel) {
  return FutureBuilder(builder: (context, AsyncSnapshot snapshot) {
    return Column(
      children: <Widget>[
        FloatingActionButton(
          heroTag: null,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal.shade800,
            child: CircleAvatar(
              radius: 25,
              backgroundColor:
                  active ? Colors.white.withOpacity(0.9) : Colors.transparent,
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
          ),
          onPressed: () {
            BottomBarViewModel bt = new BottomBarViewModel();
            // ignore: unnecessary_statements
            !active ? bt.NavigateToPages(context, pressAction) : null;
            _bottomBarViewModel.btnStyle(pressAction);
          },
        ),
        SizedBox(
          height: 35,
        ),
        Text(btnText,
            style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500)),
      ],
    );
  });
}

class NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
    path.cubicTo(3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.cubicTo(
        9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
    path.cubicTo(11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
