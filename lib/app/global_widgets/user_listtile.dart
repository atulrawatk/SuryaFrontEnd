import 'package:flutter/material.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';

class UserListTile extends StatelessWidget {
  final String title;
  final Widget subTitle;
  final String imageUrl;
  final Widget customWidget;
  final bool isOnTap;
  final VoidCallback onTap;
  const UserListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.customWidget,
    required this.isOnTap,
    required this.onTap,
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
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(
          imageUrl,
        ),
      ),
      trailing: customWidget,
      onTap: () {},
    );
  }
}
