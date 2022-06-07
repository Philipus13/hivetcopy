part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
}

class AlbumFetched extends AlbumEvent {
  @override
  List<Object> get props => [];
}

