import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class BadgePage extends StatelessWidget {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BadgeView();
  }
}

class _BadgeView extends StatefulWidget {
  const _BadgeView();

  @override
  State<_BadgeView> createState() => _BadgeViewState();
}

class _BadgeViewState extends State<_BadgeView> {
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
    log('_isWalletAvailable $_isWalletAvailable');
    return Scaffold(
      appBar: AppBar(
        title: const Text('text'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('text'),
            if (_isWalletAvailable ?? false)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: AddToGoogleWalletButton(
                    locale: const Locale('en', 'US'),
                    onPress: () {
                      _flutterGoogleWalletPlugin.savePasses(
                        jsonPass: _exampleJsonPass,
                        addToGoogleWalletRequestCode: 2,
                      );
                    },
                  ),
                ),
              )
            else
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

final String _passId = const Uuid().v4();
const String _passClass = 'jakislifegeneric';
const String _issuerId = '3388000000022326911';
const String _issuerEmail = 'abadisuryosetiyo@gmail.com';

final _exampleJsonPass = '''
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
              "uri": "https://farm4.staticflickr.com/3723/11177041115_6e6a3b6f49_o.jpg"
            },
            "contentDescription": {
              "defaultValue": {
                "language": "en-US",
                "value": "Hero image description"
              }
            }
          },
          "textModulesData": [
            {
              "header": "Text module header",
              "body": "Text module body",
              "id": "TEXT_MODULE_ID"
            }
          ],
          "linksModuleData": {
            "uris": [
              {
                "uri": "http://maps.google.com/",
                "description": "Link module URI description",
                "id": "LINK_MODULE_URI_ID"
              },
              {
                "uri": "tel:6505555555",
                "description": "Link module tel description",
                "id": "LINK_MODULE_TEL_ID"
              }
            ]
          },
          "imageModulesData": [
            {
              "mainImage": {
                "sourceUri": {
                  "uri": "http://farm4.staticflickr.com/3738/12440799783_3dc3c20606_b.jpg"
                },
                "contentDescription": {
                  "defaultValue": {
                    "language": "en-US",
                    "value": "Image module description"
                  }
                }
              },
              "id": "IMAGE_MODULE_ID"
            }
          ],
          "barcode": {
            "type": "QR_CODE",
            "value": "QR code"
          },
          "cardTitle": {
            "defaultValue": {
              "language": "en-US",
              "value": "Generic card title"
            }
          },
          "header": {
            "defaultValue": {
              "language": "en-US",
              "value": "Generic header"
            }
          },
          "hexBackgroundColor": "#4285f4",
          "logo": {
            "sourceUri": {
              "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
            },
            "contentDescription": {
              "defaultValue": {
                "language": "en-US",
                "value": "Generic card logo"
              }
            }
          }
        }
    ]
  }
}
''';

// final _newObject = '''
// {
//     "id": `$_issuerId.$_passId`,
//     "classId": `$_issuerId.$_passClass`,
//     "state": "ACTIVE",
//     "heroImage": {
//       "sourceUri": {
//         "uri": "https://farm4.staticflickr.com/3723/11177041115_6e6a3b6f49_o.jpg"
//       },
//       "contentDescription": {
//         "defaultValue": {
//           "language": "en-US",
//           "value": "Hero image description"
//         }
//       }
//     },
//     "textModulesData": [
//       {
//         "header": "Text module header",
//         "body": "Text module body",
//         "id": "TEXT_MODULE_ID"
//       }
//     ],
//     "linksModuleData": {
//       "uris": [
//         {
//           "uri": "http://maps.google.com/",
//           "description": "Link module URI description",
//           "id": "LINK_MODULE_URI_ID"
//         },
//         {
//           "uri": "tel:6505555555",
//           "description": "Link module tel description",
//           "id": "LINK_MODULE_TEL_ID"
//         }
//       ]
//     },
//     "imageModulesData": [
//       {
//         "mainImage": {
//           "sourceUri": {
//             "uri": "http://farm4.staticflickr.com/3738/12440799783_3dc3c20606_b.jpg"
//           },
//           "contentDescription": {
//             "defaultValue": {
//               "language": "en-US",
//               "value": "Image module description"
//             }
//           }
//         },
//         "id": "IMAGE_MODULE_ID"
//       }
//     ],
//     "barcode": {
//       "type": "QR_CODE",
//       "value": "QR code"
//     },
//     "cardTitle": {
//       "defaultValue": {
//         "language": "en-US",
//         "value": "Generic card title"
//       }
//     },
//     "header": {
//       "defaultValue": {
//         "language": "en-US",
//         "value": "Generic header"
//       }
//     },
//     "hexBackgroundColor": "#4285f4",
//     "logo": {
//       "sourceUri": {
//         "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
//       },
//       "contentDescription": {
//         "defaultValue": {
//           "language": "en-US",
//           "value": "Generic card logo"
//         }
//       }
//     }
//   }
//   ''';
