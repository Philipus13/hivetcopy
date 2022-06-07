import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';
import 'package:hivet/features/album/model/album_response.dart';
import 'package:flutter/material.dart';

class PosterTile extends StatelessWidget {
  final AlbumResponse albumResponse;

  const PosterTile({Key? key, required this.albumResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoutingService _routingService = g<RoutingService>();

    dynamic test = {'value': 'as', 'value2': 'bes'};

    return GestureDetector(
      onTap: () async {
        final result = await _routingService
            .navigateTo(CommonConstants.routeComingSoon, arguments: test);

        print(result.toString());
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
