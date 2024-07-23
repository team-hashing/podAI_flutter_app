
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:podai/services/services.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    AudioService audioService = AudioService.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<Duration>(
          stream: audioService.audioPlayer.positionStream,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return 
                IconButton(
                  icon: const Icon(Icons.replay_10, size: 50.0,),
                  onPressed: () {
                    audioService.seekBackward10Seconds();
                  },
                );
            }
            else {
              return const CircularProgressIndicator();
            }
          }),
        StreamBuilder<PlayerState>(
          stream: audioService.audioPlayer.playerStateStream, 
          builder: (context, snapshot) {
            if (snapshot.hasData){
              final playerState = snapshot.data;
              final processingState = playerState!.processingState;
    
              if(processingState == ProcessingState.loading || 
              processingState == ProcessingState.buffering) {
                return IconButton(
                  icon: Icon(Icons.play_circle, size: 75.0, color: DefaultSelectionStyle.defaultColor.withOpacity(0.5),),
                  onPressed: audioService.play,
                );
              }
              else if (!audioService.audioPlayer.playing){
                return IconButton(
                  icon: const Icon(Icons.play_circle, size: 75.0,),
                  onPressed: audioService.play,
                );
              }
              else if (processingState != ProcessingState.completed){
                return IconButton(
                  icon: const Icon(Icons.pause_circle, size: 75.0,),
                  onPressed: audioService.pause,
                );
              }
              else {
                return IconButton(
                  icon: const Icon(Icons.replay_circle_filled_outlined, size: 75.0,),
                  onPressed: () => audioService.seek(Duration.zero),
                );
              }
            }
            else {
              return IconButton(
                icon: Icon(Icons.play_circle, size: 75.0, color: DefaultSelectionStyle.defaultColor.withOpacity(0.5),),
                onPressed: audioService.play,
              );
            }
          }),
          
          StreamBuilder<Duration>(
            stream: audioService.positionStream,
            builder: (context, snapshot) {
              if (snapshot.hasData){
                return 
                  IconButton(
                    icon: const Icon(Icons.forward_10, size: 50.0,),
                    onPressed: () {
                      audioService.seekForward10Seconds();
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