import 'package:flutterdemo/page/category/been/category_list_entity.dart';
import '../page/category/been/second_group_category_info.dart';
import 'http.dart';
import '../util/env_config.dart';
import '../util/global_configs.dart';
import '../page/home/been/home_page_info.dart';

class HApi {
  static Future queryHomeInfo() async {
    var res = await httpManager.get('${GlobalConfigs().get(EnvEnum.host.value)}/home/queryHomePageInfo');
    if (res.code != '0') {
      return null;
    }
    return HomePageInfo.fromJson(res.data ?? {});
  }

  static Future queryCategoryInfo() async {
    var res = await httpManager.get('${GlobalConfigs().get(EnvEnum.host.value)}/category/list');
    if (res.code != '0') {
      return null;
    }
    return CategoryListEntity.fromJson(res.data ?? {});
  }

  static querySecondGroupCategoryInfo(String categoryId) async {
    var res = await httpManager.post('${GlobalConfigs().get(EnvEnum.host.value)}/category/queryContentByCategory', params: {"categoryId": categoryId});
    if (res.code != '0') {
      return null;
    }
    return SecondGroupCategoryInfo.fromJson(res.data ?? {});
  }
}
