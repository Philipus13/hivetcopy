import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/features/album/model/album_response.dart';
import 'package:flutter/material.dart';

class PosterTileCopy extends StatelessWidget {
  final AlbumResponse albumResponse;

  const PosterTileCopy({Key? key, required this.albumResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoutingService _routingService = g<RoutingService>();

    dynamic test = {'valueCopy': 'as', 'valueCopy2': 'bes'};

    return GestureDetector(
      onTap: () {
        _routingService.goBackPopStack(test);
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, //add this
          children: <Widget>[
            Expanded(
              child: Image.network(
                albumResponse.url,
                fit: BoxFit.cover, // add this
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  albumResponse.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
