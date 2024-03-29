import 'package:days_of_sweat/redux/actions/player_actions.dart';
import 'package:days_of_sweat/redux/store/main_store.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

class CustomAppBar extends StatelessWidget {
  final year;
  final monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final month;
  final darkMode;

  CustomAppBar({this.year, this.month, this.darkMode});
  darkmode() {
    if (darkMode) {
      return [Colors.white, "resources/dark_add.png"];
    } else {
      return [Colors.black87, "resources/Add.png"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10.0, top: 0.0),
                    child: Image.asset(
                      "resources/hamburger.png",
                      scale: 0.7,
                      color: darkmode()[0],
                    ),
                  ),
                  Text(
                    " ${this.monthList[this.month - 1]}",
                    style: TextStyle(
                        color: darkmode()[0],
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    " ${this.year}",
                    style: TextStyle(
                        color: darkmode()[0],
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    child: Image.asset(
                      "resources/search.png",
                      scale: 1,
                      color: darkmode()[0],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    // child: Image.asset(
                    //   darkmode()[1],
                    //   scale: 1,
                    // ),
                    child: GestureDetector(
                      onTap: () {
                        StoreProvider.of<MainState>(context)
                            .dispatch(ScrollBar(shown: false, isAlbum: false));

                        StoreProvider.of<MainState>(context)
                            .dispatch(NavigateToAction.push('/music'));
                      },
                      child: Icon(EvaIcons.music),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
