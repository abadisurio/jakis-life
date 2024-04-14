part of 'lobby_multiplayer_page.dart';

class _CardBack extends StatefulWidget {
  const _CardBack({this.background});

  final Widget? background;

  @override
  State<_CardBack> createState() => _CardBackState();
}

class _CardBackState extends State<_CardBack> {
  final _flutterGoogleWalletPlugin = FlutterGoogleWalletPlugin();
  bool? _isWalletAvailable;

  @override
  void initState() {
    _checkWallet();
    super.initState();
  }

  Future<void> _checkWallet() async {
    await _flutterGoogleWalletPlugin.initWalletClient();
    _isWalletAvailable =
        await _flutterGoogleWalletPlugin.getWalletApiAvailabilityStatus();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (prev, curr) => prev.authState != curr.authState,
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.grey.shade700,
            height: _Card.height,
            width: _Card.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (widget.background != null)
                  Transform.flip(
                    flipX: true,
                    child: widget.background,
                  ),
                if (state.authState == AuthState.signedIn)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=https://jakislife-dev.web.app/?start-multiplayer=${state.user?.id}',
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Text(
                      //   'Back',
                      //   style: TextStyleTheme(context)
                      //       .titleMedium
                      //       ?.copyWith(color: Colors.white),
                      // ),
                      if (_isWalletAvailable ?? false)
                        AddToGoogleWalletButton(
                          locale: const Locale('en', 'US'),
                          onPress: () {
                            _flutterGoogleWalletPlugin.savePasses(
                              jsonPass: getPassString(
                                state.badgeSeries ?? 0,
                                state.user!.id,
                              ),
                              addToGoogleWalletRequestCode: 2,
                            );
                          },
                        ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final String _passId = const Uuid().v4();
const String _passClass = 'jakislifegeneric';
const String _issuerId = '3388000000022326911';
const String _issuerEmail = 'abadisuryosetiyo@gmail.com';

final imageHero = [
  'https://storage.googleapis.com/jakislife-bucket/assets/card/jakis_badge_hero_1.png',
  'https://storage.googleapis.com/jakislife-bucket/assets/card/jakis_badge_hero_2.png',
  'https://storage.googleapis.com/jakislife-bucket/assets/card/jakis_badge_hero_3.png',
];
final imageCard = [
  'https://storage.googleapis.com/jakislife-bucket/assets/card/jakis_badge_card_1.png',
  'https://storage.googleapis.com/jakislife-bucket/assets/card/jakis_badge_card_2.png',
  'https://storage.googleapis.com/jakislife-bucket/assets/card/jakis_badge_card_3.png',
];
final color = [
  'B3A4EE',
  'B4E080',
  'F199CE',
];

String getPassString(int series, String userId) {
  return '''
{
  "aud": "google",
  "origins": [],
  "iss": "$_issuerEmail",
  "iat": 123456789,
  "typ": "savetowallet",
  "payload": {
    "genericObjects": [
      {
        "id": "$_issuerId.$_passId",
        "classId": "$_issuerId.$_passClass",
        "state": "ACTIVE",
        "heroImage": {
          "sourceUri": {
            "uri": "${imageHero[series]}"
          },
          "contentDescription": {
            "defaultValue": {
              "language": "en-US",
              "value": "Characters inside Jaki's life as representation of Jakarta"
            }
          }
        },
        "imageModulesData": [
          {
            "mainImage": {
              "sourceUri": {
                "uri": "${imageCard[series]}"
              },
              "contentDescription": {
                "defaultValue": {
                  "language": "en-US",
                  "value": "Jaki's card image"
                }
              }
            },
            "id": "IMAGE_MODULE_ID"
          }
        ],
        "barcode": {
          "type": "QR_CODE",
          "value": "https://jakislife-dev.web.app/?start-multiplayer=$userId"
        },
        "cardTitle": {
          "defaultValue": {
            "language": "en-US",
            "value": "Achievement and QR code badge"
          }
        },
        "header": {
          "defaultValue": {
            "language": "en-US",
            "value": "Jaki's Badge"
          }
        },
        "hexBackgroundColor": "#${color[series]}",
        "logo": {
          "sourceUri": {
            "uri": "https://storage.googleapis.com/jakislife-bucket/assets/ic_launcher_round.png"
          },
          "contentDescription": {
            "defaultValue": {
              "language": "en-US",
              "value": "Jaki's card logo"
            }
          }
        }
      }
    ]
  }
}
''';
}
