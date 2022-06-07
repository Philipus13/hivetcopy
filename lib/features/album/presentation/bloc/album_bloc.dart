import 'package:bloc/bloc.dart';
import 'package:hivet/features/album/service/album_service.dart';
import 'package:hivet/features/album/model/album_response.dart';
import 'package:equatable/equatable.dart';
import 'package:hivet/core/injection/service_locator.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final instance = g<AlbumService>();

  AlbumBloc() : super(AlbumInitial()) {
    on<AlbumFetched>(_onLoadEvent);
  }

  void _onLoadEvent(
    AlbumFetched event,
    Emitter<AlbumState> emit,
  ) async {
    final currentState = state;

    if (!_hasReachedMax(currentState)) {
      try {
        if (currentState is AlbumInitial) {
          final album = await instance.getAlbum(fillParam(0, 20));
          emit(AlbumSuccess(album: album, hasReachedMax: false));
          return;
        }
        if (currentState is AlbumSuccess) {
          final album =
              await instance.getAlbum(fillParam(currentState.album.length, 20));
          emit(album.isEmpty
              ? AlbumSuccess(
                  album: currentState.album + album,
                  hasReachedMax: true,
                )
              : AlbumSuccess(
                  album: currentState.album + album,
                  hasReachedMax: false,
                ));
        }
      } catch (_) {
        emit(AlbumFailure());
      }
    }
  }

  // final AlbumService _service = AlbumService();

  // @override
  // Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
  //   final currentState = state;
  //   if (event is AlbumFetched && !_hasReachedMax(currentState)) {
  //     try {
  //       if (currentState is AlbumInitial) {
  //         final album = await instance.getAlbum(fillParam(0, 20));
  //         yield AlbumSuccess(album: album, hasReachedMax: false);
  //         return;
  //       }
  //       if (currentState is AlbumSuccess) {
  //         final album =
  //             await instance.getAlbum(fillParam(currentState.album.length, 20));

  //         yield album.isEmpty
  //             ? AlbumSuccess(
  //                 album: currentState.album + album,
  //                 hasReachedMax: true,
  //               )
  //             : AlbumSuccess(
  //                 album: currentState.album + album,
  //                 hasReachedMax: false,
  //               );
  //       }
  //     } catch (_) {
  //       yield AlbumFailure();
  //     }
  //   }
  // }

  Map<String, String> fillParam(int start, int limit) {
    var queryParameters = <String, String>{
      '_start': start.toString(),
      '_limit': limit.toString(),
    };
    return queryParameters;
  }

  bool _hasReachedMax(AlbumState state) =>
      state is AlbumSuccess && state.hasReachedMax;
}
