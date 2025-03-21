import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class NotesSection extends StatelessWidget {
  final String? notes;
  final VoidCallback onEditTap;

  const NotesSection({super.key, this.notes, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    final hasNotes = notes != null && notes!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Notes', style: Theme.of(context).textTheme.titleLarge),
            IconButton(icon: const Icon(Icons.edit_note), onPressed: onEditTap),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child:
                hasNotes
                    ? Text(notes!)
                    : const Text(
                      'No notes added. Tap the edit button to add notes.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}
