import 'package:flutter/material.dart';
import 'package:podai/services/services.dart';

class CreateWidgetTextInputTab extends StatefulWidget {
  @override
  _CreateWidgetTextInputTabState createState() => _CreateWidgetTextInputTabState();
}

class _CreateWidgetTextInputTabState extends State<CreateWidgetTextInputTab> {
  bool isLoading = false;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide keyboard and lose focus when clicking outside the input
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card wrap content
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter Podcast Topic',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: textController,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Start typing...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 46, 24, 56),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() => isLoading = true);
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() => isLoading = false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 151, 82, 184),
                    shadowColor: Colors.deepPurpleAccent,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  ),
                  child: const Text('Generate Podcast', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                if (isLoading)
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinearProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Generating Podcast...', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on Widget {
  Widget center() => Center(child: this);
}