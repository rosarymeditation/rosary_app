import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as getX;
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rxdart/rxdart.dart' as rxDart;
import 'package:just_audio/just_audio.dart';
import 'package:rosary/model/audio_model.dart';
import 'package:rosary/songs/meta_data.dart';
import 'package:rosary/widgets/audio_widget.dart';

import '../controllers/audio_controller.dart';
import '../utils/constants.dart';
import 'controls.dart';

class AudioEngine extends StatefulWidget {
  List<AudioSource> audioSource;
  List<AudioModel> audioList;
  bool isForRosary;
  String title;
  String screenName;
  AudioEngine({
    super.key,
    required this.audioSource,
    required this.audioList,
    this.isForRosary = false,
    required this.screenName,
    this.title = "listen",
  });

  @override
  State<AudioEngine> createState() => _AudioEngineState();
}

class _AudioEngineState extends State<AudioEngine> {
  var isLoading = false;
  var _audioController = Get.find<AudioController>();
  Stream<PositionData> get _positionDataStream =>
      rxDart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioController.audioPlayer.positionStream,
        _audioController.audioPlayer.bufferedPositionStream,
        _audioController.audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    // TODO: implement initState
    print("Stored screen name ${_audioController.audioScreenName}");
    print("Paseed screen name ${widget.screenName}");
    super.initState();
    if (_audioController.audioScreenName != widget.screenName) {
      _init();
    }
    checkForNetwork();
  }

  void checkForNetwork() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      AppConstant.noNetworkSnackbar();
    }
  }

  Future<void> _init() async {
    setState(() {
      isLoading = true;
    });
    _audioController.setAudioScreenName(widget.screenName);
    try {
      List<AudioSource> source = widget.audioSource;

      final _playlist = ConcatenatingAudioSource(children: source);

      await _audioController.audioPlayer.setLoopMode(LoopMode.all);
      await _audioController.audioPlayer.setAudioSource(_playlist);
      _audioController.audioPlayer.stop();
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MainAppBarWidget(text: widget.title),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<SequenceState?>(
                      stream: _audioController.audioPlayer.sequenceStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        if (state?.sequence.isEmpty ?? true) {
                          return const SizedBox();
                        }

                        final metadata = state!.currentSource!.tag as MediaItem;

                        return MediaMetadata(
                          isForRosary: widget.isForRosary,
                          artist: metadata.artist.toString().tr,
                          imageUrl: metadata.artUri.toString(),
                          title: metadata.title.tr,
                        );
                      },
                    ),
                    StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return ProgressBar(
                          barHeight: 8,
                          baseBarColor: Colors.grey.shade600,
                          bufferedBarColor: Colors.grey,
                          progressBarColor: AppColor.primaryColor,
                          thumbColor: AppColor.primaryColor,
                          timeLabelTextStyle: TextStyle(
                              color: AppColor.subTitle,
                              fontWeight: FontWeight.w600),
                          progress: positionData?.position ?? Duration.zero,
                          buffered:
                              positionData?.bufferedPosition ?? Duration.zero,
                          total: positionData?.duration ?? Duration.zero,
                          onSeek: _audioController.audioPlayer.seek,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Controls(audioPlayer: _audioController.audioPlayer),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: widget.audioList.map((e) {
                        return InkWell(
                          onTap: () async {
                            //_audioController.audioPlayer.play();

                            // await_audioController.audioPlayer.seek(
                            //   Duration.zero,
                            //   index: int.parse(e.id!),
                            // );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: AudioWidget(
                              id: e.id!,
                              title: e.title!,
                              subTitle: e.subTitle!,
                              audioPlayer: _audioController.audioPlayer,
                            ),
                          ),
                        ); // Replace YourWidget with the widget you want to use for each song
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  // @override
  // void dispose() {
  //   _audioController.audioPlayer.dispose();
  //   super.dispose();
  // }
}

class PositionData {
  PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}
