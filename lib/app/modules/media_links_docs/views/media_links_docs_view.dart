import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';
import 'package:surya/app/utils/utils.dart';

import '../controllers/media_links_docs_controller.dart';

class MediaLinksDocsView extends GetView<MediaLinksDocsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IosBackButton(),
        title: Text(controller.model.name!.value,style: AppTextStyle.mainPageHeading(),),
      ),
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}
