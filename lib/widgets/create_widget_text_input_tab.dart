import 'package:flutter/material.dart';
import 'package:podai/services/services.dart';

class CreateWidgetTextInputTab extends StatefulWidget {
  @override
  _CreateWidgetTextInputTabState createState() => _CreateWidgetTextInputTabState();
}

class _CreateWidgetTextInputTabState extends State<CreateWidgetTextInputTab> {
  bool isLoading = false;
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide keyboard and lose focus when clicking outside the input
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  CreatePodcastService().generatePodcast(_subjectController.text, _nameController.text).then((_) {
                    setState(() {
                      isLoading = false;
                    });
                  });
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}