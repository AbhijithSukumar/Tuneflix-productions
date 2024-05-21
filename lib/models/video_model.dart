class VideoModel {
  final String fileName;
  final String thumbnail;
  final String description;
  final String language;
  final String genre;
  final String title;
  final int releaseYear;
  final String productionID;

  VideoModel(
      {required this.fileName,
      required this.thumbnail,
      required this.description,
      required this.language,
      required this.genre,
      required this.title,
      required this.releaseYear,
      required this.productionID});

factory VideoModel.fromMap(Map<String, dynamic> videoMap) {
  return VideoModel(
    fileName: videoMap["fileName"]?.toString() ?? "",
    thumbnail: videoMap["thumbnail"]?.toString() ?? "",
    description: videoMap["description"]?.toString() ?? "",
    language: videoMap["language"]?.toString() ?? "",
    genre: videoMap["genre"]?.toString() ?? "",
    title: videoMap["title"]?.toString() ?? "",
    releaseYear: videoMap["releaseYear"]?.toInt() ?? 0, // Handle int conversions safely
    productionID: videoMap["production"]?.toString() ?? "",
  );
}

}


