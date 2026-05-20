import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/constants/app_constants.dart';
import 'config/router/app_router.dart';
import 'config/router/firebase_config.dart';
import 'core/utils/debug_logger.dart';
import 'feauters/movies/data/repositories/movies_repository.dart';
import 'feauters/movies/presentation/cubit/movies_cubit.dart';
import 'feauters/notifications/services/fcm_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();
bool navigated = false;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    DebugLogger.notification('Background message: ${message.notification?.title}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseConfig.androidOptions,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FcmService.initialize();
  runApp(const MovieApp());
}

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => MovieAppState();
}

class MovieAppState extends State<MovieApp> {
  static const channel = MethodChannel('movie_app/deep_links');

  @override
  void initState() {
    super.initState();

    listenDeepLinks();
  }
  void listenDeepLinks() async {

    final initialLink =
    await channel.invokeMethod<String>('getInitialLink');

    if (initialLink != null) {
      navigateFromDeepLink(initialLink);
    }

    channel.setMethodCallHandler((call) async {

      if (call.method == 'onDeepLink') {

        final link = call.arguments as String;

        navigateFromDeepLink(link);
      }
    });
  }

  void navigateFromDeepLink(String link) {
    final fixedLink = link.replaceFirst('movieapptask://', 'movieapptask://');
    final uri = Uri.tryParse(fixedLink);
    if (uri == null) return;

    if (uri.host == 'open') {
      navigated = true;
      appRouter.go('/movies');
    } else if (uri.host == 'details_screen' && uri.pathSegments.isNotEmpty) {
      final id = uri.pathSegments.first;
      navigated = true;
      appRouter.go('/movies/$id');
    }
  }

  void handleDeepLink(String link) {
    DebugLogger.deepLink('Received deep link: $link');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoviesCubit(MoviesRepository()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MovieApp',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.grey[950],
          colorScheme: const ColorScheme.dark(primary: AppColor.primaryColor),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}