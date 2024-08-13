import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

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
  var wdesc = '';
  var wx = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var url = Uri.parse(
        'https://opendata.cwa.gov.tw/api/v1/rest/datastore/F-D0047-089?Authorization=授權碼&locationName=臺南市&elementName=Wx,T');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      wdesc = data['records']['locations'][0]['location'][0]['weatherElement']
          [0]['time'][0]['elementValue'][0]['value'];
      wx = data['records']['locations'][0]['location'][0]['weatherElement'][1]
          ['time'][0]['elementValue'][0]['value'];
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Hello'),
      ),
      body: Center(
          child: Column(children: [
        wx == ''
            ? Text('')
            : SvgPicture.network(
                'https://www.cwa.gov.tw/V8/assets/img/weather_icons/weathers/svg_icon/day/' +
                    wx.toString() +
                    '.svg'),
        wx == '' ? Text('') : Text(wdesc),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '按鈕說明文字',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
