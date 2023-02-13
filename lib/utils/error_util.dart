import 'package:flutter/material.dart';

class ErrorUtil {
  static void showDeleteCheckDialog(BuildContext context,
      {required onDelete, required onCancel}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to delete your account?'),
        // content: Text(errorMessage),
        actions: [
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () => onCancel,
          ),
          ElevatedButton(
            child: const Text('Delete'),
            onPressed: () => onDelete,
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
