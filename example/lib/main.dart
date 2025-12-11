import 'package:flutter/material.dart';
import 'package:maintenance_banner/maintenance_banner.dart';
import 'package:maintenance_banner_example/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUnderMaintenance = true;
  String? _lastBannerEvent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maintenance Banner Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: MaintenanceWrapper(
        isUnderMaintenance: isUnderMaintenance,
        animationDuration: const Duration(milliseconds: 400),
        onBannerShown: () {
          setState(() {
            _lastBannerEvent = 'Banner shown at ${DateTime.now().toString().substring(11, 19)}';
          });
          debugPrint('Maintenance banner is now visible');
        },
        onBannerHidden: () {
          setState(() {
            _lastBannerEvent = 'Banner hidden at ${DateTime.now().toString().substring(11, 19)}';
          });
          debugPrint('Maintenance banner is now hidden');
        },
        banner: Container(
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade400,
                Colors.orange.shade600,
              ],
            ),
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.build_circle,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Application under maintenance',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        child: HomePage(
          isUnderMaintenance: isUnderMaintenance,
          onMaintenanceChanged: (value) {
            setState(() {
              isUnderMaintenance = value;
            });
          },
          lastBannerEvent: _lastBannerEvent,
        ),
      ),
    );
  }
}
