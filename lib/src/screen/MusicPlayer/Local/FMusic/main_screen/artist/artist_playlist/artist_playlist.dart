import 'package:days_of_sweat/redux/actions/player_actions.dart';
import 'package:days_of_sweat/redux/store/main_store.dart';
import 'package:days_of_sweat/src/screen/common/ReusableCode.dart';
import 'package:days_of_sweat/src/screen/common/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'PlayListAppBar.dart';
import 'PlaylistFlexibleAppBar.dart';

class ArtistPlayList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArtistPlayListState();
  }
}

class ArtistPlayListState extends State<ArtistPlayList> {
  final code = ResusableCode();
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() {
    // print("ControllerRightNow:${_controller.offset}");
    // double no = _controller.position.maxScrollExtent -
    //     (0.80 * _controller.position.maxScrollExtent);
    // print("ControllerNo80%:${no}");
    // print(_controller.offset);
    if (_controller.offset >= code.percentageToNumber(context, "40%", true)) {
      StoreProvider.of<MainState>(context).dispatch(ScrollBar(shown: true));
    } else {
      StoreProvider.of<MainState>(context).dispatch(ScrollBar(shown: false));
    }
    // if(_controller.offset<=)
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<MainState, MainState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          body: Material(
            child: Container(
              color: HexColor("#1A1B1F"),
              child: CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: HexColor("#1A1B1F"),
                    title: Container(
                      color: Colors.red,
                    ),
                    leading: Container(),
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                     
                        return AnimatedOpacity(
                          opacity: state.appbarshown ? 0.0 : 1.0,
                          duration: Duration(milliseconds: 500),
                          child: FlexibleAppBar(),
                        );
                      },
                    ),
                    expandedHeight:
                        code.percentageToNumber(context, "65%", true),
                    pinned: true,
                    actions: <Widget>[
                      PlayListAppBar(
                        shown: state.appbarshown,
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: code.percentageToNumber(context, "90%", false),
                      height: code.percentageToNumber(context, "10%", true),
                      padding: EdgeInsets.only(
                        top: code.percentageToNumber(context, "0%", true),
                        bottom: code.percentageToNumber(context, "5%", true),
                        left: code.percentageToNumber(context, "5%", false),
                        right: code.percentageToNumber(context, "5%", false),
                      ),
                      decoration: BoxDecoration(
                        color: HexColor("#121218"),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            code.percentageToNumber(context, "5%", false),
                          ),
                          topRight: Radius.circular(
                            code.percentageToNumber(context, "5%", false),
                          ),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              top: code.percentageToNumber(context, "2%", true),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${state.artistList[state.currentAlbumIndex][0]} Song List',
                              style: TextStyle(
                                color: HexColor("#44454C"),
                                fontFamily: "Roboto-Regular",
                                fontSize: code.percentageToNumber(
                                    context, "2%", true),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFixedExtentList(
                    itemExtent: code.percentageToNumber(context, "7%", true),
                    delegate: new SliverChildBuilderDelegate((builder, index) {
                      return Container(
                        color: HexColor("#121218"),
                        child: MusicCard(state: state, position: index),
                      );
                    },
                        childCount: state
                                .artistSongList[state.currentAlbumIndex]
                                .length +
                            1),
                  ),
                ],
              ),
            ),
          ),
        );
        //);
      },
    );
  }
}

class MusicCard extends StatelessWidget {
  final MainState state;
  final int position;
  final code = ResusableCode();

  String titleText(String text) {
    if (text.length > 25) {
      return text.substring(0, 25) + "...";
    } else {
      return text;
    }
  }

  MusicCard({this.state, this.position});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          code.playingFromPosition(context, state, this.position, true),
      child: position < state.artistSongList[state.currentAlbumIndex].length
          ? Container(
              // color: Colors.green,
              margin: EdgeInsets.only(
                top: code.percentageToNumber(context, "0%", true),
                bottom: code.percentageToNumber(context, "2%", true),
                left: code.percentageToNumber(context, "5%", false),
                right: code.percentageToNumber(context, "5%", false),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    position > 9 ? position.toString() : "0$position",
                    style: TextStyle(
                      color: HexColor("#656A71"),
                      fontFamily: "Lato",
                      fontSize: code.percentageToNumber(context, "2.5%", true),
                    ),
                  ),
                  Text(
                    titleText(state
                        .artistSongList[state.currentAlbumIndex][position]
                        .title),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                      fontSize: code.percentageToNumber(context, "3%", true),
                    ),
                  ),
                  Text(
                    code.durationfromMilliSeconds(state
                        .artistSongList[state.currentAlbumIndex][position]
                        .duration),
                    style: TextStyle(
                      color: HexColor("#44454C"),
                      fontFamily: "Lato",
                      fontSize: code.percentageToNumber(context, "2%", true),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'resources/skull.png',
                      scale: 4,
                    ),
                    Text(
                      "No More Music To Show",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Lato",
                        fontSize: code.percentageToNumber(context, "3%", true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
