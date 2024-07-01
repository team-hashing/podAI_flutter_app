
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<Duration>(
          stream: audioPlayer.positionStream,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              final position = snapshot.data;
              return 
                IconButton(
                  icon: const Icon(Icons.replay_10, size: 50.0,),
                  onPressed: () {
                    final newPosition = max(0, position!.inMilliseconds - const Duration(seconds: 10).inMilliseconds);
                    audioPlayer.seek(Duration(milliseconds: newPosition));
                  },
                );
            }
            else {
              return const CircularProgressIndicator();
            }
          }),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream, 
          builder: (context, snapshot) {
            if (snapshot.hasData){
              final playerState = snapshot.data;
              final processingState = playerState!.processingState;
    
              if(processingState == ProcessingState.loading || 
              processingState == ProcessingState.buffering) {
                return IconButton(
                  icon: Icon(Icons.play_circle, size: 75.0, color: DefaultSelectionStyle.defaultColor.withOpacity(0.5),),
                  onPressed: audioPlayer.play,
                );
              }
              else if (!audioPlayer.playing){
                return IconButton(
                  icon: const Icon(Icons.play_circle, size: 75.0,),
                  onPressed: audioPlayer.play,
                );
              }
              else if (processingState != ProcessingState.completed){
                return IconButton(
                  icon: const Icon(Icons.pause_circle, size: 75.0,),
                  onPressed: audioPlayer.pause,
                );
              }
              else {
                return IconButton(
                  icon: const Icon(Icons.replay_circle_filled_outlined, size: 75.0,),
                  onPressed: () => audioPlayer.seek(Duration.zero, index: audioPlayer.effectiveIndices!.first),
                );
              }
            }
            else {
              return IconButton(
                icon: Icon(Icons.play_circle, size: 75.0, color: DefaultSelectionStyle.defaultColor.withOpacity(0.5),),
                onPressed: audioPlayer.play,
              );
            }
          }),
          
          StreamBuilder<Duration>(
            stream: audioPlayer.positionStream,
            builder: (context, snapshot) {
              if (snapshot.hasData){
                final position = snapshot.data;
                return 
                  IconButton(
                    icon: const Icon(Icons.forward_10, size: 50.0,),
                    onPressed: () {
                      final newPosition = min(audioPlayer.duration!.inMilliseconds, position!.inMilliseconds + const Duration(seconds: 10).inMilliseconds);
                      audioPlayer.seek(Duration(milliseconds: newPosition));
                    },
                  );
              }
              else {
                return const CircularProgressIndicator();
              }
            }
          ),
      ],
    );
  }
}