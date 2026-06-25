import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subject_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  Future<void> _showEditDialog(BuildContext context, int index) async {
    final subjectProvider = context.read<SubjectProvider>();
    final subject = subjectProvider.subjects[index];

    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: subject.name);
    final markController = TextEditingController(text: subject.mark.toString());

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Subject'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Subject Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Subject name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: markController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Mark'),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return 'Mark is required';
                    }
                    final mark = int.tryParse(text);
                    if (mark == null) {
                      return 'Mark must be a number';
                    }
                    if (mark < 0 || mark > 100) {
                      return 'Mark must be between 0 and 100';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                await subjectProvider.updateSubject(
                  id: subject.id,
                  name: nameController.text,
                  mark: int.parse(markController.text.trim()),
                );

                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Subject updated')),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    markController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectProvider>();
    final subjects = subjectProvider.subjects;
    final colorScheme = Theme.of(context).colorScheme;

    if (subjects.isEmpty) {
      return Center(
        child: Text(
          'No subjects yet. Add one from the first tab.',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];

        return Dismissible(
          key: ValueKey(subject.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.delete_outline, color: colorScheme.onError),
          ),
          onDismissed: (_) async {
            await subjectProvider.deleteSubjectById(subject.id);

            if (!context.mounted) {
              return;
            }

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Deleted ${subject.name}')));
          },
          child: Card(
            child: ListTile(
              title: Text(subject.name),
              subtitle: Text('Mark: ${subject.mark}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Grade: ${subject.grade}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    onPressed: () => _showEditDialog(context, index),
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: 'Edit Subject',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
