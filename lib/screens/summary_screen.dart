import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Result Summary',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Subjects: ${subjectProvider.totalSubjects}'),
                  const SizedBox(height: 8),
                  Text(
                    'Passing Subjects: ${subjectProvider.passingSubjects.length}',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Average Mark: ${subjectProvider.averageMark.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 8),
                  Text('Overall Grade: ${subjectProvider.overallGrade}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}