import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdemo/util/Global.dart';
import 'package:flutterdemo/util/env_config.dart' as configs;
import 'package:flutterdemo/util/global_configs.dart';
import 'package:get/get.dart';
import 'MyApp.dart';

void main() {
  initApp(configs.prd);
}

void initApp(Map<String, dynamic> envMap) async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalConfigs().loadFromMap(envMap);
  await Global.initPreferences();

  runApp(const MyApp());

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

void test() async{
  sleep(new Duration(seconds: 1));
  Future.delayed(new Duration(seconds: 1),(){

  });
  new Future.value(3).then((value) => {});
  new Future(() => {}).then((value) => {});


  Stream<int> stream = Stream<int>.periodic(new Duration(seconds: 1), callback);
  await for(var i in stream){
    print(i);
  }
  stream.forEach((element) {
    print(element);
  });
  stream.listen(
    (event) {
      print(event);
    },
    onError: (e) {},
    onDone: (){}
  );

  stream = stream.take(5);
  // 表示从Stream中跳过两个元素
  stream = stream.skip(2);
  await for(var i in stream){
    print(i);
    /*
    * 2
    * 3
    * 4
    * */
  }
  List <int> data = await stream.toList();
  var length = stream.length;


  // 创建
  StreamController streamController = StreamController();
  // 放入事件
  streamController.add('element_1');
  streamController.addError("this is error");
  streamController.sink.add('element_2');
  streamController.stream.listen(
      print,
      onError: print,
      onDone: ()=>print("onDone"));

  StreamController sc = StreamController();
  // 将 Stream 传入
  sc.addStream(stream);
  // 监听
  sc.stream.listen(
      print,
      onDone: ()=>print("onDone"));

  Stream<int> stream2 = Stream<int>.periodic(Duration(seconds: 1), (e)=>e);
  stream2 = stream2.take(5);

  stream2.listen(print);


  var streamTransformer = StreamTransformer<int, double>.fromHandlers(
    handleData: (int data, EventSink<double> sink){
      sink.add((data*2).toDouble());
    },
    handleError: (error, stacktrace, sink){},
    handleDone: (sink){}
  );
  StreamController sc2 = StreamController<int>();
  Stream transform = sc2.stream.transform(streamTransformer);
  transform.listen((event) {
    print(event);
    /*
    * 2
    * 4
    * 6
    * */
  });
  sc2.add(1);
  sc2.add(2);
  sc2.add(3);

}
int callback(int i) {
  return i;
}
test2() async{

  // 创建文件
  File file = new File('test.txt');
  String content = 'The easiest way to write text to a file is to create a File';

  try {
    // 向文件写入字符串
    await file.writeAsString(content);
    print('Data written.');
  } catch (e) {
    print(e);
  }


  //读文件
  try{
    String content = await file.readAsString();
    print(content);
  }catch(e){
    print(e);
  }

  // 获取当前的Locale
  // Locale myLocale = Localizations.localeOf(context);


  var locale = const Locale('en', 'US');
  var locale2 = const Locale('zh', 'CN');
  await Get.updateLocale(locale);


}

