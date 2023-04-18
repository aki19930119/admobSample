import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class RewardedAdManager implements RewardedAdLoadCallback, FullScreenContentCallback {

  RewardedAd? _rewardedAd; // 広告オブジェクト

  // 広告のロード処理
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : "ca-app-pub-3940256099942544/1712485313",

      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad; // 広告オブジェクトを保存
        },
        onAdFailedToLoad: (error) {
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  // 広告の表示処理
  void showRewardedAd() {

    // 広告が表示されたときの処理
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('Ad showed fullscreen content.');
      },
      // 広告が閉じられたときの処理
      onAdDismissedFullScreenContent: (ad) {
        print('Ad dismissed fullscreen content.');
        ad.dispose();
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('Ad failed to show fullscreen content: $error');
        ad.dispose();
        loadRewardedAd();
      },
    );

    _rewardedAd?.setImmersiveMode(true);
    _rewardedAd?.show(
      // リワード広告再生時の処理
    onUserEarnedReward: (ad, reward) {
        print('User earned reward: ${reward.amount} ${reward.type}');
        // TODO: 報酬を与える処理を追加

      },
    );
  }

  // リワード広告のロードが成功した場合のコールバック
  @override
  void onRewardedAdLoaded(RewardedAd ad) {
    _rewardedAd = ad;
  }

  // リワード広告のロードが失敗した場合のコールバック
  @override
  void onRewardedAdFailedToLoad(LoadAdError error) {
    print('Rewarded ad failed to load: $error');
  }

  // リワード広告が閉じられた場合のコールバック
  @override
  void onRewardedAdDismissed(RewardedAd ad) {
    ad.dispose();
    loadRewardedAd();
  }

  // リワード広告が表示できなかった場合のコールバック
  @override
  void onRewardedAdFailedToShow(RewardedAd ad, AdError error) {
    ad.dispose();
    loadRewardedAd();
  }

  // 報酬広告が開いたときに実行されるコールバック
  @override
  void onRewardedAdOpened(RewardedAd ad) {
    print('Rewarded ad opened.');
  }

  // ユーザーが報酬を獲得したときに実行されるコールバック
  @override
  void onUserEarnedReward(RewardedAd ad, RewardItem reward) {
    print('User earned reward: ${reward.amount} ${reward.type}');
  }

  // 広告がクリックされたときに実行されるコールバック
  @override
  // TODO: implement onAdClicked
  GenericAdEventCallback? get onAdClicked => throw UnimplementedError();

  // フルスクリーン広告が閉じられたときに実行されるコールバック
  @override
  // TODO: implement onAdDismissedFullScreenContent
  GenericAdEventCallback? get onAdDismissedFullScreenContent => throw UnimplementedError();

  // 広告の読み込みに失敗したときに実行されるコールバック
  @override
  // TODO: implement onAdFailedToLoad
  FullScreenAdLoadErrorCallback get onAdFailedToLoad => throw UnimplementedError();

  // フルスクリーン広告の表示に失敗したときに実行されるコールバック
  @override
  // TODO: implement onAdFailedToShowFullScreenContent
  void Function(dynamic ad, AdError error)? get onAdFailedToShowFullScreenContent => throw UnimplementedError();

  // 広告が表示されたときに実行されるコールバック
  @override
  // TODO: implement onAdImpression
  GenericAdEventCallback? get onAdImpression => throw UnimplementedError();

  // 広告が読み込まれたときに実行されるコールバック
  @override
  // TODO: implement onAdLoaded
  GenericAdEventCallback<RewardedAd> get onAdLoaded => throw UnimplementedError();

  // フルスクリーン広告が表示されたときに実行されるコールバック
  @override
  // TODO: implement onAdShowedFullScreenContent
  GenericAdEventCallback? get onAdShowedFullScreenContent => throw UnimplementedError();

  // フルスクリーン広告が閉じられる直前に実行されるコールバック
  @override
  // TODO: implement onAdWillDismissFullScreenContent
  GenericAdEventCallback? get onAdWillDismissFullScreenContent => throw UnimplementedError();
}
