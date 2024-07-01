import 'package:flutter/material.dart';

// Separate Widget for Text Input Tab
class CreateWidgetTextInputTab extends StatelessWidget {
  final TextEditingController textController;

  const CreateWidgetTextInputTab({Key? key, required this.textController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'Describe your podcast topic',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement the logic to generate podcast from text
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: const Text(
              'Generate Podcast',
              style: TextStyle(
              color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
