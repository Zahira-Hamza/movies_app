// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get register => 'انشاء حساب';

  @override
  String get name => 'الاسم';

  @override
  String get email => 'البريد الالكتروني';

  @override
  String get password => 'الرقم السري';

  @override
  String get confirm_password => 'تاكيد الرقم السري';

  @override
  String get phone_number => 'رقم الهاتف';

  @override
  String get create_account => 'انشاء حساب';

  @override
  String get have_account => 'تمتلك حساب بالفعل ؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get forgot_password => 'هل نسيت كلمة المرور؟';

  @override
  String get dont_have_account => 'ليس لديك حساب؟';

  @override
  String get create_one => 'إنشاء حساب';

  @override
  String get or => 'أو';

  @override
  String get login_with_google => 'تسجيل الدخول عبر جوجل';
}
