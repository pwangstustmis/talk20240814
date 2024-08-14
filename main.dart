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

  // This widget is the root of your application.
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
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = YoutubePlayerController.fromVideoId(
  videoId: '5AtF82kcRgA',
  autoPlay: false,
  params: const YoutubePlayerParams(showFullscreenButton: true)
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Hello'),
      ),
      body: Column(children:[
        Expanded(flex:1,child:Container(width:double.maxFinite,color:Colors.red,child:YoutubePlayer(
  controller: _controller,
  aspectRatio: 16 / 9,
)
)),
        Expanded(flex:2,child:Container(color:Colors.green)),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '按鈕說明文字',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
