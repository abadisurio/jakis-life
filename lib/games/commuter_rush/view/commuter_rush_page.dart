import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:katajakarta/games/commuter_rush/models/models.dart';
import 'package:katajakarta/widgets/widgets.dart';

@RoutePage()
class CommuterRushPage extends StatelessWidget {
  const CommuterRushPage({super.key});

  static const carWidth = 250.0;
  static const carHeight = 600.0;
  static const seatWidth = 40.0;
  static const seatHeight = 600.0;

  @override
  Widget build(BuildContext context) {
    return const _CommuterRushView();
  }
}

class _CommuterRushView extends StatelessWidget {
  const _CommuterRushView();

  Widget _buildSeatColumn(int seatCount, int row) {
    return SizedBox(
      width: CommuterRushPage.seatWidth,
      child: Column(
        children: List.generate(seatCount ~/ 2, (index) {
          final id = '${row.isEven ? 'A' : 'B'}$index';
          return Expanded(
            child: id == 'A3'
                ? _DragSeatTarget(
                    id: id,
                    passenger: const Passenger(
                      id: 'asdada4',
                      seatingIcon: Icon(
                        Icons.wheelchair_pickup,
                        size: 32,
                      ),
                      activity: PassengerActivity.standing,
                      standingIcon: Icon(
                        Icons.accessibility,
                        size: 32,
                      ),
                      movingIcon: Icon(
                        Icons.directions_run,
                        size: 32,
                      ),
                    ),
                  )
                : _DragSeatTarget(id: id),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const seatCount = 32;

    return Material(
      color: Colors.green.shade100,
      child: Stack(
        children: [
          const Positioned(top: 25, right: 25, child: PauseButton()),
          Positioned.fill(
            // top: 75,
            child: Center(
              child: SizedBox(
                width: CommuterRushPage.carWidth,
                height: CommuterRushPage.carHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSeatColumn(seatCount, 0),
                    const Expanded(child: _DragStandingTarget()),
                    _buildSeatColumn(seatCount, 1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StandingPassenger extends StatefulWidget {
  const _StandingPassenger({
    required this.passenger,
    this.initialOffset,
    this.onAccepted,
  });

  final Passenger passenger;
  final Offset? initialOffset;
  final VoidCallback? onAccepted;

  @override
  State<_StandingPassenger> createState() => __StandingPassengerState();
}

class __StandingPassengerState extends State<_StandingPassenger> {
  Offset _offset = Offset.zero;
  late double paddingHorizontal;
  late double paddingVertical;

  @override
  void initState() {
    setState(() {
      _offset = widget.initialOffset ?? _offset;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      paddingHorizontal = (size.width - CommuterRushPage.carWidth) / 2 +
          CommuterRushPage.seatWidth;
      paddingVertical = (size.height - CommuterRushPage.carHeight) / 2;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log('ccalled $_offset');
    return Positioned(
      top: _offset.dy,
      left: _offset.dx,
      // top: 50,
      // left: 200,
      child: _DraggablePassenger(
        passenger: widget.passenger,
        onAccepted: widget.onAccepted,
        onStanding: (offset) {
          setState(() {
            _offset = Offset(
              offset.dx - paddingHorizontal,
              offset.dy - paddingVertical,
            );
          });
        },
      ),
    );
  }
}

class _DraggablePassenger extends StatefulWidget {
  const _DraggablePassenger({
    required this.passenger,
    this.onStanding,
    this.onAccepted,
    // this.activity = PassengerActivity.standing,
  });

  final Passenger passenger;
  // final PassengerActivity activity;
  final void Function(Offset offset)? onStanding;
  final void Function()? onAccepted;

  @override
  State<_DraggablePassenger> createState() => _DraggablePassengerState();
}

class _DraggablePassengerState extends State<_DraggablePassenger> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<Passenger>(
      data: widget.passenger,
      onDragEnd: (detail) {
        log('detail.wasAccepted ${detail.wasAccepted}');
        if (detail.wasAccepted) {
          widget.onAccepted?.call();
        } else {}
        widget.onStanding?.call(detail.offset);
      },
      childWhenDragging: const SizedBox.shrink(),
      feedback: widget.passenger.movingIcon,
      child: widget.passenger.activity == PassengerActivity.seating
          ? widget.passenger.seatingIcon
          : widget.passenger.standingIcon,
    );
  }
}

class _DragStandingTarget extends StatefulWidget {
  const _DragStandingTarget({super.key});

  @override
  State<_DragStandingTarget> createState() => __DragStandingTargetState();
}

class __DragStandingTargetState extends State<_DragStandingTarget> {
  final List<_StandingPassenger> _activePassenger = [];
  @override
  void initState() {
    _activePassenger.add(
      _StandingPassenger(
        onAccepted: () {
          _activePassenger
              .removeWhere((element) => element.passenger.id == 'asdada2');
        },
        passenger: const Passenger(
          id: 'asdada2',
          seatingIcon: Icon(
            Icons.wheelchair_pickup,
            size: 32,
          ),
          activity: PassengerActivity.standing,
          standingIcon: Icon(
            Icons.accessibility,
            size: 32,
          ),
          movingIcon: Icon(
            Icons.directions_run,
            size: 32,
          ),
        ),
        initialOffset: Offset.zero,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade300,
      child: DragTarget<Passenger>(
        onWillAccept: (detail) {
          return detail?.activity == PassengerActivity.seating;
        },
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Stack(children: _activePassenger);
        },
        onAcceptWithDetails: (detalil) {
          final size = MediaQuery.of(context).size;
          final paddingHorizontal =
              (size.width - CommuterRushPage.carWidth) / 2 +
                  CommuterRushPage.seatWidth;
          final paddingVertical =
              (size.height - CommuterRushPage.carHeight) / 2;
          setState(() {
            _activePassenger.add(
              _StandingPassenger(
                onAccepted: () {
                  _activePassenger.removeWhere(
                    (element) => element.passenger.id == detalil.data.id,
                  );
                },
                passenger: detalil.data.copyWith(
                  activity: PassengerActivity.standing,
                ),
                initialOffset: Offset(
                  detalil.offset.dx - paddingHorizontal,
                  detalil.offset.dy - paddingVertical,
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

class _DragSeatTarget extends StatefulWidget {
  const _DragSeatTarget({
    required this.id,
    this.passenger,
  });

  final String id;
  final Passenger? passenger;

  @override
  State<_DragSeatTarget> createState() => _DragSeatTargetState();
}

class _DragSeatTargetState extends State<_DragSeatTarget> {
  Passenger? _activePassenger;

  @override
  void initState() {
    setState(() {
      _activePassenger = widget.passenger;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Passenger>(
      // onWillAccept: (detail) {
      //   return detail?.activity == PassengerActivity.standing;
      // },
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        // log('accepted2 $accepted');
        return Container(
          margin: const EdgeInsets.all(2),
          color: Colors.blue.shade200,
          child: SizedBox.expand(
            // child: widget.id == 'A1'
            //     ? _DraggablePassenger(
            //         passenger: Passenger(
            //           id: 'asdada1',
            //           seatingIcon: Icon(
            //             Icons.wheelchair_pickup,
            //             size: 32,
            //           ),
            //           activity: PassengerActivity.seating,
            //           standingIcon: Icon(
            //             Icons.accessibility,
            //             size: 32,
            //           ),
            //           movingIcon: Icon(
            //             Icons.directions_run,
            //             size: 32,
            //           ),
            //         ),
            //       )
            //     : _activePassenger == null
            child: _activePassenger == null
                ? null
                : _DraggablePassenger(
                    passenger: _activePassenger!
                        .copyWith(activity: PassengerActivity.seating),
                    // activity: PassengerActivity.seating,
                  ),
          ),
        );
      },
      onLeave: (passenger) {
        // log('leave');
        if ((_activePassenger != null && passenger != null) &&
            passenger.id == _activePassenger!.id) {
          setState(() {
            _activePassenger = null;
          });
        }
      },
      onAccept: (Passenger passenger) {
        setState(() {
          _activePassenger = passenger.copyWith(
            activity: PassengerActivity.seating,
          );
        });
      },
    );
  }
}
