part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();
}

class AlbumInitial extends AlbumState {
  @override
  List<Object> get props => [];
}

class AlbumFailure extends AlbumState {
  @override
  List<Object> get props => [];
}

class AlbumSuccess extends AlbumState {
  final List<AlbumResponse> album;
  final bool hasReachedMax;

  const AlbumSuccess({
    required this.album,
    required this.hasReachedMax,
  });

  AlbumSuccess copyWith({
    List<AlbumResponse>? album,
    required bool hasReachedMax,
  }) {
    return AlbumSuccess(
      album: album!,
      hasReachedMax: hasReachedMax,
    );
  }

  @override
  List<Object> get props => [album, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { posts: ${album.length}, hasReachedMax: $hasReachedMax }';
}