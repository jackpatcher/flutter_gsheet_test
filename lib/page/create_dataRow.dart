import 'package:flutter/material.dart';
import 'package:my_app/api/sheets/user_sheets_api.dart';

import 'package:my_app/model/user.dart';
import 'package:my_app/widget/button_widget.dart';

class CreateSheetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          child: ButtonWidget(
            text: 'Save',
            onClicked: () async {
              /*final user = {
                UserFields.id = 1,
                UserFields.name = "Am",
                UserFields.email = "amp@gmail.com",
                UserFields.isBegining = true,
              };
              await UserSheetsApi.insertRow([user]);*/
            },
          ),
        ),
      );
}
