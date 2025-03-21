import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class AttachmentsSection extends StatelessWidget {
  final List<String>? attachments;
  final VoidCallback onAddAttachment;

  const AttachmentsSection({
    super.key,
    this.attachments,
    required this.onAddAttachment,
  });

  @override
  Widget build(BuildContext context) {
    final hasAttachments = attachments != null && attachments!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Attachments', style: Theme.of(context).textTheme.titleLarge),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: onAddAttachment,
            ),
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
                hasAttachments
                    ? Text('Attachments list will be implemented here')
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_file,
                          size: 32,
                          color: AppColors.textSecondary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'No attachments',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Add receipts, invoices, or other documents',
                          style: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ],
    );
  }
}
