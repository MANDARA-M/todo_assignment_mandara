import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../auth_provider.dart';
import '../theme_provider.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());
