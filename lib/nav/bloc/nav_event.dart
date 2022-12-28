part of 'nav_bloc.dart';

abstract class NavEvent extends Equatable {
  const NavEvent();

  @override
  List<Object?> get props => [];
}

class NavStartChangedEvent extends NavEvent {
  final GeoPoint? start;

  const NavStartChangedEvent(this.start);

  @override
  List<Object?> get props => [start];
}

class NavEndChangedEvent extends NavEvent {
  final GeoPoint? end;

  const NavEndChangedEvent(this.end);

  @override
  List<Object?> get props => [end];
}

class NavGetRouteEvent extends NavEvent {}
