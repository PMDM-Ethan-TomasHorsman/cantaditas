import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';



class Sesion2 extends StatelessWidget {
  const Sesion2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 187, 115),
        title: const Text('Dulces Sueños'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Reproduce el video', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            VideoPlayerScreen(),
            Text('Grabate cantando', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            AudioScreen(),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/el_ultimo.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {
        _controller.setVolume(0.5);  // Volumen medio
        _controller.setPlaybackSpeed(1.0);  // Velocidad normal
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              VideoProgressIndicator(_controller, allowScrubbing: true),
              IconButton(
                icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
                  });
                },
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  late final AudioRecorder _recorder;
  late final AudioPlayer _audioPlayer;
  bool _isRecording = false;
  String? _filePath;
  double _currentPosition = 0;
  double _totalDuration = 0;
  bool _isPlaying = false;


  @override
  void initState() {
    _recorder = AudioRecorder();
    _audioPlayer = AudioPlayer();

    _isRecording = false;
    _currentPosition = 0;
    _totalDuration = 0;
  }

  @override
  void dispose() {
    _recorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }


  Future<void> _startRecording() async {
    final bool isPermissionGranted = await _recorder.hasPermission();
    if (!isPermissionGranted) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    String fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    _filePath = '${directory.path}/$fileName';

    const config = RecordConfig(
      encoder: AudioEncoder.aacLc,   // MPEG-4 AAC Low complexity Will output to MPEG_4 format container.
      numChannels: 2, // default =2, stereo, =1 mono
      sampleRate: 44100, // Samples per second
      bitRate: 128000, // Default bit rate:  128kb per second.  Recomended rate for a good quality in AAC
      autoGain: true, // auto adjust recording volume of high and low sounds
      echoCancel: true,  // cancels echo
    );

    await _recorder.start(config, path: _filePath!);
    print('Recording');

    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stop();
    print('Recorded: $path');

    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _playRecording() async {
    if (_filePath != null) {
      if (_isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await _audioPlayer.setFilePath(_filePath!);
        _totalDuration = _audioPlayer.duration?.inSeconds.toDouble() ?? 0.0;
        _audioPlayer.play();
        setState(() {
          _isPlaying = true;
        });

        // Escuchar cuando termina la reproducción
        _audioPlayer.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            setState(() {
              _isPlaying = false;
              _currentPosition = 0;
            });
          }
        });

        _audioPlayer.positionStream.listen((position) {
          setState(() {
            _currentPosition = position.inSeconds.toDouble();
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _isRecording ? _stopRecording : null,
                icon: const Icon(Icons.stop, color: Colors.red, size: 40),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: _isRecording ? null : _startRecording,
                icon: const Icon(Icons.mic, color: Colors.blue, size: 40),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: (!_isRecording && _filePath != null) ? _playRecording : null,
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ],
          ),
          Slider(
            value: _currentPosition,
            max: _totalDuration,
            onChanged: (value) {
              setState(() {
                _currentPosition = value;
              });
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
        ],
      ),
    );
  }
}