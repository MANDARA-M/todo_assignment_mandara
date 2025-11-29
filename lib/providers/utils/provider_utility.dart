import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../authentication_provider.dart';
import '../theme_provider.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());

final authenticationProvider = ChangeNotifierProvider<AuthenticationProvider>((ref) => AuthenticationProvider());
