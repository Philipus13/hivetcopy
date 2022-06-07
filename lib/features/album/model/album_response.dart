
import 'dart:convert';

List<AlbumResponse> albumResponseFromJson(String str) => List<AlbumResponse>.from(json.decode(str).map((x) => AlbumResponse.fromJson(x)));

String albumResponseToJson(List<AlbumResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumResponse {
    AlbumResponse({
        required this.albumId,
        required this.id,
        required this.title,
        required this.url,
        required this.thumbnailUrl,
    });

    int albumId;
    int id;
    String title;
    String url;
    String thumbnailUrl;

    factory AlbumResponse.fromJson(Map<String, dynamic> json) => AlbumResponse(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
    );

    Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
    };
}
