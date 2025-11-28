import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/app_enums.dart';

final languageProvider = StateProvider<Language>((ref) => Language.English);
