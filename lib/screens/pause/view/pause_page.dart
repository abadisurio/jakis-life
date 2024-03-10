import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/screens/pause/bloc/pause_bloc.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

@RoutePage<bool?>()
class PausePage extends StatefulWidget {
  const PausePage({super.key});

  @override
  State<PausePage> createState() => _PausePageState();
}

class _PausePageState extends State<PausePage> {
  String? _currentGame;
  @override
  void initState() {
    super.initState();
    context.read<PauseBloc>().add(const PauseGame());
    _currentGame = context.read<PlayerBloc>().state.currentGame;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PauseBloc, PauseState>(
      listenWhen: (prev, curr) => !curr.isPaused,
      listener: (context, state) => context.router.pop(true),
      buildWhen: (prev, curr) => prev.isPaused != curr.isPaused,
      builder: (context, state) {
        final content = _content[_currentGame];
        return !state.isPaused
            ? const SizedBox.shrink()
            : Material(
                color: Colors.black26,
                child: Center(
                  child: AlertDialog(
                    title: Text(
                      'Game Paused',
                      style: TextStyleTheme(context).titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (content != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              height: 400,
                              width: 300,
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: content.assetGenImage.image(),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(content.description),
                                ],
                              ),
                            ),
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: KJButton(
                                onPressed: () {
                                  context
                                      .read<PauseBloc>()
                                      .add(const PauseGame(isPaused: false));
                                },
                                child: Text(
                                  'Resume',
                                  style: TextStyleTheme(context).bodyMedium,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const BacksoundPauseButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

final Map<String, Content> _content = {
  'CommuterRush': (
    assetGenImage: Assets.images.aboutKrl,
    description:
        '''The Electric Rail Train, commonly known as the KRL Commuter Line, is one of the main modes of public transportation relied upon by urban workers for commuting during weekdays in the Greater Jakarta area.''',
  ),
  'TelorGulung': (
    assetGenImage: Assets.images.aboutTelor,
    description:
        '''Telur Gulung or Telor Gulung, a traditional Indonesian dish, is a variation of fried egg where an egg is fried and rolled using a skewer typically made from bamboo wood. This food is famously sold in schools, especially in elementary schools, and is considered a legendary snack because it has been around since the 90s.''',
  ),
  // 'StableSidewalk': (
  //   assetGenImage: Assets.images.aboutKrl,
  //   description: '''''',
  // ),
  'LitterPicker': (
    assetGenImage: Assets.images.aboutInorganic,
    description:
        '''Inorganic waste, consisting of non-biodegradable materials that do not break down easily in the environment. This category includes materials like plastics, metals, glass, ceramics, and synthetic fibers. This waste can persist in the environment for long periods, contributing to pollution and taking up valuable space in landfills. Recycling is a key strategy for managing this type of waste, as it allows materials to be collected, processed, and reused in the production of new products, reducing the need for virgin materials and minimizing environmental impact.''',
  ),
  // 'CollectSocket': (
  //   assetGenImage: Assets.images.aboutKrl,
  //   description: '''''',
  // ),
  'BatteryParry': (
    assetGenImage: Assets.images.aboutHazard,
    description:
        '''Hazardous/Toxic waste is a type of waste that poses a potential threat to human health or the environment due to its chemical, biological, or physical properties. This can include items such as batteries, electronics, certain chemicals, and medical waste. The handling of this type of waste involves collecting it separately from other waste and then sending it to the nearest hazardous waste treatment center.''',
  ),
};

typedef Content = ({
  AssetGenImage assetGenImage,
  String description,
});
