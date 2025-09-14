import 'package:flutter/material.dart';
import 'package:password_manager/models/password_entry.dart';
import 'password_card.dart';

class PasswordGrid extends StatelessWidget {
  final List<PasswordEntry> passwords;
  final Map<String, bool> hidden;
  final void Function(String id) onToggleVisibility;
  final void Function(PasswordEntry entry, int index) onEdit;
  final void Function(int index, String id) onDelete;

  const PasswordGrid({
    super.key,
    required this.passwords,
    required this.hidden,
    required this.onToggleVisibility,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (passwords.isEmpty) {
      return const Center(child: Text("No saved passwords yet"));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive columns based on screen width
        int crossAxisCount;
        double childAspectRatio;

        if (constraints.maxWidth > 1400) {
          crossAxisCount = 5;
          childAspectRatio = 1.3;
        } else if (constraints.maxWidth > 1000) {
          crossAxisCount = 3;
          childAspectRatio = 1.0;
        } else if (constraints.maxWidth > 700) {
          crossAxisCount = 2;
          childAspectRatio = 0.9;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 0.8;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: passwords.length,
          itemBuilder: (context, index) {
            final entry = passwords[index];
            final isHidden = hidden[entry.id] ?? true;

            return PasswordCard(
              entry: entry,
              isHidden: isHidden,
              onToggleVisibility: () => onToggleVisibility(entry.id),
              onEdit: () => onEdit(entry, index),
              onDelete: () => onDelete(index, entry.id),
            );
          },
        );
      },
    );
  }
}
