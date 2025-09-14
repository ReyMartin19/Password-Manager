import 'package:flutter/material.dart';
import 'package:password_manager/features/auth/login_page.dart';
import 'package:password_manager/features/dashboard/dashboard_page.dart';
import 'package:password_manager/features/settings/settings_page.dart';
import 'package:password_manager/features/auth/set_master_password_page.dart';

class AppRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const settings = '/settings';
  static const setMasterPassword = '/set-master-password';

  static final routes = <String, WidgetBuilder>{
    login: (context) => const LoginPage(),
    dashboard: (context) => const DashboardPage(),
    settings: (context) => const SettingsPage(),
    setMasterPassword: (context) => const SetMasterPasswordPage(),
  };
}
