import 'package:hive/hive.dart';
import 'package:hivet/features/album/model/album_response.dart';
import 'package:hivet/core/network/base_network.dart';
import 'dart:convert';

import 'package:hivet/features/album/model/hive/album_model.dart';

class AlbumService extends BaseNetworks {
  Future<List<AlbumResponse>> getAlbum(
      Map<String, dynamic>? queryParams) async {
    final String path = 'albums/1/photos';

    final listOfAlbum = await service
        .getNoToken(additionalPath: path, queryParams: queryParams)
        .then(
          (value) => albumResponseFromJson(json.encode(value as List)),
        );
    await saveLocalAlbum(listOfAlbum);

    return listOfAlbum;
  }

  // checkHiveNull(param){

  // }

  saveLocalAlbum(List<AlbumResponse> listOfAlbum) async {
    Box<AlbumHiveModel> albumBox;
    if (Hive.isBoxOpen('album')) {
      albumBox = Hive.box<AlbumHiveModel>('album');
    } else {
      albumBox = await Hive.openBox<AlbumHiveModel>('album');
    }

    try {
      for (int i = 0; i < listOfAlbum.length; i++) {
        var masterAlbum = AlbumHiveModel(
            listOfAlbum[i].albumId,
            listOfAlbum[i].id,
            listOfAlbum[i].title,
            listOfAlbum[i].url,
            listOfAlbum[i].thumbnailUrl);
        await albumBox.put(listOfAlbum[i].id, masterAlbum);
      }

      var test = albumBox.toMap();

      print(test[1]!.thumbnailUrl);
    } catch (e) {
      // boxProfile.close();
      print(e.toString());

      // throw LocalDataSourceException('Cannot get master hospital', e);
    }
  }
}
