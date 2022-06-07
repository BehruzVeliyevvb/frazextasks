import 'dart:ui';
import 'package:flutter/material.dart';
import '../l10n/l10n.dart';
import '../models/post.dart';

class DataProvider extends ChangeNotifier {
  /// Language
  String languageCode = window.locale.languageCode;
  set setLangCode(String langCode) {
    if (!L10n.all.contains(Locale(langCode))) return;
    languageCode = langCode;
    notifyListeners();
  }

  String get getLangCode => languageCode;

  /// Api
  bool _isPostsFetching = true;

  List<Post> _postsList = [];

  bool get isHomePageProcessing => _isPostsFetching;

  setIsPostsFetching(bool value) {
    _isPostsFetching = value;
    notifyListeners();
  }

  List<Post> get postsList => _postsList;

  setPostsList(List<Post> list, {bool notify = true}) {
    _postsList = list;
    if (notify) notifyListeners();
  }

  addPost(Post post, {bool notify = true}) {
    _postsList.add(post);
    if (notify) notifyListeners();
  }

  Post getPostByIndex(int index) => _postsList[index];

  int get postsListLength => _postsList.length;
}
