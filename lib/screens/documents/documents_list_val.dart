import 'package:dmb_timer_3/screens/documents/documents_string.dart';

class ListDocumentsRaportItem {
  String name;
  String val;

  ListDocumentsRaportItem({this.name, this.val});
}

final List<ListDocumentsRaportItem> listDocumentsRaportItems = [
  ListDocumentsRaportItem(
      name: 'РАПОРТ НА \nЩОРІЧНУ \nВІДПУСТКУ',
      val: 'assets/images/raports/raport_vidpustka_shorichna.png'),
  ListDocumentsRaportItem(
      name: 'РАПОРТ НА \nОЗДОРОВЧІ',
      val: 'assets/images/raports/raport_ozdorovchi.png'),
  ListDocumentsRaportItem(
      name: 'РАПОРТ НА \nПІДЙОМНУ \nДОПОМОГУ',
      val: 'assets/images/raports/raport_pidyomni.png'),
  ListDocumentsRaportItem(
      name: 'РАПОРТ НА \nНЕДООТРИМАНЕ \nРЕЧОВЕ  МАЙНО',
      val: 'assets/images/raports/mayno.png'),
  ListDocumentsRaportItem(
      name: 'РАПОРТ \nКОМПЕНСАЦІЯ \nЗА \nНЕВИКОРИСТАНУ \nВІДПУСТКУ',
      val: 'assets/images/raports/nevykorystana_vidpustka.png')
];

final List<ListDocumentsRaportItem> listDocumentsOboviazkyItems = [
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ \nДНЮВАЛЬНОГО \nРОТИ', val: textOboviazkyDnuvalnogo),
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ \nЧЕРГОВОГО \nРОТИ', val: textOboviazkuChergovogo),
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ \nЧЕРГОВОГО \nЧАСТИНИ',
      val: textOboviazkyChergovogoChastyny),
  ListDocumentsRaportItem(name: 'ДОБОВИЙ \nНАРЯД', val: textDobovyiNariad),
];

final List<ListDocumentsRaportItem> listDocumentsInsheItems = [
  ListDocumentsRaportItem(
      name: 'ЗАБЕЗПЕЧЕННЯ \nВІЙСЬКОВОГО', val: textZabezpechennya),
  ListDocumentsRaportItem(
      name: 'ПРАВА \nВІЙСЬКОВОГО', val: pravaViskovosluzbovciv),
  ListDocumentsRaportItem(
      name: 'ПРО\nВІЙСЬКОВУ\nВВІЧЛИВІСТЬ І\nПОВЕДІНКУ',
      val: textProViskovuVichlivist),
  ListDocumentsRaportItem(name: 'КОНТРАКТ', val: textKontrakt)
];

final List<ListDocumentsRaportItem> listDocumentsOboviazkyZagalni = [
  ListDocumentsRaportItem(
      name: 'ЗАГАЛЬНІ\nОБОВ\'ЯЗКИ\nВІЙСЬКОВО-\nСЛУЖБОВЦІВ',
      val: zagalniOboviazky),
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ\nРЯДОВОГО\n(МАТРОСА)', val: oboviazkyRiadovogo),
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ\nКОМАНДИРА\nВІДДІЛЕННЯ',
      val: oboviazkyKomandyrViddilenya),
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ\nКОМАНДИРА\nВЗВОДУ', val: oboviazkyKomandyraVzvodu),
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ\nЗАСТУПНИКА\nКОМАНДИРА\nРОТИ З\nОЗБРОЄННЯ',
      val: oboviazkyZastupnykKomandyraRotyZOzbroennya),
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ\nЗАСТУПНИКА\nКОМАНДИРА\nРОТИ',
      val: zastupnykKomandyraRoty),
  ListDocumentsRaportItem(
      name: 'ОБОВ\'ЯЗКИ\nКОМАНДИРА\nРОТИ', val: komandyrRoty),
];
