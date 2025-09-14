import 'package:flutter/material.dart';
import 'package:password_manager/core/secure_storage.dart';
import 'package:password_manager/core/app_routes.dart';

class SetMasterPasswordPage extends StatefulWidget {
  const SetMasterPasswordPage({super.key});

  @override
  State<SetMasterPasswordPage> createState() => _SetMasterPasswordPageState();
}

class _SetMasterPasswordPageState extends State<SetMasterPasswordPage> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _savePassword() async {
    if (_formKey.currentState!.validate()) {
      await SecureStorage.saveMasterPassword(_controller.text);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Set Master Password",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _controller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Enter Master Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter password" : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _savePassword,
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
