import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subject_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectProvider>();
    final subjects = subjectProvider.subjects;
    final colorScheme = Theme.of(context).colorScheme;

    if (subjects.isEmpty) {
      return Center(
        child: Text(
          'No subjects yet. Add one from the first tab.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];

        return Dismissible(
          key: ValueKey('${subject.name}-${subject.mark}-$index'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.delete_outline,
              color: colorScheme.onError,
            ),
          ),
          onDismissed: (_) {
            subjectProvider.deleteSubjectAt(index);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Deleted ${subject.name}')),
            );
          },
          child: Card(
            child: ListTile(
              title: Text(subject.name),
              subtitle: Text('Mark: ${subject.mark}'),
              trailing: Text(
                'Grade: ${subject.grade}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        );
      },
    );
  }
}