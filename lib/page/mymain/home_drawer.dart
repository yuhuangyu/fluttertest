import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/common/style/gsy_style.dart';
import 'package:flutterdemo/common/view/gsy_flex_button.dart';
import 'package:flutterdemo/util/utils/CommonListDataType.dart';
import 'package:flutterdemo/util/utils/common_utils.dart';
import 'package:flutterdemo/util/utils/navigator_utils.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 主页drawer
/// Created by guoshuyu
/// Date: 2018-07-18
class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  showAboutDialog(BuildContext context, String? versionName) {
    versionName ??= "Null";
    NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) => AboutDialog(
              applicationName: "appname".tr,
              applicationVersion:
                  "${"test".tr}: ${versionName ?? ""}",
              applicationIcon: const Image(
                  image: AssetImage(GSYICons.DEFAULT_USER_ICON),
                  width: 50.0,
                  height: 50.0),
              applicationLegalese: "http://github.com/CarGuo",
            ));
  }

  showThemeDialog(BuildContext context) {
    StringList list = [
      "test".tr,
      "test".tr,
      "test".tr,
      "test".tr,
      "test".tr,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      // CommonUtils.pushTheme(store, index);
      // LocalStorage.save(Config.THEME_COLOR, index.toString());
    }, colorList: CommonUtils.getThemeListColor());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(
        ///侧边栏按钮Drawer
        child: Container(
          ///默认背景
          color: GSYColors.primarySwatch,
          child: SingleChildScrollView(
            ///item 背景
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.sizeOf(context).height),
              child: Material(
                color: GSYColors.white,
                child: Column(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      //Material内置控件
                      accountName: Text(
                        // user.login ?? "---",
                        "---",
                        style: GSYConstant.largeTextWhite,
                      ),
                      accountEmail: Text(
                        // user.email ?? user.name ?? "---",
                        "---",
                        style: GSYConstant.normalTextLight,
                      ),
                      //用户名
                      //用户邮箱
                      currentAccountPicture: GestureDetector(
                        //用户头像
                        onTap: () {},
                        child: CircleAvatar(
                          //圆形图标控件
                          // backgroundImage: NetworkImage(user.avatar_url ?? GSYICons.DEFAULT_REMOTE_PIC),
                          backgroundImage: NetworkImage(GSYICons.DEFAULT_REMOTE_PIC),
                        ),
                      ),
                      decoration: BoxDecoration(
                        //用一个BoxDecoration装饰器提供背景图片
                        // color: store.state.themeData!.primaryColor,
                        color: GSYColors.primarySwatch,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "home_reply".tr,
                        style: GSYConstant.normalText,
                      ),
                      onTap: () {
                        String content = "";
                        CommonUtils.showEditDialog(
                          context,
                          "home_reply".tr,
                              (title) {},
                              (res) {
                            content = res;
                          },
                              () {
                            if (content.isEmpty) {
                              return;
                            }
                            CommonUtils.showLoadingDialog(context);
                            // IssueDao.createIssueDao(
                            //     "CarGuo", "gsy_github_app_flutter", {
                            //   "title": "home_reply".tr,
                            //   "body": content
                            // }).then((result) {
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            // });
                          },
                          titleController: TextEditingController(),
                          valueController: TextEditingController(),
                          needTitle: false,
                          hintText:
                          "feed_back_tip",
                        );
                      },
                    ),
                    ListTile(
                        title: Text(
                          "test".tr,
                          style: GSYConstant.normalText,
                        ),
                        onTap: () {
                          // NavigatorUtils.gotoCommonList(
                          //     context,
                          //     "test".tr,
                          //     "repositoryql",
                          //     CommonListDataType.history,
                          //     userName: "",
                          //     reposName: "");
                        }),
                    ListTile(
                        title: Hero(
                            tag: "home_user_info",
                            child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  "test".tr,
                                  style: GSYConstant.normalTextBold,
                                ))),
                        onTap: () {
                          // NavigatorUtils.gotoUserProfileInfo(context);
                        }),
                    ListTile(
                        title: Text(
                          "test".tr,
                          style: GSYConstant.normalText,
                        ),
                        onTap: () {
                          // showThemeDialog(context, store);
                          showThemeDialog(context);
                        }),
                    ListTile(
                        title: Text(
                          "test".tr,
                          style: GSYConstant.normalText,
                        ),
                        onTap: () {
                          CommonUtils.showLanguageDialog(context);
                        }),
                    ListTile(
                        title: Text(
                          "test".tr,
                          style: GSYConstant.normalText,
                        ),
                        onTap: () {
                          // CommonUtils.changeGrey(store);
                        }),
                    ListTile(
                        title: Text(
                          "test".tr,
                          style: GSYConstant.normalText,
                        ),
                        onTap: () {
                          // ReposDao.getNewsVersion(context, true);
                        }),
                    ListTile(
                        title: Text(
                          "test".tr,
                          style: GSYConstant.normalText,
                        ),
                        onLongPress: () {
                          // NavigatorUtils.goDebugDataPage(context);
                        },
                        onTap: () {
                          PackageInfo.fromPlatform().then((value) {
                            if (kDebugMode) {
                              print(value);
                            }
                            if(!context.mounted)return;
                            showAboutDialog(context, value.version);
                          });
                        }),
                    ListTile(
                        title: GSYFlexButton(
                          text: "test".tr,
                          color: Colors.redAccent,
                          textColor: GSYColors.textWhite,
                          onPress: () {
                            // store.dispatch(LogoutAction(context));
                          },
                        ),
                        onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
