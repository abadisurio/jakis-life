import 'package:flutter/material.dart';

enum PassengerActivity {
  seating,
  standing,
  moving,
}

class Passenger {
  const Passenger({
    required this.id,
    required this.seatingIcon,
    required this.standingIcon,
    required this.movingIcon,
    required this.activity,
  });
  final String id;
  final Widget seatingIcon;
  final Widget standingIcon;
  final Widget movingIcon;
  final PassengerActivity activity;

  Passenger copyWith({
    String? id,
    Widget? seatingIcon,
    Widget? standingIcon,
    Widget? movingIcon,
    PassengerActivity? activity,
  }) {
    return Passenger(
      id: id ?? this.id,
      seatingIcon: seatingIcon ?? this.seatingIcon,
      standingIcon: standingIcon ?? this.standingIcon,
      movingIcon: movingIcon ?? this.movingIcon,
      activity: activity ?? this.activity,
    );
  }
}
