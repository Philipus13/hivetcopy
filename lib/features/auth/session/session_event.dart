import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class SessionInitEvent extends SessionEvent {
  const SessionInitEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'SessionInitEvent';
}

class SessionLoggedInEvent extends SessionEvent {
  final String scopes;

  const SessionLoggedInEvent(this.scopes);

  @override
  List<Object> get props => [scopes];

  @override
  String toString() => 'SessionLoggedInUser';
}

class SessionLoggedOutEvent extends SessionEvent {
  const SessionLoggedOutEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'SessionLoggedOut';
}
// upinput a repo with new mutation status
