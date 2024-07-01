import 'package:flutter/material.dart';
import 'package:podai/widgets/widgets.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // The number of tabs / length of the TabBar
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Text'),
              Tab(text: 'URL'),
              Tab(text: 'Category'),
              Tab(text: 'PDF'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CreateWidgetTextInputTab(textController: _textController),
            PlaceholderTab('Coming soon: Generate from URL'),
            PlaceholderTab('Coming soon: Choose a Category'),
            PlaceholderTab('Coming soon: Upload PDF'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInputTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Describe your podcast topic',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement the logic to generate podcast from text
            },
            child: const Text('Generate Podcast'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String text) {
    return Center(
      child: Text(text),
    );
  }
}