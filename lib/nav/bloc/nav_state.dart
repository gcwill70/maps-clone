part of 'nav_bloc.dart';

enum NavStatus { idle, calculating, error }

class NavState extends Equatable {
  final NavStatus status;
  final GeoPoint? start;
  final GeoPoint? end;
  final List<PointLatLng>? points;

  const NavState({
    this.status = NavStatus.idle,
    this.start,
    this.end,
    this.points,
  });

  @override
  List<Object?> get props => [status, start, end, points];

  NavState copyWith({
    NavStatus? status,
    GeoPoint? start,
    GeoPoint? end,
    List<PointLatLng>? points,
  }) {
    return NavState(
      status: status ?? this.status,
      start: start ?? this.start,
      end: end ?? this.end,
      points: points ?? this.points,
    );
  }
}
