import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Router {
  static const homePage = 'app://';

  Widget _getPage(String url, dynamic params) {
    switch (url) {
      // case detailPage:
      //   return DetailPage(params);
      // case homePage:
      //   return ContainerPage();
      // case playListPage:
      //   return VideoPlayPage(params);
      // case searchPage:
      //   return SearchPage(searchHintContent: params);
      // case photoHero:
      //   return PhotoHeroPage(
      //       photoUrl: params['photoUrl'], width: params['width']);
      // case personDetailPage:
      //   return PersonDetailPage(params['personImgUrl'], params['id']);
    }
    return null;
  }

  Router.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
