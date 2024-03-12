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
                        if (content != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              height: 400,
                              width: 300,
                              child: ListView(
                                padding: const EdgeInsets.only(bottom: 16),
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
                          const SizedBox(height: 16),
                        ],
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
                            const SizedBox(width: 8),
                            Expanded(
                              child: KJButton(
                                onPressed: () {
                                  context.router.pushWidget(
                                    const _ConfirmQuit(),
                                    opaque: false,
                                    transitionBuilder:
                                        TransitionsBuilders.fadeIn,
                                  );
                                },
                                child: Text(
                                  'Quit',
                                  style: TextStyleTheme(context).bodyMedium,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
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

class _ConfirmQuit extends StatelessWidget {
  const _ConfirmQuit();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      child: Center(
        child: AlertDialog(
          title: Text(
            'Are you sure you want to quit?',
            style: TextStyleTheme(context).titleSmall,
            textAlign: TextAlign.center,
          ),
          actions: [
            KJButton(
              onPressed: () {
                context.router.pop();
              },
              child: Text(
                'Nope',
                style: TextStyleTheme(context).bodyMedium,
              ),
            ),
            const SizedBox(width: 8),
            KJButton(
              onPressed: () {
                context.read<PauseBloc>().add(const PauseGame(isPaused: false));
                context.read<PlayerBloc>().add(const ResetLife());
                context.router.popUntilRoot();
              },
              child: Text(
                'Quit',
                style: TextStyleTheme(context).bodyMedium,
              ),
            ),
          ],
        ),
      ),
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
  'StableSidewalk': (
    assetGenImage: Assets.images.aboutSidewalk,
    description:
        '''Sidewalks help combat climate change by promoting walking and biking, reducing urban heat with reflective materials, managing stormwater, supporting urban greening, connecting to public transit, enhancing resilience, and facilitating mixed-use development. Sidewalk availability and quality vary greatly across Indonesia. Major cities like Jakarta tend to have more extensive sidewalk networks, but even in these areas, sidewalks can be uneven, poorly maintained, or obstructed by street vendors, parked vehicles, or other obstacles. However, the Indonesian government has implemented various initiatives in recent years to improve sidewalks, including pedestrianization projects in certain areas and stricter enforcement of regulations against sidewalk encroachment.''',
  ),
  'LitterPicker': (
    assetGenImage: Assets.images.aboutInorganic,
    description:
        '''Indonesia generates a significant amount of waste daily, with Jakarta alone producing over 9,000 tons. However, the country faces significant challenges in waste management due to its large population, inadequate infrastructure, and lack of awareness about proper waste disposal practices. Although regulations exist mandating waste sorting, approximately 81% of Indonesians do not actually sort their waste at the source. Currently, most waste separation occurs at temporary storage sites (TPS) and landfills by scavengers, rather than at individual homes.''',
  ),
  'CollectSocket': (
    assetGenImage: Assets.images.aboutSocket,
    description:
        '''Do you know that leaving electronic devices plugged in unnecessarily can lead to unnecessary energy consumption, called standby power? Standby power, also known as vampire power, is the energy consumed by electronic devices when they are turned off or in standby mode. This includes common household and office devices such as TVs, computers, chargers, and game consoles. Even small devices like phone chargers draw standby power when left plugged in. While the power usage of each device may seem small, it adds up significantly, accounting for up to 10% or more of total residential electricity consumption worldwide. This contributes to higher electricity bills, energy waste, and greenhouse gas emissions.''',
  ),
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
