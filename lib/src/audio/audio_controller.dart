import 'dart:collection';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart' hide Logger;
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../settings/settings.dart';
import 'songs.dart';
import 'sounds.dart';
class AudioController {
  static final _log = Logger('AudioController');
  late AudioCache _musicCache;
  late AudioCache _sfxCache;
  final AudioPlayer _musicPlayer;
  final List<AudioPlayer> _sfxPlayers;
  int _currentSfxPlayer = 0;
  final Queue<Song> _playlist;
  final Random _random = Random();
  SettingsController? _settings;
  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;
  AudioController({int polyphony = 2})
      : assert(polyphony >= 1),
        _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
        _sfxPlayers = Iterable.generate(
            polyphony,
            (i) => AudioPlayer(
                playerId: 'sfxPlayer#$i',
                mode: PlayerMode.LOW_LATENCY)).toList(growable: false),
        _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
    _musicCache = AudioCache(
      fixedPlayer: _musicPlayer,
      prefix: 'assets/music/',
    );
    _sfxCache = AudioCache(
      fixedPlayer: _sfxPlayers.first,
      prefix: 'assets/sfx/',
    );
    _musicPlayer.onPlayerCompletion.listen(_changeSong);
  }
  void attachLifecycleNotifier(
      ValueNotifier<AppLifecycleState> lifecycleNotifier) {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    lifecycleNotifier.addListener(_handleAppLifecycle);
    _lifecycleNotifier = lifecycleNotifier;
  }
  void attachSettings(SettingsController settingsController) {
    if (_settings == settingsController) {
      return;
    }
    final oldSettings = _settings;
    if (oldSettings != null) {
      oldSettings.muted.removeListener(_mutedHandler);
      oldSettings.musicOn.removeListener(_musicOnHandler);
      oldSettings.soundsOn.removeListener(_soundsOnHandler);
    }
    _settings = settingsController;
    settingsController.muted.addListener(_mutedHandler);
    settingsController.musicOn.addListener(_musicOnHandler);
    settingsController.soundsOn.addListener(_soundsOnHandler);
    if (!settingsController.muted.value && settingsController.musicOn.value) {
      _startMusic();
    }
  }
  void dispose() {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    _stopAllSound();
    _musicPlayer.dispose();
    for (final player in _sfxPlayers) {
      player.dispose();
    }
  }
  Future<void> initialize() async {
    _log.info('Preloading sound effects');
    await _sfxCache
        .loadAll(SfxType.values.expand(soundTypeToFilename).toList());
  }
  void playSfx(SfxType type) {
    final muted = _settings?.muted.value ?? true;
    if (muted) {
      _log.info(() => 'Ignoring playing sound ($type) because audio is muted.');
      return;
    }
    final soundsOn = _settings?.soundsOn.value ?? false;
    if (!soundsOn) {
      _log.info(() =>
          'Ignoring playing sound ($type) because sounds are turned off.');
      return;
    }
    _log.info(() => 'Playing sound: $type');
    final options = soundTypeToFilename(type);
    final filename = options[_random.nextInt(options.length)];
    _log.info(() => '- Chosen filename: $filename');
    _sfxCache.play(filename, volume: soundTypeToVolume(type));
    _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
    _sfxCache.fixedPlayer = _sfxPlayers[_currentSfxPlayer];
  }
  void _changeSong(void _) {
    _log.info('Last song finished playing.');
    _playlist.addLast(_playlist.removeFirst());
    _log.info(() => 'Playing ${_playlist.first} now.');
    _musicCache.play(_playlist.first.filename);
  }
  void _handleAppLifecycle() {
    switch (_lifecycleNotifier!.value) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _stopAllSound();
        break;
      case AppLifecycleState.resumed:
        if (!_settings!.muted.value && _settings!.musicOn.value) {
          _resumeMusic();
        }
        break;
      case AppLifecycleState.inactive:
        break;
    }
  }
  void _musicOnHandler() {
    if (_settings!.musicOn.value) {
      if (!_settings!.muted.value) {
        _resumeMusic();
      }
    } else {
      _stopMusic();
    }
  }
  void _mutedHandler() {
    if (_settings!.muted.value) {
      _stopAllSound();
    } else {
      if (_settings!.musicOn.value) {
        _resumeMusic();
      }
    }
  }
  Future<void> _resumeMusic() async {
    _log.info('Resuming music');
    switch (_musicPlayer.state) {
      case PlayerState.PAUSED:
        _log.info('Calling _musicPlayer.resume()');
        try {
          await _musicPlayer.resume();
        } catch (e) {
          _log.severe(e);
          await _musicCache.play(_playlist.first.filename);
        }
        break;
      case PlayerState.STOPPED:
        _log.info("resumeMusic() called when music is stopped. "
            "This probably means we haven't yet started the music. "
            "For example, the game was started with sound off.");
        await _musicCache.play(_playlist.first.filename);
        break;
      case PlayerState.PLAYING:
        _log.warning('resumeMusic() called when music is playing. '
            'Nothing to do.');
        break;
      case PlayerState.COMPLETED:
        _log.warning('resumeMusic() called when music is completed. '
            "Music should never be 'completed' as it's either not playing "
            "or looping forever.");
        await _musicCache.play(_playlist.first.filename);
        break;
    }
  }
  void _soundsOnHandler() {
    for (final player in _sfxPlayers) {
      if (player.state == PlayerState.PLAYING) {
        player.stop();
      }
    }
  }
  void _startMusic() {
    _log.info('starting music');
    _musicCache.play(_playlist.first.filename);
  }
  void _stopAllSound() {
    if (_musicPlayer.state == PlayerState.PLAYING) {
      _musicPlayer.pause();
    }
    for (final player in _sfxPlayers) {
      player.stop();
    }
  }
  void _stopMusic() {
    _log.info('Stopping music');
    if (_musicPlayer.state == PlayerState.PLAYING) {
      _musicPlayer.pause();
    }
  }
}
