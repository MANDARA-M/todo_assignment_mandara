import 'package:go_router/go_router.dart';

import '../Screens/account/login_screen.dart';
import '../Screens/account/otp_screen.dart';
import '../Screens/create/create_task_screen.dart';
import '../Screens/home/dashboard_screen.dart';
import '../Screens/profile/profile_screen.dart';
import '../Screens/splash/onboarding_screen.dart';
import '../Screens/splash/splash_screen.dart';
import '../network/models/todo/task.dart';
import '../utilities/app_utils.dart';
import '../wrapper/connectivity_widget_wrapper.dart';
import 'animated_page_transitions.dart';

class RouterConfigs {
  RouterConfigs._();

  static final instance = RouterConfigs._();

  final routerConfig = GoRouter(
    initialLocation: AppRoute.splash.path,
    routes: [
      AppRoute.splash.getAnimatedRoute(builder: (context, state) => const SplashScreen(), animationType: AnimationType.fade),
      AppRoute.onboarding.getAnimatedRoute(builder: (context, state) => const OnBoardingScreen()),
      AppRoute.login.getAnimatedRoute(builder: (context, state) => const LoginScreen()),
      AppRoute.otp.getAnimatedRoute(
        builder: (context, state) {
          final phoneNumber = state.extra! as String;
          return OTPScreen(phoneNumber: phoneNumber);
        },
      ),
      AppRoute.dashboard.getAnimatedRoute(builder: (context, state) => const DashboardScreen()),
      AppRoute.profile.getAnimatedRoute(builder: (context, state) => const ProfileScreen()),
      AppRoute.createTask.getAnimatedRoute(
        builder: (context, state) {
          CreateTaskScreenRouteObject? routeObject;
          if (state.extra != null) {
            routeObject = state.extra! as CreateTaskScreenRouteObject;
          }
          return CreateTaskScreen(routeObject: routeObject);
        },
      ),
    ],
    errorBuilder: (context, state) => const SplashScreen(),
  );
}

enum AppRoute {
  splash(name: 'splash', path: '/'),
  onboarding(name: 'onboarding', path: '/onboarding'),
  login(name: 'login', path: '/login'),
  otp(name: 'otp', path: '/otp'),
  dashboard(name: 'dashboard', path: '/home'),
  createTask(name: 'createTask', path: '/createTask'),
  profile(name: 'profile', path: '/profile');

  const AppRoute({required this.name, required this.path});

  final String name;
  final String path;
}

extension AppRouteExtension on AppRoute {
  GoRoute getRoute({required GoRouterWidgetBuilder builder}) {
    return GoRoute(name: name, path: path, builder: builder);
  }

  GoRoute getAnimatedRoute({required GoRouterWidgetBuilder builder, AnimationType animationType = AnimationType.slideFromRight}) {
    return GoRoute(
      name: name,
      path: path,
      pageBuilder: (context, state) {
        final child = builder(context, state);
        return CustomTransitionPage(
          key: state.pageKey,
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return animationType.transitionBuilder(child).transitionsBuilder(context, animation, secondaryAnimation, child);
          },
          transitionDuration: const Duration(milliseconds: 200),
        );
      },
    );
  }
}

class CreateTaskScreenRouteObject {
  CreateTaskScreenRouteObject({required this.docId, required this.task});

  final String? docId;
  final Task? task;
}
