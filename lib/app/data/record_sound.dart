import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

class RecordSound{

  Codec _codec = Codec.aacMP4;
   String _mPath = 'tau_file.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  RxString _recordedAudioPath="".obs;
  String get recordedAudioPath=>_recordedAudioPath.value;
   set recordedAudioPath(String str)=>_recordedAudioPath.value=str;

  factory RecordSound(){
    return RecordSound._();
  }
   RecordSound._() {
    _mPlayer!.openAudioSession().then((value) {
        _mPlayerIsInited = true;

    });

    openTheRecorder().then((value) {
        _mRecorderIsInited = true;
      });
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openAudioSession();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    _mRecorderIsInited = true;
  }

  void dispose() {
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    _mRecorder!.closeAudioSession();
    _mRecorder = null;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record(String path) {
    _mRecorder!
        .startRecorder(
      toFile: path,
      codec: _codec,
      audioSource: AudioSource.microphone,
    )
        .then((value) {});
  }

   stopRecorder() async {
   return await _mRecorder!.stopRecorder().then((value) {
    // prin
      recordedAudioPath=value!;
      _mplaybackReady = true;
      return value;
    });
  }

  void play(String path) {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
        fromURI: path,
        //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {})
        .then((value) {});
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
    });
  }

// ----------------------------- UI --------------------------------------------

  getRecorderFn({required String path}) {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return ;
    }
     _mRecorder!.isStopped ? record(path) : stopRecorder();
  }

  getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }
  void closeRecord() {
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    _mRecorder!.closeAudioSession();
    _mRecorder = null;
  }
}
