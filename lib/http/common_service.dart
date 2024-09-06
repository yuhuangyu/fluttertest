// Project imports:
// import 'package:jd_mall_flutter/config/env_config.dart';
// import 'package:jd_mall_flutter/config/global_configs.dart';
// import 'package:jd_mall_flutter/http/http.dart';
// import 'package:jd_mall_flutter/models/goods_page_info.dart';

import '../util/env_config.dart';
import '../util/global_configs.dart';
import 'http.dart';

class CommonServiceApi {
  static Future queryGoodsListByPage(String code, int currentPage, int pageSize) async {
    var res = await httpManager.post(
      '${GlobalConfigs().get(EnvEnum.host.value)}/common/queryGoodsListByPage',
      params: {"code": code, "currentPage": currentPage, "pageSize": pageSize},
    );
    if (res.code != '0') {
      return null;
    }
    // return GoodsPageInfo.fromJson(res.data ?? {});
    return res.data;
  }
}