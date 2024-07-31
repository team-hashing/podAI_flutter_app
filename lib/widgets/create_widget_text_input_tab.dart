import 'package:flutter/material.dart';
import 'package:podai/services/services.dart';
import 'package:podai/widgets/widgets.dart'; // Assuming widgets.dart contains custom widgets used in HomeScreen

class CreateWidgetTextInputTab extends StatefulWidget {
  const CreateWidgetTextInputTab({super.key});

  @override
  _CreateWidgetTextInputTabState createState() =>
      _CreateWidgetTextInputTabState();
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
      child: Expanded(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      labelStyle: const TextStyle(
                          color: Colors.white), // Set label text color to white
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.white), // Set outline color to white
                        borderRadius: BorderRadius.circular(
                            10.0), // Match the border radius
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors
                                .white), // Set outline color to white when focused
                        borderRadius: BorderRadius.circular(
                            10.0), // Match the border radius
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(
                          color: Colors.white), // Set label text color to white
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.white), // Set outline color to white
                        borderRadius: BorderRadius.circular(
                            10.0), // Match the border radius
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors
                                .white), // Set outline color to white when focused
                        borderRadius: BorderRadius.circular(
                            10.0), // Match the border radius
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      CreatePodcastService()
                          .generatePodcast(
                              _subjectController.text, _nameController.text)
                          .then((_) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[300],
                      foregroundColor: Colors.white, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            16.0),
                      ),
                      minimumSize: const Size.fromHeight(
                                50),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text('Submit'),
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
