import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CommonLocalizations {
  static LocalizationsDelegate<CupertinoLocalizations>
  get cupertinoLocalization => GlobalCupertinoLocalizations.delegate;

  static LocalizationsDelegate<MaterialLocalizations>
  get materialLocalization => GlobalMaterialLocalizations.delegate;

  static LocalizationsDelegate<WidgetsLocalizations> get widgetsLocalization =>
      GlobalWidgetsLocalizations.delegate;
}
