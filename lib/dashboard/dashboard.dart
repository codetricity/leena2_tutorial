import 'dart:io';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:leena2/main.dart';

import '../actors/leena.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.game}) : super(key: key);
  final LeenaGame game;

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  late final LeenaGame game;
  late RewardedAd? _rewardedAd;
  bool isLoaded = false;
  late Vector2 firstLeenaPosition;
  final BannerAd _bannerAd = BannerAd(
    adUnitId: Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  _createRewardedAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: ((ad) => setState(() {
              _rewardedAd = ad;
            })),
        onAdFailedToLoad: ((error) => _rewardedAd = null),
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: ((ad) =>
            print('Ad showed fullscreen content')),
        onAdDismissedFullScreenContent: ((ad) {
          ad.dispose();
          _createRewardedAd();
        }),
        onAdFailedToShowFullScreenContent: ((ad, error) {
          ad.dispose();
          _createRewardedAd();
        }),
      );
      _rewardedAd!.show(
        onUserEarnedReward: ((ad, reward) {
          print("User earned reward of ${reward.amount} ${reward.type}");
        }),
      );
      _rewardedAd = null;
    }
    restartGame();
  }

  @override
  void initState() {
    super.initState();
    MobileAds.instance.initialize();
    if (!isLoaded) {
      isLoaded = true;
      _bannerAd.load();
      _createRewardedAd();
    }
    game = widget.game;
    firstLeenaPosition = widget.game.leena.position;
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();

    super.dispose();
  }

  restartGame() {
    setState(() {
      game.remainingTime = 30;
      game.magicLevel = 0;
      game.timerStarted = false;
      game.remove(game.leena);
      game.leena = Leena(position: Vector2(340, 30));
      game.camera.followComponent(game.leena);
      game.add(game.leena);
      game.removeAll(game.gems);
      game.gems = [];
      game.gemInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return game.introFinished
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Magic: ${game.magicLevel}',
                      style: TextStyle(fontSize: 24, fontFamily: 'Arcade'),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Text(
                      'Power Remaining: ${game.remainingTime}',
                      style:
                          const TextStyle(fontSize: 24.0, fontFamily: 'Arcade'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              game.remainingTime > 0
                  ? Container()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'GAME OVER',
                          style: TextStyle(
                              fontSize: 80,
                              color: Colors.red,
                              fontFamily: 'Arcade'),
                        ),
                        Positioned(
                            top: 30,
                            left: 30,
                            child: SizedBox(
                              height: 50,
                              width: 320,
                              child: AdWidget(ad: _bannerAd),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              _showRewardedAd();
                            },
                            child: const Text(
                              'Play Again',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: 'Arcade'),
                            ))
                      ],
                    )
            ],
          )
        : Container();
  }
}
