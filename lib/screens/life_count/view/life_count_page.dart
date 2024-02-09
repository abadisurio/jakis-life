import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/bloc/player_bloc.dart';
import 'package:katajakarta/router/katajakarta_route.dart';

@RoutePage()
class LifeCountPage extends StatelessWidget {
  const LifeCountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LifeCountView();
  }
}

class _LifeCountView extends StatefulWidget {
  const _LifeCountView();

  @override
  State<_LifeCountView> createState() => _LifeCountViewState();
}

class _LifeCountViewState extends State<_LifeCountView> {
  late int _lifeCount;
  @override
  void initState() {
    _lifeCount = context.read<PlayerBloc>().state.life;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (_lifeCount <= 0) {
          context.read<PlayerBloc>().add(const ResetLife());
          context.router.replace(const GameEndRoute());
        } else {
          context.router.replace(const GameRandomizerRoute());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text('Life $_lifeCount'),
      ),
    );
  }
}
