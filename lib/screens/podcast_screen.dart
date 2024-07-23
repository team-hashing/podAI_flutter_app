import 'package:flutter/material.dart';
import 'package:podai/services/audio_service.dart';
import 'package:podai/widgets/audio_player.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import 'package:podai/models/models.dart';
import 'package:podai/widgets/widgets.dart';
import 'package:podai/services/services.dart';

class PodcastScreen extends StatefulWidget {

  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  AudioService audioService = AudioService.instance;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Now playing'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.purple[50],
      body: const AudioPlayerWidget(),
    );
  }

}

