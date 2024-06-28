import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'dart:async';
import 'dart:math' as math;

import 'dart:async';
import 'dart:io';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'j_pi8T_ZPZo',
    params: YoutubePlayerParams(
      // playlist: ['j_pi8T_ZPZo'], // Defining custom playlist
      startAt: Duration(seconds: 0),
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.white70);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: new Color(0xff39465a),

      pages: [
        PageViewModel(
          title: "Here are the rules of the game !",
          body:
              "2 or 4 players should be facing each other with an empty cup each on the table and the phone in the center of the table.",
          decoration: pageDecoration,
          // decoration: pageDecoration.copyWith(
          //   bodyFlex: 2,
          //   imageFlex: 4,
          //   bodyAlignment: Alignment.bottomCenter,
          //   imageAlignment: Alignment.topCenter,
          // ),
          image: _buildImage('1.png'),
          // reverse: true,
        ),
        PageViewModel(
          title: "Do as many flips as possible !",
          body: "With your hand against the cup at the end of the table.",
          image: _buildImage('2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:
              "When a player completes a flip, he must click one time on his button !",
          body: "It will move the drink in the opposite direction.",
          image: _buildImage('3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "When the drink is on your side, you loose !",
          body: "The looser has to drink a shot.",
          image: _buildImage('4.png'),
          decoration: pageDecoration,
        ),
        // PageViewModel(
        //   title: "Title of last page - reversed",
        //   bodyWidget: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(Icons.edit),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 2,
        //     imageFlex: 4,
        //     bodyAlignment: Alignment.bottomCenter,
        //     imageAlignment: Alignment.topCenter,
        //   ),
        //   image: _buildImage('img1.jpg'),
        //   reverse: true,
        // ),
        PageViewModel(
          title: "Click on \"done\" to start the game.",
          body: "You can watch this short video to understand.",
          // decoration: pageDecoration,
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: YoutubePlayerIFrame(
            controller: _controller,
            aspectRatio: 9 / 16,
          ),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

List<List<String>> gridState = [
  [
    "",
    "",
    "",
    "",
    "",
  ],
  [
    "",
    "",
    "",
    "",
    "",
  ],
  [
    "",
    "",
    "P1",
    "",
    "",
  ],
  [
    "",
    "",
    "",
    "",
    "",
  ],
  [
    "",
    "",
    "",
    "",
    "",
  ],
];

int getDrinkPosition(bool isX) {
  int curs = 0;
  int curs_ = 0;

  if (isX) {
    while (true) {
      // print('You have got curs$curs ------------');
      if (gridState[curs].contains("P1")) return curs;
      ++curs;
      if (curs >= 5) return 2;
    }
  } else {
    while (true) {
      // print('------------You have got curs_$curs_ ');
      if (gridState[curs][curs_] == "P1") return curs_;
      ++curs_;
      if (curs_ >= 5) {
        curs_ = 0;
        ++curs;
      }
      if (curs >= 5) return 2;
    }
  }
}

void cleanGrid() {
  int curs = 0;
  int curs_ = 0;
  while (true) {
    if (gridState[curs][curs_] != "") gridState[curs][curs_] = "";
    ++curs_;
    if (curs_ >= 5) {
      curs_ = 0;
      ++curs;
    }
    if (curs >= 5) return;
  }
}

// void checkWinner() {}

bool changeDrinkPos(String dir) {
  var x = getDrinkPosition(true);
  var y = getDrinkPosition(false);

  print('current: x$x and y$y as result');
  cleanGrid();
  switch (dir) {
    case 'down':
      if (x == 4) {
        return true;
      } else
        gridState[++x][y] = "P1";
      print('x$x and y$y as result right');
      break;
    case 'top':
      if (x == 0) {
        return true;
      } else
        gridState[--x][y] = "P1";
      print('x$x and y$y as result left');
      break;
    case 'left':
      if (y == 0) {
        return true;
      } else
        gridState[x][--y] = "P1";
      print('x$x and y$y as result top');
      break;
    case 'right':
      if (y == 4) {
        return true;
      } else
        gridState[x][++y] = "P1";
      print('x$x and y$y as result down');
      break;
  }
  return false;
}

Widget _buildGridItem(int x, int y) {
  switch (gridState[x][y]) {
    case '':
      return Text('');
      break;
    case 'M':
      return Container(
        color: Colors.orange,
      );
      break;
    case 'P2':
      return Container(
        color: Colors.yellow,
      );
      break;
    case 'T':
      return Icon(
        Icons.terrain,
        size: 40.0,
        color: Colors.red,
      );
      break;
    case 'P1':
      return Icon(
        Icons.local_drink_rounded,
        size: 40.0,
        color: Colors.orange,
      );
      break;
    default:
      return Text(gridState[x][y].toString());
  }
}

Widget _buildGridItems(BuildContext context, int index) {
  int gridStateLength = gridState.length;
  int x, y = 0;
  x = (index / gridStateLength).floor();
  y = (index % gridStateLength);

  // print('You have got x$x and y$y as result');
  return GridTile(
    child: Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white, width: 0.5)),
      child: _buildGridItem(x, y),
    ),
  );
}

// Widget _buildGameBody() {
//   return;
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAppodealInitialized = false;

  bool onPressedValueTop = true;
  bool onPressedValueBottom = true;
  bool onPressedValueLeft = true;
  bool onPressedValueRight = true;

  final playera = AudioCache();
  final playerb = AudioCache();
  final playerc = AudioCache();
  final playerd = AudioCache();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Set the app keys
    Appodeal.setAppKeys(
        androidAppKey: '4d7017b1c3be400ee5913154c3c68ccb4bfc854d1bf392b0',
        iosAppKey: '');

    // Defining the callbacks
    Appodeal.setBannerCallback(
        (event) => print('Banner ad triggered the event $event'));
    Appodeal.setMrecCallback(
        (event) => print('MREC ad triggered the event $event'));
    Appodeal.setInterstitialCallback(
        (event) => print('Interstitial ad triggered the event $event'));
    Appodeal.setRewardCallback(
        (event) => print('Reward ad triggered the event $event'));
    Appodeal.setNonSkippableCallback(
        (event) => print('Non-skippable ad triggered the event $event'));

    // Request authorization to track the user
    Appodeal.requestIOSTrackingAuthorization().then((_) async {
      // Initialize Appodeal after the authorization was granted or not
      await Appodeal.initialize(
          hasConsent: true, adTypes: [AdType.INTERSTITIAL]);

      setState(() => this.isAppodealInitialized = true);
    });
  }

  Widget build(BuildContext context) {
    int gridStateLength = gridState.length;

    return new Container(
      decoration: new BoxDecoration(color: new Color(0xff39465a)),
      child: new Column(
        children: [
          Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.yellow,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                            icon: onPressedValueTop
                                ? const Icon(Icons.arrow_downward_rounded)
                                : const Icon(Icons.hourglass_empty_rounded),
                            color: Colors.white,
                            onPressed: onPressedValueTop == true
                                ? () {
                                    playera.play('sound1.mp3',
                                        mode: PlayerMode.LOW_LATENCY);
                                    // _audioCache.play('button.mp3');
                                    if (changeDrinkPos("down")) {
                                      AwesomeDialog(
                                          dismissOnTouchOutside: false,
                                          dismissOnBackKeyPress: false,
                                          context: context,
                                          animType: AnimType.TOPSLIDE,
                                          customHeader: Icon(
                                            Icons.arrow_downward_rounded,
                                            size: 100,
                                            color: Colors.red,
                                          ),
                                          headerAnimationLoop: false,
                                          showCloseIcon: false,
                                          title: 'Game Over',
                                          desc:
                                              'The red player can drink the shot !',
                                          btnOkColor: Colors.red,
                                          btnOkOnPress: () {
                                            Appodeal.show(AdType.INTERSTITIAL,
                                                placementName: "inter");
                                          })
                                        ..show();
                                      gridState[2][2] = "P1";
                                    } else {
                                      onPressedValueTop = false;
                                      Timer(Duration(seconds: 2), () {
                                        setState(() {
                                          onPressedValueTop = true;
                                        });
                                      });
                                    }
                                    setState(() {});
                                  }
                                : null),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.lightBlue,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                            icon: onPressedValueLeft
                                ? const Icon(Icons.arrow_forward_rounded)
                                : Transform.rotate(
                                    angle: 90 * math.pi / 180,
                                    child: Icon(Icons.hourglass_empty_rounded),
                                  ),
                            color: Colors.white,
                            onPressed: onPressedValueLeft == true
                                ? () {
                                    playerb.play('sound2.mp3',
                                        mode: PlayerMode.LOW_LATENCY);
                                    if (changeDrinkPos("right")) {
                                      AwesomeDialog(
                                          dismissOnTouchOutside: false,
                                          dismissOnBackKeyPress: false,
                                          context: context,
                                          animType: AnimType.LEFTSLIDE,
                                          customHeader: Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 100,
                                            color: Colors.green,
                                          ),
                                          headerAnimationLoop: false,
                                          showCloseIcon: false,
                                          title: 'Game Over',
                                          desc:
                                              'The green player can drink the shot !',
                                          btnOkColor: Colors.green,
                                          btnOkOnPress: () {
                                            Appodeal.show(AdType.INTERSTITIAL,
                                                placementName: "inter");
                                          })
                                        ..show();
                                      gridState[2][2] = "P1";
                                    } else {
                                      onPressedValueLeft = false;
                                      Timer(Duration(seconds: 2), () {
                                        setState(() {
                                          onPressedValueLeft = true;
                                        });
                                      });
                                    }
                                    setState(() {});
                                  }
                                : null),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.topCenter,
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.red, width: 0.5)),
                    child: GridView.builder(
                      padding: EdgeInsets.only(bottom: 1),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridStateLength,
                      ),
                      itemBuilder: _buildGridItems,
                      itemCount: gridStateLength * gridStateLength,
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.green,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: onPressedValueRight
                              ? const Icon(Icons.arrow_back_rounded)
                              : Transform.rotate(
                                  angle: 90 * math.pi / 180,
                                  child: Icon(Icons.hourglass_empty_rounded),
                                ),
                          color: Colors.white,
                          onPressed: onPressedValueRight == true
                              ? () {
                                  playerc.play('sound3.mp3',
                                      mode: PlayerMode.LOW_LATENCY);
                                  if (changeDrinkPos("left")) {
                                    AwesomeDialog(
                                        dismissOnTouchOutside: false,
                                        dismissOnBackKeyPress: false,
                                        context: context,
                                        animType: AnimType.RIGHSLIDE,
                                        customHeader: Icon(
                                          Icons.arrow_back_rounded,
                                          size: 100,
                                          color: Colors.lightBlue,
                                        ),
                                        headerAnimationLoop: false,
                                        showCloseIcon: false,
                                        title: 'Game Over',
                                        desc:
                                            'The blue player can drink the shot !',
                                        btnOkColor: Colors.lightBlue,
                                        btnOkOnPress: () {
                                          Appodeal.show(AdType.INTERSTITIAL,
                                              placementName: "inter");
                                        })
                                      ..show();
                                    gridState[2][2] = "P1";
                                  } else {
                                    onPressedValueRight = false;
                                    Timer(Duration(seconds: 2), () {
                                      setState(() {
                                        onPressedValueRight = true;
                                      });
                                    });
                                  }
                                  setState(() {});
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.red,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: onPressedValueBottom
                              ? const Icon(Icons.arrow_upward_rounded)
                              : const Icon(Icons.hourglass_empty_rounded),
                          color: Colors.white,
                          onPressed: onPressedValueBottom == true
                              ? () {
                                  playerd.play('sound4.mp3',
                                      mode: PlayerMode.LOW_LATENCY);
                                  if (changeDrinkPos("top")) {
                                    AwesomeDialog(
                                        dismissOnTouchOutside: false,
                                        dismissOnBackKeyPress: false,
                                        context: context,
                                        animType: AnimType.BOTTOMSLIDE,
                                        customHeader: Icon(
                                          Icons.arrow_upward_rounded,
                                          size: 100,
                                          color: Colors.yellow,
                                        ),
                                        headerAnimationLoop: false,
                                        showCloseIcon: false,
                                        title: 'Game Over',
                                        desc:
                                            'The yellow player can drink the shot !',
                                        btnOkColor: Colors.yellow,
                                        btnOkOnPress: () {
                                          Appodeal.show(AdType.INTERSTITIAL,
                                              placementName: "inter");
                                        })
                                      ..show();
                                    gridState[2][2] = "P1";
                                  } else {
                                    onPressedValueBottom = false;
                                    Timer(Duration(seconds: 2), () {
                                      setState(() {
                                        onPressedValueBottom = true;
                                      });
                                    });
                                  }
                                  setState(() {});
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // Scaffold(
    //   body: const Center(child: Text("This is the screen after Introduction")),
    // );
  }
}
