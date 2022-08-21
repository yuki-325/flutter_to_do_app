import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

///
/// Theme設定用のServiceクラス
///
class ThemeService {
  final _key = 'isDarkMode';
  final _box = GetStorage();

  ///
  /// ダークモードorライトモードをストレージに保存するメソッド
  ///
  void saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  ///
  /// ストレージからダークモードorライトモードを読み込むメソッド
  ///
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ///
  /// 現在のモード(ダークモードorライトモード)を取得するメソッド
  ///
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  ///
  /// ダークモードorライトモードを切り替えるメソッド
  ///
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!_loadThemeFromBox());
  }
}
