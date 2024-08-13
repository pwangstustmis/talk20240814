import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  //設定捲動指標設備
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//頁面類別
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController text1 = TextEditingController();
  YoutubePlayerController _controller = YoutubePlayerController.fromVideoId(
    videoId: 'tn14JWrJ78s',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Hello')),
      body: Container(
          child: Column(children: [
        Expanded(
            flex: 1,
            child: Container(
                width: double.maxFinite,
                child: YoutubePlayer(
                  controller: _controller,
                  aspectRatio: 16 / 9,
                ))),
        Expanded(flex: 1, child: Text(''))
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.loadVideoById(videoId: 'pvSYN_IK0HY');
        },
        tooltip: '按鈕說明文字',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
