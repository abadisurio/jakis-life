import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jakislife/app/app.dart';
import 'package:jakislife/flutter_notifications.dart';
import 'package:jakislife/shared/bloc/multiplayer_bloc/multiplayer_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/l10n/l10n.dart';
import 'package:jakislife/router/jakislife_route.dart';
import 'package:jakislife/screens/pause/bloc/pause_bloc.dart';
import 'package:jakislife/utils/text_theme.dart';

final _jakisLifeRouter = AppRouter();
final _firebaseFirestore = FirebaseFirestore.instance;
final _firebaseAuth = FirebaseAuth.instance;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    /// Receive a notification when the app is in the foreground
    // ignore: unnecessary_lambdas
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      showFlutterNotification(remoteMessage);
    });

    /// Open apps with remote message when app is opened
    /// and running in the background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      final payload = remoteMessage.data['routeName'] as String?;
      if (payload != null) {
        _jakisLifeRouter.pushNamed(payload);
      }
      // showFlutterNotification(remoteMessage);
    });

    selectNotificationStream.stream.listen((String? payload) async {
      if (payload != null) {
        await _jakisLifeRouter.pushNamed(payload);
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      final payload = remoteMessage?.data['routeName'] as String?;
      if (payload != null) {
        _jakisLifeRouter.pushNamed(payload);
      }
    });

    super.initState();
  }

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppBloc()..add(const AppInitialize()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => PauseBloc(),
        ),
        BlocProvider(
          create: (_) => PlayerBloc(
            firebaseFirestore: _firebaseFirestore,
            firebaseAuth: _firebaseAuth,
          )..add(const PlayerInitialize()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => MultiplayerBloc(),
        ),
      ],
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
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          I18nGoogleWallet.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        // home: const LobbyPage(),
        routerConfig: _jakisLifeRouter.config(),
        // home: const TimelinePage(),
        // home: const EventPage(),
      ),
    );
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    super.dispose();
  }
}
