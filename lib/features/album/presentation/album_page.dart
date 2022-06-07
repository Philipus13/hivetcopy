import 'package:hivet/features/album/presentation/bloc/album_bloc.dart';
import 'package:hivet/features/album/model/album_response.dart';
import 'package:hivet/features/album/presentation/poster_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumPage extends StatefulWidget {
  final int mode;
  const AlbumPage({
    Key? key,
    required this.mode,
  }) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  AlbumBloc? _albumBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _albumBloc = AlbumBloc();
    _albumBloc!.add(AlbumFetched());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _albumBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      bloc: _albumBloc,
      builder: (context, state) {
        if (state is AlbumFailure) {
          return Center(
            child: Text(
              'failed to fetch pos',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (state is AlbumSuccess) {
          if (state.album.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          final screenSize = MediaQuery.of(context).size;

          return Center(
            child: Container(
              // width: 200,
              constraints: BoxConstraints(minWidth: 300, maxWidth: 600),

              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: widget.mode != 0
                      ? widget.mode == 1
                          ? screenSize.width / 2
                          : screenSize.width / 3
                      : screenSize.width / 1,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.album.length
                      ? BottomLoader()
                      : PosterTile(albumResponse: state.album[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.album.length
                    : state.album.length + 1,
                controller: _scrollController,
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _albumBloc!.add(AlbumFetched());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class AlbumWidget extends StatelessWidget {
  final AlbumResponse albumResponse;

  const AlbumWidget({Key? key, required this.albumResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${albumResponse.title}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(albumResponse.title),
      isThreeLine: true,
      subtitle: Text(albumResponse.url),
      dense: true,
    );
  }
}
