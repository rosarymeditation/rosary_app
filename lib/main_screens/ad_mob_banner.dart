import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AdMobBanner extends StatefulWidget {
  @override
  _AdMobBannerState createState() => _AdMobBannerState();
}

class _AdMobBannerState extends State<AdMobBanner> {
  BannerAd? _bannerAd;
  bool _isEmulator = false;

  // Replace with your actual Ad Unit IDs
  static const String _androidRealAdUnitId =
      'ca-app-pub-3632903445022591/1566373978';
  static const String _iosRealAdUnitId =
      'ca-app-pub-3632903445022591/8485175545';

  // Test Ad Unit IDs provided by Google
  static const String _androidTestAdUnitId =
      'ca-app-pub-3632903445022591/5937444382';
  static const String _iosTestAdUnitId =
      'ca-app-pub-3632903445022591/7980319643';

  @override
  void initState() {
    super.initState();
    _initializeAds();
  }

  Future<void> _initializeAds() async {
    await MobileAds.instance.initialize();
    _isEmulator = await _checkIfEmulator();

    _loadBannerAd();
  }

  Future<bool> _checkIfEmulator() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return !androidInfo
            .isPhysicalDevice; // Returns true if it's an emulator
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return !iosInfo.isPhysicalDevice; // Returns true if it's an emulator
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }
    return false; // Assume it's not an emulator if detection fails
  }

  void _loadBannerAd() {
    String adUnitId;

    // Use test ad unit IDs on emulator, real ad unit IDs on real devices
    if (_isEmulator) {
      adUnitId = Platform.isAndroid ? _androidTestAdUnitId : _iosTestAdUnitId;
    } else {
      adUnitId = Platform.isAndroid ? _androidRealAdUnitId : _iosRealAdUnitId;
    }

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded.');
          setState(() {}); // Refresh state to show the ad
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAd == null
        ? SizedBox.shrink() // Show nothing while loading
        : Container(
            width: double.infinity,
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          );
  }
}
