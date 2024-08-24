class AudioModelCache {
  String? id;
  String? title;
  String? artist;
  String? imageUrl;
  bool? isForRosary;

  //  isForRosary: widget.isForRosary,
  //                               artist: metadata.artist.toString().tr,
  //                               imageUrl: metadata.artUri.toString(),
  //                               title: metadata.title.tr,

  // // Constructor
  AudioModelCache(
      {this.id, this.title, this.artist, this.imageUrl, this.isForRosary});

  AudioModelCache.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    artist = json['artist'];
    imageUrl = json['imageUrl'];
    isForRosary = json['isForRosary'] as bool? ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['title'] = title;
    data['artist'] = artist;
    data['imageUrl'] = imageUrl;
    data['isForRosary'] = isForRosary;

    return data;
  }
}
