import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'FlutterDemo',
    },
    'zh': {
      'appTitle': 'Flutter示例',
    },
  };

  String get appTitle {
    return _localizedValues[locale.languageCode]['appTitle'];
  }

  static const LocalizationsDelegate<DemoLocalizations> delegate = _DemoLocalizationsDelegate();
}

//创建代理
class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {

  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return new SynchronousFuture<DemoLocalizations>(
        new DemoLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) => false;

}
