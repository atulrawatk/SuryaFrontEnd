import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/global_widgets/contact_circle_avatar.dart';
import 'package:surya/app/global_widgets/selected_contact_circle_avatar.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';

class GroupContactListTile extends StatelessWidget {
  final String title;
  final Widget subTitle;
  final Widget circleAvatar;
  final Widget customWidget;
  final bool isOnTap;
  final VoidCallback onTap;
  final void Function() onLongPress;
  const GroupContactListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.circleAvatar,
    required this.customWidget,
    required this.isOnTap,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.left,
        style: AppTextStyle.multiChatName(),
      ),
      subtitle: subTitle,
      leading: circleAvatar,
      trailing: customWidget,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
