import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katajakarta/l10n/l10n.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/screens/pause/bloc/pause_bloc.dart';
import 'package:katajakarta/utils/text_theme.dart';

final _kataJakartaRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.plusJakartaSansTextTheme().copyWith(
      bodySmall: TextStyleTheme.baseBodyStyle,
      bodyMedium: TextStyleTheme.baseBodyStyle,
      bodyLarge: TextStyleTheme.baseBodyStyle,
      titleLarge: TextStyleTheme.baseTitleStyle,
      titleMedium: TextStyleTheme.baseTitleStyle,
      titleSmall: TextStyleTheme.baseTitleStyle,
      labelLarge: TextStyleTheme.baseLabelStyle,
      labelMedium: TextStyleTheme.baseLabelStyle,
      labelSmall: TextStyleTheme.baseLabelStyle,
    );
    return BlocProvider(
      create: (context) => PauseBloc(),
      child: MaterialApp.router(
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.black12,
          primaryColor: Colors.indigo.shade50,
          dividerColor: Colors.indigo.shade100,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              animationDuration: Duration.zero,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          canvasColor: Colors.indigo.shade50,
          textTheme: textTheme,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // home: const LobbyPage(),
        routerConfig: _kataJakartaRouter.config(),
        // home: const TimelinePage(),
        // home: const EventPage(),
      ),
    );
  }
}
