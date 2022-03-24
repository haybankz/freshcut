class VideoModel {
  String image;
  String name;
  int totalVideos;
  int seenVideos;
  int newVideos;
  bool hasSeenAllVideos;
  bool hasNewVideos;

  VideoModel(
      {required this.image,
      required this.name,
      required this.totalVideos,
      required this.seenVideos,
      required this.newVideos,
      required this.hasSeenAllVideos,
      required this.hasNewVideos});
}
