import 'package:gsheets/gsheets.dart';
import 'package:my_app/model/user.dart';

class UserSheetsApi {
  static const _credentials = r'''
                  {
                    "type": "service_account",
                    "project_id": "perfect-age-361912",
                    "private_key_id": "d5409ca5e3fe5jackpatcherd97d6a1422f579djackpatcher9bc823f023b4",
                    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCwAln07cVpdh/X\nAUJIZQf6SPoHahxMJwyuq+KyFJyX8VW/oJEctN142gtM473yLWIWej/QahTV/TXh\nzwvg+u/XVWCD5NAE4ZQQ2ZlI2vD1TWsL8QR7N8bq6lDJ5nynfP28NomRkyxMxXtB\nduu4Ik/1VI8eWtiftSrhu/X2XTyHrC+b89Gy5BvmjkEun86OHadNVzbHz+KfYWVC\n9cSQL/pXTXfXsBQmMzzfzopT3S/C2MMrguAV/EDfaODhSMPV6RPyiiHAHzRuxnN7\nts0XLR1DlwhjDH25jj2YYgV1naVpObIzn/VQKfcGoUib67sLLjs/EAuEfsmEgNOl\nxhYVUWR5AgMBAAECggEABXtpRF70h2Khvr9gCmO1Mic8PGdibr/Hnhgl9TB9qSDf\n8BpG8ssyW72E3RX52FVwCO2xV6M6N2kN2NTrVIxUVJNo8Gq7zO8evsCcTN/e4fER\nnLtazaCw3ifCsOswJkJXH9neAo4AMvryqhkTYfaVoXlLBOHE/gJ1TbceQ9hnFn2p\n+b8kjLzDHCUZUvfOssDjttrZTOcr7Ne+w//b+KgNSEfmZYQf6x0tRWwROejfaUYI\nUR4GUA7aoMyjed/6UXIb71xAuw8plEgOoTh3MXrmUQRjLbaQQHc79z0/kMBZXWtC\nsVoqP3OV8LP1uYdkkoebESdxGE8IkPWQTm2fNlBbwQKBgQDb2/GS8CoKojK8n/28\nf5mhaPaaCN3+WNzDAbqXcGUsT5pyJu1CuiAqMIMdjhPSaWpU/AJQbKAs68UiHQle\ncXigS1yJzguHpERMefOt96ACboeK9F8WPQJHuurepfEbhY+QPRTqtsP8Yje3XAxM\nsxNUhOyKqtJyym1siq7rqZhMWQKBgQDM8R/mS+vYJyQu3C9L5V5/QvZmKNQgqQJI\nze3k2k9v5aBwVW0TK+njnGiosRS6q313+vlPyNFI42WBcBHYyD79vKm1wT3j+t6X\n2BTm4dYO5ab2+gM5BGcI5l/RX5i1b9RiCP8pX6KROjssaygwfmWClVQp8FNXoxPW\n+b1SH0ZVIQKBgQCIbwOJOIoOUTsE/I+70r8mf/lP+yKvfLt6M+9znKbcCYYBQpDH\ncLMXG0WyKIG6d/opRL225MG9Po31rmkq92Vwq3OAfKGBCfnsL119XoYoHCj2nNEI\n/tEUbDTl97oYZxiA3LbHNKWIT/bdTTzAt/vN3jLflkPEQkQHMER+L583+QKBgD2Z\n4L/FZE+lfD/FmUXT3PKduxh7/z8N7gzaMT6PzD7TI8WAN/gCRBxRYDgMejGd6GnO\n+29a6mVhTJp6iDLEBgMY2V4zhpnnR08W+Tlo+oGhz+z+u0dBJoNLU9PIS0uGIK2T\nDLdv8pp6iVzRnNPuui5lGlY80aBO+WCt0pVDp01hAoGBANHwZnHFwkISUSlGl2D1\nLoRxBgJ27LMf6iTo8UHhUxU6as+6QC7O6xUJSO9vJTOuD0/LA0LDX2F1p1As3LzF\n+I+oYaFr/+PVACO2w5Ls31ue8CYpF+dPUZJndCDb+RV0ORa0KxZpKZSKTNZcM8m0\nboZ+NP1qTzIdQbTnrN06kRi0\n-----END PRIVATE KEY-----\n",
                    "client_email": "sampleflutter@perfect-age-361912.iam.gserviceaccount.com",
                    "client_id": "102213598136515727639",
                    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
                    "token_uri": "https://oauth2.googleapis.com/token",
                    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
                    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sampleflutter%40perfect-age-361912.iam.gserviceaccount.com"
                  }

                  ''';

  static const _spreadsheetId = '1Uq7roGveZ5UvZpUTRaWzgVPpxIrjiNwjc61ViH11SXU';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'user');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init error : $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;
    _userSheet!.values.map.appendRows(rowList);
  }
}
