import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:retailmi/presentation/presenter/media_video_page_presenter.dart';

class MediaVideoViewController extends Controller{
  bool isLoading;

  MediaVideoPagePresenter _presenter;

  MediaVideoViewController() : _presenter = MediaVideoPagePresenter();

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  Future<void> counterInactivity(){

  }

}