import 'package:days_of_sweat/redux/store/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PlayListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<MainState, MainState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Container();
      },
    );
  }
}
