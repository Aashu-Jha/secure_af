import 'package:flutter/material.dart';
import 'package:secure_af/helpers/db_helper.dart';
import 'package:secure_af/models/pass_card.dart';

class PassCardList with ChangeNotifier{
  List<PassCard> _cardList = [];

  List<PassCard> get cardList {
    return [..._cardList];
  }


  void addCard(PassCard passCard) {
    final newCard = PassCard(id: DateTime.now().toString(), title: passCard.title, accountID: passCard.accountID, username: passCard.username, password: passCard.password, website: passCard.website, notes: passCard.notes, other: passCard.other);
    _cardList.add(newCard);
    notifyListeners();
    DBHelper.insert({
      'id' : newCard.id,
      'title': newCard.title,
      'accountID': newCard.accountID,
      'username': newCard.username,
      'password': newCard.password,
      'website': newCard.website,
      'notes': newCard.notes,
      'other': newCard.other,
    });
  }

  Future<void> getCard() async {
    final dataList = await DBHelper.getData();
    _cardList = dataList.map((item) => PassCard(
      id: item['id'],
      title: item['title'],
      accountID: item['accountID'],
      username: item['username'],
      password: item['password'],
      website: item['website'],
      notes: item['notes'],
      other: item['other']
    )).toList();
    notifyListeners();
  }

  void deleteCard(String id) {
    int idx = _cardList.indexWhere((element) => element.id == id);
    DBHelper.delete(id);
    _cardList.removeAt(idx);
    notifyListeners();
  }

  /*Future<void> findByIdx(int idx) async {
    String id = _cardList[idx].id;
    final dataList = await DBHelper.getSingleData(id);
    _cardList = dataList.map((item) => PassCard(
        id: item['id'],
        title: item['title'],
        accountID: item['accountID'],
        username: item['username'],
        password: item['password'],
        website: item['website'],
        notes: item['notes'],
        other: item['other']
    )).toList();
    notifyListeners();
  }*/

  PassCard findByID(String id) {
    return _cardList.firstWhere((element) => element.id == id);
  }
}