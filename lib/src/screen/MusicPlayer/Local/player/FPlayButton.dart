import 'dart:async';

import 'package:days_of_sweat/redux/store/main_store.dart';
import 'package:days_of_sweat/src/screen/common/ReusableCode.dart';
import 'package:days_of_sweat/src/screen/common/hex_color.dart';

import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FPlayButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FPlayButtonState();
  }
}

class FPlayButtonState extends State<FPlayButton> {
  final code = ResusableCode();
  Timer timer;
  @override
  void dispose() {
    super.dispose();
  }

  // void playbutton(MainState state) async {
  //   StoreProvider.of<MainState>(context).dispatch(
  //     AudioPlaying(!state.playing, state.currentDuration),
  //   );

  //   if (state.playing) {
  //     state.advancedPlayer.resume();
  //   } else {
  //     state.advancedPlayer.pause().catchError((onError) {
  //       print("SOMTHING WRONG:$onError");
  //       state.advancedPlayer.release();
  //     });
  //   }
  // }

  Widget play(context, MainState state) {
    return GestureDetector(
      onTap: () {
        code.playbutton(context, state);
      },
      child: Container(
        width: code.percentageToNumber(context, "15%", false),
        height: code.percentageToNumber(context, "10%", true),
        decoration: BoxDecoration(
          color: HexColor("#DC153C"),
          borderRadius: BorderRadius.circular(
            code.percentageToNumber(context, "2%", true),
          ),
        ),
        child: Icon(
          FontAwesomeIcons.play,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget pause(context, MainState state) {
    return GestureDetector(
      onTap: () {
        code.playbutton(context, state);
      },
      child: Container(
        width: code.percentageToNumber(context, "17%", false),
        height: code.percentageToNumber(context, "17%", true),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: new Border.all(
            color: HexColor("#DC153C"),
            style: BorderStyle.solid,
            width: code.percentageToNumber(context, "0.5%", true),
          ),
        ),
        child: Icon(
          FontAwesomeIcons.pause,
          color: Colors.black,
          size: code.percentageToNumber(context, "6%", false),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<MainState, MainState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return state.playing ? pause(context, state) : play(context, state);
        });
  }
}
