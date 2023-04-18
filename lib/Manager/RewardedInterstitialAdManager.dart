import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedInterstitialAdManager implements RewardedInterstitialAdLoadCallback{
  // RewardedInterstitialAd クラスのインスタンスを保持する変数
  RewardedInterstitialAd? _rewardedInterstitialAd;
  // 広告の読み込みが完了しているかどうかを示すフラグ
  bool _isAdLoaded = false;
  // 広告の最大読み込み試行回数
  final int maxAdLoadRetries = 3;
  // 広告の読み込み試行間隔(秒単位)
  final int adLoadRetryTimeSeconds = 5;

  // 広告を読み込むメソッド
  void loadAd() {
    RewardedInterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5354046379'
          : "ca-app-pub-3940256099942544/6978759866",
      request: AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('Rewarded interstitial ad loaded.');
          _rewardedInterstitialAd = ad;
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print('Rewarded interstitial ad failed to load: $error');
        },
      ),
    );
  }

  // 広告を表示するメソッド
  void showAd() {
    if (_isAdLoaded) {
      _rewardedInterstitialAd?.fullScreenContentCallback;
      _rewardedInterstitialAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        // ユーザーが報酬を獲得した場合に呼び出されるコールバック
        print('User earned reward: ${reward.amount} ${reward.type}');
        // リワード処理をここに実装する
      });
    } else {
      print('Rewarded interstitial ad is not loaded.');
    }
  }

  //広告の読み込みに失敗した場合に呼び出されるコールバック
  @override
  // TODO: implement onAdFailedToLoad
  FullScreenAdLoadErrorCallback get onAdFailedToLoad => throw UnimplementedError();

  //広告の読み込みが完了した場合に呼び出されるコールバック
  @override
  // TODO: implement onAdLoaded
  GenericAdEventCallback<RewardedInterstitialAd> get onAdLoaded => throw UnimplementedError();
}
