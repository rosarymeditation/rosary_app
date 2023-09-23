import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rosary/model/audio_model.dart';

import '../utils/constants.dart';

class AudioPlaylist {
  static List<AudioSource> audioSource = [
    AudioSource.uri(
      Uri.parse(
          "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/amazing-grace.mp3"),
      tag: MediaItem(
        id: "1",
        title: "Amazing Grace",
        artist: "John Newton",
        artUri: Uri.parse(
            "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/thumbnails/amazing_grace.png"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
        "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/On+Eagle's+Wings.mp3",
      ),
      tag: MediaItem(
        id: "2",
        title: "On Eagle's Wings",
        artist: "Michael Joncas",
        artUri: Uri.parse(
          "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/thumbnails/on-eagles.jpeg",
        ),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
        "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/Here+I+Am%2C+Lord.mp3",
      ),
      tag: MediaItem(
        id: "2",
        title: "Here I Am, Lord",
        artist: "Dan Schutte",
        artUri: Uri.parse(
          "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/thumbnails/here-i-am.jpeg",
        ),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
        "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/Gregorian+Chants.mp3",
      ),
      tag: MediaItem(
        id: "2",
        title: "Gregorian chant",
        artist: "",
        artUri: Uri.parse(
          "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/thumbnails/gregorian.jpeg",
        ),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
        "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/Ave_Maria.mp3",
      ),
      tag: MediaItem(
        id: "2",
        title: "Ave Maria",
        artist: "Franz Schubert",
        artUri: Uri.parse(
          "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/thumbnails/ave.jpeg",
        ),
      ),
    )
  ];

  static List<AudioModel> songs = [
    AudioModel(
      id: "0",
      title: "Amazing Grace",
      subTitle: "",
    ),
    AudioModel(
      id: "1",
      title: "On Eagle's Wings",
      subTitle: "",
    ),
    AudioModel(
      id: "2",
      title: "Here I Am, Lord",
      subTitle: "",
    ),
    AudioModel(
      id: "3",
      title: "Gregorian chant",
      subTitle: "",
    ),
    AudioModel(
      id: "4",
      title: "Ave Maria",
      subTitle: "",
    ),
  ];

  static List<AudioSource> audioRosarySource = [
    AudioSource.uri(
      Uri.parse("luminous_audio_url".tr),
      tag: MediaItem(
        id: "1",
        title: "luminous_mystery".tr,
        artist: "luminous_days".tr,
        artUri: Uri.parse(
            "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/luminous.jpeg"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
        "joyful_audio_url".tr,
      ),
      tag: MediaItem(
        id: "2",
        title: "joyful_mystery".tr,
        artist: "joyful_days".tr,
        artUri: Uri.parse(
            "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/joyful.webp"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
        "glorious_audio_url".tr,
      ),
      tag: MediaItem(
        id: "2",
        title: "glorious_mystery".tr,
        artist: "glorious_days".tr,
        artUri: Uri.parse(
            "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/glorious.webp"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
        "sorrowful_audio_url".tr,
      ),
      tag: MediaItem(
        id: "2",
        title: "sorrowful_mystery".tr,
        artist: "sorrowful_days".tr,
        artUri: Uri.parse(
          "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/sorrow.webp",
        ),
      ),
    ),
  ];

  static List<AudioModel> songsRosary = [
    AudioModel(
      id: "0",
      title: "luminous_mystery".tr,
      subTitle: "luminous_days".tr,
    ),
    AudioModel(
      id: "1",
      title: "joyful_mystery".tr,
      subTitle: "joyful_days".tr,
    ),
    AudioModel(
      id: "2",
      title: "glorious_mystery".tr,
      subTitle: "glorious_days".tr,
    ),
    AudioModel(
        id: "3", title: "sorrowful_mystery".tr, subTitle: "sorrowful_days".tr),
  ];
}
