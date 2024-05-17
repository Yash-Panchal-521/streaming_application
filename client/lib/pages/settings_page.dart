import 'package:client/api/get_channel_settings.dart';
import 'package:client/theme/theme.dart';
import 'package:client/utils/avatar_url_validator.dart';
import 'package:client/utils/build_text_field.dart';
import 'package:client/utils/description_validator.dart';
import 'package:client/utils/password_validator.dart';
import 'package:client/utils/username_validator.dart';
import 'package:client/widgets/custom_appbar.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:client/widgets/side_navbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> followedChannels = [
    {"username": "Channel 1", "id": 1, "isOnline": false},
    {"username": "Channel 2", "id": 2, "isOnline": true},
    {"username": "Channel 3", "id": 3, "isOnline": false}
  ];

  Map<String, dynamic> channelSettings = {
    "title": "Title",
    "description": "Description",
    "avatarUrl": "none",
    "username": "username",
    "streamKey": "1234567890",
  };
  TextEditingController usernameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController avatarUrlController = TextEditingController();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool newPasswordVisible = false;

  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    usernameController.text = channelSettings["username"];
    titleController.text = channelSettings["title"];
    descriptionController.text = channelSettings["description"];
    avatarUrlController.text = channelSettings["avatarUrl"];
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
        appBar: customAppBar(context, "Settings"),
        body: Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(flex: 1, fit: FlexFit.tight, child: SideNavBar(followedChannels: followedChannels)),
            Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                    alignment: Alignment.center,
                    child: Text(
                      "Channel Settings",
                      style: textTheme.headlineMedium!.copyWith(color: colors.primary),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(child: Text("Username", style: textTheme.bodyMedium!)),
                              Expanded(
                                child: buildTextField(
                                  hintText: "Username",
                                  controller: usernameController,
                                  validator: validateUsername,
                                  colors: colors,
                                  textTheme: textTheme,
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(child: Text("Title", style: textTheme.bodyMedium!)),
                              Expanded(
                                child: buildTextField(
                                  hintText: "Title",
                                  controller: titleController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Title cannot be empty";
                                    }
                                    return null;
                                  },
                                  colors: colors,
                                  textTheme: textTheme,
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(child: Text("Avatar URL", style: textTheme.bodyMedium!)),
                              Expanded(
                                child: buildTextField(
                                  hintText: "Avatar URL",
                                  controller: avatarUrlController,
                                  validator: validateAvatarUrl,
                                  colors: colors,
                                  textTheme: textTheme,
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(child: Text("Description", style: textTheme.bodyMedium!)),
                              Expanded(
                                child: buildTextField(
                                  hintText: "Description",
                                  controller: descriptionController,
                                  validator: validateDescription,
                                  colors: colors,
                                  textTheme: textTheme,
                                  isTextArea: true,
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppTheme.smallPadding,
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                flex: 2,
                                child: primaryElevatedButtonWidget(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        channelSettings["username"] = usernameController.text;
                                        channelSettings["title"] = titleController.text;
                                        channelSettings["description"] = descriptionController.text;
                                        channelSettings["avatarUrl"] = avatarUrlController.text;
                                      });
                                    }
                                  },
                                  label: "Save Chnages",
                                  colors: colors,
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppTheme.smallPadding),
                          child: Divider(color: colors.scrim.withOpacity(0.5)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                          alignment: Alignment.center,
                          child: Text(
                            "Change Password",
                            style: textTheme.headlineMedium!.copyWith(color: colors.primary),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(child: Text("Current Password", style: textTheme.bodyMedium!)),
                              Expanded(
                                child: buildTextField(
                                  hintText: "Current Password",
                                  controller: currentPasswordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be empty";
                                    }
                                    return null;
                                  },
                                  colors: colors,
                                  textTheme: textTheme,
                                  isPassword: true,
                                  passwordVisible: passwordVisible,
                                  onVisibiltyToggled: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(child: Text("New Password", style: textTheme.bodyMedium!)),
                              Expanded(
                                child: buildTextField(
                                  hintText: "New Password",
                                  controller: newPasswordController,
                                  validator: validatePassword,
                                  colors: colors,
                                  textTheme: textTheme,
                                  isPassword: true,
                                  passwordVisible: newPasswordVisible,
                                  onVisibiltyToggled: () {
                                    setState(() {
                                      newPasswordVisible = !newPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppTheme.smallPadding,
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                flex: 2,
                                child: primaryElevatedButtonWidget(
                                  onPressed: () {
                                    if (changePasswordFormKey.currentState!.validate()) {
                                      // Change password logic
                                    }
                                  },
                                  label: "Change Password",
                                  colors: colors,
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.smallPadding),
                    child: Divider(color: colors.scrim.withOpacity(0.5)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: AppTheme.smallPadding),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(child: Text("Stream Key", style: textTheme.bodyMedium!)),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.scrim.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.mediumBorderRadius),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(AppTheme.smallPadding),
                              child: Align(alignment: Alignment.centerLeft, child: Text("${channelSettings["streamKey"]}")),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
