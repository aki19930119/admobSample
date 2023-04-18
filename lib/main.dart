import 'package:admob/Manager/AppOpenAdManager.dart';
import 'package:admob/Manager/RewardedAdManager.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'AdBanner.dart';
import 'Manager/InterstitialAdManager.dart';
import 'Manager/RewardedInterstitialAdManager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  RewardedAdManager rewardedAdManager = RewardedAdManager();
  InterstitialAdManager interstitialAdManager = InterstitialAdManager();
  RewardedInterstitialAdManager rewardedInterstitialAdManager = RewardedInterstitialAdManager();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rewardedAdManager.loadRewardedAd();
    rewardedInterstitialAdManager.loadAd();
    interstitialAdManager.interstitialAd();
    appOpenAdManager.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Show Interstitial Ad'),
              onPressed: interstitialAdManager.showInterstitialAd,
              // onPressed: showAd,

            ),
            ElevatedButton(
              child: Text('Show Rewarded Ad'),
              onPressed: rewardedAdManager.showRewardedAd,
              // onPressed: showAd,

            ),

            ElevatedButton(
              child: Text('Show RewardedInterstitial Ad'),
              onPressed: rewardedInterstitialAdManager.showAd,
              // onPressed: showAd,

            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Spacer(),
            if (_counter % 2 != 0) AdBanner(size: AdSize.fullBanner),
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
