import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_reporting/features/home/cubit/home_bloc.dart';
import 'package:mobile_reporting/features/reporting/cubit/reporting_bloc.dart';
import 'package:mobile_reporting/features/splash/splash_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:mobile_reporting/features/login/cubit/login_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await OneSignal.Notifications.requestPermission(true);

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // OneSignal.initialize("55a4685d-b12c-4a4c-aa0e-cac5a7ccd72c");
  await OneSignal.Notifications.requestPermission(true);

  _setupNotificationListeners();
  _setupNativeNotificationListener();


  WidgetsBinding.instance.addPostFrameCallback((_) {
   scheduleMicrotask(() => _checkPendingNotification());
  });
}

Future<void> _checkPendingNotification() async {
  const platform = MethodChannel('notification_test');
  try {
    final result = await platform.invokeMethod('getPendingNotification');

    if (result != null && result is Map) {

      final data = Map<String, dynamic>.from(result);

      if (data['doctype']?.toString().isNotEmpty == true) {
        debugPrint('✅ Valid notification data, navigating...');

        await Future.delayed(Duration(milliseconds: 300));
        handleNotificationNavigation(data);
      } else {
        debugPrint('Invalid notification data, going to home');
        // router.go('/home');
      }
    } else {
      debugPrint('No pending notification found');
    }
  } catch (e) {
    debugPrint('Error checking pending notification: $e');
  }
}

void _setupNativeNotificationListener() {
  const platform = MethodChannel('notification_test');

  platform.setMethodCallHandler((call) async {
    if (call.method == 'onNotificationTapped') {
      debugPrint('Native notification tapped!');

      final Map<dynamic, dynamic> arguments = call.arguments;
      final data = {
        'doctype': arguments['doctype'] ?? '',
        'name': arguments['name'] ?? '',
        'state': arguments['state'] ?? '',
      };

      debugPrint('Data from native: $data');

      await Future.delayed(Duration(milliseconds: 300));

      if (data['doctype']?.toString().isNotEmpty == true) {
        debugPrint('Valid data, handling navigation');
        handleNotificationNavigation(data.cast<String, dynamic>());
      } else {
        debugPrint(' Invalid data, going to home');
        // router.go('/home');
      }
    }
  });
}

void _setupNotificationListeners() {
  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    

    final additionalData = event.notification.additionalData;
    _triggerNativeHeadsUpNotification(
      event.notification.title ?? 'Notifikasi',
      event.notification.body ?? '',
      additionalData ?? {},
    );
  });

  OneSignal.Notifications.addClickListener((event) {
    final additionalData = event.notification.additionalData;


    if (additionalData != null && additionalData.isNotEmpty) {
      handleNotificationNavigation(additionalData);
    } else {
      debugPrint('Tidak ada additional data, buka home');
      // router.go('/home');
    }
  });

  OneSignal.Notifications.addPermissionObserver((state) {
    debugPrint("Notification permission state: $state");
  });
}



void handleNotificationNavigation(Map<String, dynamic> data) {
  try {
    final doctype = data['doctype'] as String?;
    final name = data['name'] as String?;
    final state = data['state'] as String?;

    debugPrint('Navigation Info:');
    debugPrint('Doctype: $doctype');
    debugPrint('Name: $name');
    debugPrint('State: $state');

    // router.go("/home");
  } catch (e) {
    debugPrint('Error handling navigation: $e');
    // router.go('/home');
  }
}



Future<void> _triggerNativeHeadsUpNotification(
  String title,
  String body,
  Map<String, dynamic> additionalData,
) async {
  const platform = MethodChannel('notification_test');
  try {
    await platform.invokeMethod('showHeadsUpNotification', {
      'title': title,
      'body': body,
      'doctype': additionalData['doctype'] ?? '',
      'name': additionalData['name'] ?? '',
      'state': additionalData['state'] ?? '',
    });
    debugPrint('Native heads-up notification triggered with data:');
    debugPrint('Doctype: ${additionalData['doctype']}');
    debugPrint('Name: ${additionalData['name']}');
    debugPrint('State: ${additionalData['state']}');
  } catch (e) {
    debugPrint('Error triggering native notification: $e');
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => ReportingBloc()),


      ],

    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
      useMaterial3: false,
    
    ),
    home: const SplashScreen(),
    
    ),
    );
}
}