import 'dart:io';

import 'package:days_of_sweat/redux/store/main_store.dart';
import 'package:days_of_sweat/src/screen/common/ReusableCode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SCover extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SCoverState();
  }
}

class SCoverState extends State<SCover> with SingleTickerProviderStateMixin {
  final code = ResusableCode();
  AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  void isplaying(bool playing) {
    if (playing) {
      rotationController.repeat();
    } else {
      rotationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<MainState, MainState>(
      converter: (store) => store.state,
      onInit: (store) => this.isplaying(store.state.playing),
      onWillChange: (state) => this.isplaying(state.playing),
      builder: (context, state) {
        return AnimatedBuilder(
          animation: rotationController,
          builder: (context, child) {
            return Container(
              //color: Colors.orange,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.only(
                        left: code.percentageToNumber(context, "8%", false),
                        top: code.percentageToNumber(context, "1%", true)),
                    width: code.percentageToNumber(context, "14%", false),
                    height: code.percentageToNumber(context, "10%", true),
                    child: Transform.rotate(
                      angle: rotationController.value * 2.0 * (22 / 7),
                      child: Image.asset("resources/vcd.png"),
                    ),
                  ),
                  Container(
                    //duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.only(
                        top: code.percentageToNumber(context, "1%", true),
                        left: code.percentageToNumber(context, "1%", false)),
                    width: code.percentageToNumber(context, "15%", false),
                    height: code.percentageToNumber(context, "11%", true),

                    child: state.currentAlbum != null
                        ? Image.file(new File.fromUri(
                            Uri.parse(state.currentAlbum),
                          ))
                        : Image.asset("resources/no_coverM.png"),
                    // decoration: BoxDecoration(
                    //     color: Colors.red,
                    //     shape: BoxShape.rectangle,
                    //     image: new DecorationImage(
                    //       image: new AssetImage(state.songlist.length <= 0
                    //           ? "resources/no_coverM.png"
                    //           : new File.fromUri(
                    //               Uri.parse(state.songlist[0].albumArt))),
                    //       fit: BoxFit.fitWidth,
                    //     )),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
