import 'package:get/get.dart';

import '../controllers/media_links_docs_controller.dart';

class MediaLinksDocsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediaLinksDocsController>(
      () => MediaLinksDocsController(),
    );
  }
}
