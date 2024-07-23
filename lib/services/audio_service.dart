import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:podai/services/services.dart';
import 'package:rxdart/rxdart.dart';
import '../models/models.dart';
import 'dart:async';


class AudioService {
  static final AudioService _instance = AudioService._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();
  static AudioService get instance => _instance;
  final BehaviorSubject<Podcast?> _currentPodcastSubject = BehaviorSubject<Podcast?>();


  int currentProgress = 0;	

  AudioService._internal();

  AudioPlayer get audioPlayer => _audioPlayer;
  StreamSubscription<Duration>? _positionSubscription; // Add this line
  Stream<Podcast?> get currentPodcastStream => _currentPodcastSubject.stream;
  Stream<bool> get isPlayingStream => _audioPlayer.playingStream;
  Podcast? get _currentPodcast => _currentPodcastSubject.valueOrNull;  set _currentPodcast(Podcast? podcast) => _currentPodcastSubject.add(podcast);

  Future<void> setCurrentPodcast(Podcast podcast) async {
    
    stopPositionListener();
    _currentPodcast = podcast;

    
    String audioUrl = await StoreService.instance.accessFile(podcast.uuid, Types.audio); 

    audioPlayer.setUrl(
      audioUrl
    ).then((_) {
      // After setting the audio source, seek to the last known position
      Duration initialPosition = Duration(milliseconds: podcast.progress);
      audioPlayer.seek(initialPosition).then(
        (_) => _setupPositionListener(),
      );
    });
  }


  Stream<SeekBarData> get seekBarDataStream => Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        _audioPlayer.positionStream,
        _audioPlayer.durationStream,
        (Duration position, Duration? duration) {
          return SeekBarData(position, duration ?? Duration.zero);
        },
      );
  
  Podcast? getCurrentPodcast() {
    return _currentPodcast; 
  }

  void _setupPositionListener() {
    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      int progress = position.inMilliseconds;
      currentProgress = progress;
    });
  }
  
  void stopPositionListener() {
    updatePodcastProgress();
    _positionSubscription?.cancel(); // Add this method
    _positionSubscription = null;
    _currentPodcast = null;
  }

  void updatePodcastProgress() {
    if (_currentPodcast != null) {
      _currentPodcast!.progress = currentProgress;
    }
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void seekToBeginning() {
    _audioPlayer.seek(Duration.zero, index: _audioPlayer.effectiveIndices?.first);
  }

  void seekForward10Seconds() {
    final position = _audioPlayer.position;
    final newPosition = min(_audioPlayer.duration?.inMilliseconds ?? 0, position.inMilliseconds + Duration(seconds: 10).inMilliseconds);
    _audioPlayer.seek(Duration(milliseconds: newPosition));
  }

  void seekBackward10Seconds() {
    final position = _audioPlayer.position;
    final newPosition = max(0, position.inMilliseconds - Duration(seconds: 10).inMilliseconds);
    _audioPlayer.seek(Duration(milliseconds: newPosition));
  }

  void dispose() {
    _audioPlayer.dispose();
    _currentPodcastSubject.close();
  }

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  Future<Duration?> get duration async => _audioPlayer.duration;
}

class SeekBarData {
  final Duration position;
  final Duration duration;

  SeekBarData(this.position, this.duration);
}
