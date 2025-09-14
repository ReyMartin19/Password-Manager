import 'package:flutter/material.dart';
import 'package:password_manager/models/password_entry.dart';

class PasswordDialog extends StatefulWidget {
  final PasswordEntry? existingEntry;
  final void Function(PasswordEntry entry) onSave;

  const PasswordDialog({super.key, this.existingEntry, required this.onSave});

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  late TextEditingController titleController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController notesController;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.existingEntry?.title ?? "",
    );
    usernameController = TextEditingController(
      text: widget.existingEntry?.username ?? "",
    );
    passwordController = TextEditingController(
      text: widget.existingEntry?.password ?? "",
    );
    notesController = TextEditingController(
      text: widget.existingEntry?.notes ?? "",
    );
    selectedCategory = widget.existingEntry?.category ?? "General";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.existingEntry == null ? "Add New Password" : "Edit Password",
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: "Notes"),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              // ignore: deprecated_member_use
              value: selectedCategory,
              decoration: const InputDecoration(labelText: "Category"),
              items: ["General", "Social", "Banking", "Work", "Other"]
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) =>
                  setState(() => selectedCategory = val ?? "General"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final entry = PasswordEntry(
              id:
                  widget.existingEntry?.id ??
                  DateTime.now().millisecondsSinceEpoch.toString(),
              title: titleController.text,
              username: usernameController.text,
              password: passwordController.text,
              notes: notesController.text.isEmpty ? null : notesController.text,
              category: selectedCategory,
            );
            widget.onSave(entry);
            Navigator.pop(context);
          },
          child: Text(widget.existingEntry == null ? "Save" : "Update"),
        ),
      ],
    );
  }
}
