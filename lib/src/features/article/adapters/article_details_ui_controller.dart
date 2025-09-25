import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart' show AudioPlayer;
import 'package:siloe/src/core/logs/custom_logger.dart';
import 'package:siloe/src/core/api/api_resources.dart' show ApiResources;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/enums/content_type.dart';
import '../../../di/controllers_provider.dart' show ControllersProvider;
import '../../publication/domain/entities/entity_publication.dart'
    show EntityPublication;
import 'article_datas.dart';

class ArticleDetailsUIController extends GetxController {
  final isFullscreen = false.obs;

  Rx<EntityPublication?> article = Rx<EntityPublication?>(null);
  void initArticle(EntityPublication? article) {
    this.article.value = article;
    update();
  }

  void updateArticle(EntityPublication? article) {
    this.article.value = article;
    update();
  }

  void initArticleByArgs() async {
    initArticle(Get.arguments?[ArticleDatas.articleArg] as EntityPublication?);
    update();

    if (article.value?.typePublicationId == null) return;
    final type = await ControllersProvider.PUBLICATION_TYPE_CONTROLLER
        .getPublicationTypeById(id: article.value!.typePublicationId!);
    if (type?.typePublication == null) return;
    final contentType = ContentType.fromString(type!.typePublication!);
    changeContentType(contentType);
  }

  Rx<YoutubePlayerController?> youtubeController =
      Rx<YoutubePlayerController?>(null);
  void initVideoController(String initialVideoId) {
    if (youtubeController.value != null) {
      youtubeController.value?.dispose();
      youtubeController.value = null; // d1H8W7kcLvw
      update();
    }

    if (initialVideoId.isEmpty) {
      AppLogger.instance.logger
          .e("Video ID vide, impossible d'initialiser le controller");
      update();
      return;
    }

    youtubeController.value = YoutubePlayerController(
      initialVideoId: initialVideoId,
      flags: const YoutubePlayerFlags(
          autoPlay: true, controlsVisibleAtStart: true, showLiveFullscreenButton: false,),
    );

    AppLogger.instance.logger
        .i("YoutubeController initialisé avec videoId = $initialVideoId");

    update();
  }

  Rx<String?> videoUrl = Rx<String?>(null);
  Rx<String?> videoId = Rx<String?>(null);
  void initYoutubeVideoUrl(String url) {
    videoUrl = Rx<String?>(url);
    update();
  }

  void initYoutubeVideoId() {
    if (videoUrl.value == null) return;
    videoId.value = YoutubePlayer.convertUrlToId(videoUrl.value!);
    update();
  }

  Rx<ContentType?> currentContentType = Rx(null);
  void changeContentType(ContentType contentType) {
    currentContentType.value = contentType;
    update();
  }

  String getArticleUrl() {
    AppLogger.instance.logger.i("Article: ${article.value}");
    return article.value?.url ?? '';
  }

  String getAudioFileUrl() {
    final String? url = article.value?.url;
    final String resolved = _normalizeMediaUrl(url);
    AppLogger.instance.logger
        .i("Resolved audio url: $resolved (url: $url)");
    return resolved;
  }

  String _normalizeMediaUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    final base = ApiResources.baseUrl;
    if (path.startsWith('/')) {
      return '$base$path';
    }
    return '$base/$path';
  }

  void initYoutubeVideo() {
    if (currentContentType.value != ContentType.video) return;
    final url = getArticleUrl();
    AppLogger.instance.logger.i("Url video: $url");
    initYoutubeVideoUrl(url);
    initYoutubeVideoId();
    // if(videoId.value == null) return;
    initVideoController(videoId.value!);

    update();
  }

Future<String?> _resolvePcloudAudioUrl(String rawUrl) async {
  try {
    // 🔹 Si c'est déjà un lien direct (ex: .mp3, .m4a, etc.)
    if (rawUrl.endsWith(".mp3") || rawUrl.endsWith(".m4a")) {
      return rawUrl;
    }

    // 🔹 Si c'est un lien public pCloud => on utilise l’API getpubaudiolink
    if (rawUrl.contains("pcloud.com/publink")) {
      final uri = Uri.https("api.pcloud.com", "/getpubaudiolink", {
        "link": rawUrl,
      });

      final resp = await http.get(uri);
      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        if (body["result"] == 0) {
          final hosts = List<String>.from(body["hosts"]);
          final path = body["path"];
          return "https://${hosts.first}$path";
        }
      }
    }

    // Sinon retourne brut
    return rawUrl;
  } catch (e) {
    AppLogger.instance.logger.e("Erreur _resolvePcloudAudioUrl: $e");
    return null;
  }
}

  final audioPlayer = AudioPlayer();
  // Position actuelle de lecture
  Rx<Duration> audioPosition = Duration.zero.obs;
  // Durée totale du fichier audio
  Rx<Duration> audioDuration = Duration.zero.obs;
  // Position de buffering
  Rx<Duration> bufferedPosition = Duration.zero.obs;
  // Url réactive
  Rx<String?> audioUrl = Rx<String?>(null);
  // Etat playback (play/pause)
  RxBool isPlaying = false.obs;

  // Initialiser l'url audio et charger la durée
  void initAudioUrl(String url) async {
    AppLogger.instance.logger.i("Init audio url: $url");
    audioUrl.value = url;
    // Charger le fichier audio
    final duration =
        audioUrl.value == null ? null : await audioPlayer.setUrl(url);
    if (duration != null) {
      audioDuration.value = duration;
    }
    // Ecouter les événements de position de lecture
    audioPlayer.positionStream.listen((position) {
      audioPosition.value = position;
    });
    // Ecouter l'état play/pause
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    // Ecouter la position du buffer pour mettre à jour bufferedPosition
    audioPlayer.bufferedPositionStream.listen((bufferedPos) {
      bufferedPosition.value = bufferedPos;
    });
  }

  // Toggle play / pause
  void togglePlayPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void avancer10Secondes() {
    final newPosition = audioPlayer.position + Duration(seconds: 10);
    final duration = audioDuration.value;
    audioPlayer.seek(newPosition > duration ? duration : newPosition);
  }

  void reculer10Secondes() {
    final newPosition = audioPlayer.position - Duration(seconds: 10);
    audioPlayer.seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void addVolume() {
    final newVolume = audioPlayer.volume + 0.1;
    audioPlayer.setVolume(newVolume > 1.0 ? 1.0 : newVolume);
  }

  void initAudio() async {
    if (currentContentType.value != ContentType.audio) return;
    final rawUrl = getAudioFileUrl();
    final resolvedUrl = await _resolvePcloudAudioUrl(rawUrl);
    if (resolvedUrl != null) {
      initAudioUrl(resolvedUrl);
    } else {
      AppLogger.instance.logger.e("Impossible de résoudre le lien audio");
    }

    audioPlayer.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace st) {
        AppLogger.instance.logger.e("Erreur lecture audio: $e");
      },
    );
  }
}
