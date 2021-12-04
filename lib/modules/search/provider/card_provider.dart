import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/utils/helpers/check_internet.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/toast_maker.dart';

enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  List<SwipeUser> _swipeUsers = [];

  List<SwipeUser> get swipeUsers => _swipeUsers;
  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  CardProvider() {
    // resetUsers();
    resetSwipeCards();
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;

    notifyListeners();

    final status = getStatus(force: true);

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        superLike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  double getStatusOpacity() {
    const delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;
    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;

    if (force) {
      const delta = 100;

      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= -delta / 2 && forceSuperLike) {
        return CardStatus.superLike;
      }
    } else {
      const delta = 20;

      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= -delta * 2 && forceSuperLike) {
        return CardStatus.superLike;
      }
    }
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width / 2, 0);
    _nextCard();

    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void superLike() {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    if (_swipeUsers.isEmpty) return;

    await Future.delayed(
      const Duration(
        milliseconds: 200,
      ),
    );
    _swipeUsers.removeLast();
    resetPosition();
  }

  void resetUsers() {
    _urlImages = <String>[
      'https://images.unsplash.com/photo-1516522973472-f009f23bba59?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1525786210598-d527194d3e9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/flagged/photo-1556138740-9ea22b0db0f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1617251997846-b6139ae96682?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1574163959954-b9adbc5a6aea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      'https://images.unsplash.com/photo-1516522973472-f009f23bba59?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    ].toList();

    notifyListeners();
  }

  void resetSwipeCards() async {
    bool internetConnected = await CheckInternet().checkInternet();

    if (internetConnected != true) {
      return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
    }

    try {
      Response response = await CallApi().getData(getNearbyUserRoute);
      Map<String, dynamic> responseBody = response.data;

      if ((responseBody['success'] != null) &&
          (responseBody['success'] == true)) {
        var swipeList = response.data['data'] as List;
        _swipeUsers =
            swipeList.map((tagJson) => SwipeUser.fromJson(tagJson)).toList();
      }
    } catch (e) {
      ToastMaker().simpleErrorToast(defaultErrorMsg);
    }

    notifyListeners();
  }
}
