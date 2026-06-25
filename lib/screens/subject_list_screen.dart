import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/subject.dart';
import '../providers/subject_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  Future<void> _openEditScreen(
    BuildContext pageContext,
    Subject subject,
  ) async {
    final didUpdate = await Navigator.of(pageContext).push<bool>(
      MaterialPageRoute(builder: (_) => _EditSubjectScreen(subject: subject)),
    );

    if (didUpdate == true && pageContext.mounted) {
      ScaffoldMessenger.of(
        pageContext,
      ).showSnackBar(const SnackBar(content: Text('Subject updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageContext = context;
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

            if (!pageContext.mounted) {
              return;
            }

            ScaffoldMessenger.of(
              pageContext,
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
                    onPressed: () => _openEditScreen(pageContext, subject),
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

class _EditSubjectScreen extends StatefulWidget {
  const _EditSubjectScreen({required this.subject});

  final Subject subject;

  @override
  State<_EditSubjectScreen> createState() => _EditSubjectScreenState();
}

class _EditSubjectScreenState extends State<_EditSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _markController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.subject.name);
    _markController = TextEditingController(
      text: widget.subject.mark.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  Future<void> _updateSubject() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await context.read<SubjectProvider>().updateSubject(
      id: widget.subject.id,
      name: _nameController.text,
      mark: int.parse(_markController.text.trim()),
    );

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Subject')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
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
                controller: _markController,
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
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _updateSubject,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
