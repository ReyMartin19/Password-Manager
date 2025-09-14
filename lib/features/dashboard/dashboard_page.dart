import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 👈 make sure to add provider: ^6.0.0 in pubspec.yaml
import 'package:password_manager/models/password_entry.dart';
import 'package:password_manager/core/app_routes.dart';
import 'password_dialog.dart';
import 'password_grid.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void _showPasswordDialog(
    BuildContext context, {
    PasswordEntry? existingEntry,
    int? index,
  }) {
    final controller = context.read<DashboardController>();

    showDialog(
      context: context,
      builder: (context) {
        return PasswordDialog(
          existingEntry: existingEntry,
          onSave: (entry) {
            if (existingEntry == null) {
              controller.addEntry(entry);
            } else {
              controller.updateEntry(index!, entry);
            }
          },
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.lock, color: Colors.white, size: 32),
                SizedBox(height: 8),
                Text(
                  'Password Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Secure & Organized',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Dashboard'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.settings);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    _logout(context);
                  },
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardController(),
      child: Consumer<DashboardController>(
        builder: (context, controller, _) {
          final passwords = controller.passwords;

          return Scaffold(
            appBar: AppBar(title: const Text("Dashboard")),
            drawer: _buildDrawer(context),
            body: PasswordGrid(
              passwords: passwords,
              hidden: {
                for (var e in passwords) e.id: controller.isHidden(e.id),
              },
              onToggleVisibility: controller.toggleVisibility,
              onEdit: (entry, index) => _showPasswordDialog(
                context,
                existingEntry: entry,
                index: index,
              ),
              onDelete: controller.deleteEntry,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showPasswordDialog(context),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
