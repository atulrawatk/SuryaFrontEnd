import 'package:surya/app/utils/strings.dart';

class AppLists {
  static const List<String> choices = <String>[
    AppStrings.newGroup,
    // broadcast,
    // Messages,
    AppStrings.settings
  ];
  static final List<String> chatMenu = <String>[
    AppStrings.viewContact,
    AppStrings.mediaLinksAndDocs,
    AppStrings.search,
    AppStrings.muteNotifications,
    AppStrings.wallpaper,
    AppStrings.block,
  ];
  static final List<String> chatAttachFileMenu = <String>[
    AppStrings.document,
    AppStrings.camera,
    AppStrings.audio,
    AppStrings.payment,
    AppStrings.location,
    AppStrings.contact,
  ];
  static final List<String> choicesForContacts = <String>[
    AppStrings.inviteAFriend,
    AppStrings.contacts,
    AppStrings.refresh,
    AppStrings.settings.trim(),
    AppStrings.help,
  ];

  static final List<String> contactsName = <String>[
    "Sangam",
    "Gaurav",
    "Tushar",
    "Rohit"
  ];

  static List<String> groupParticipants = <String>[
    "delete",
    // broadcast,
    // Messages,
    AppStrings.block,
  ];
}
