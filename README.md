# Flutter Laundry POS System

## Description

This app made for laundry company to easily manage their transactions and make more productive.

## Pattern

This project using **Flutter BLoC pattern**. The gist of BLoC is that everything in the app should be represented as stream of events: widgets submit events; other widgets will respond. BLoC sits in the middle, managing the conversation.

## libraries in this app

* Firebase library | [Firebase](https://firebase.flutter.dev/)
* Make simplest way navigation flutter | [GetX](https://pub.dev/packages/get)
* Handle http request | [HTTP](https://pub.dev/packages/http)
* Local storage to save services data from network | [Hive](https://pub.dev/packages/hive)
* Load svg file | [Flutter SVG](https://pub.dev/packages/flutter_svg)
* Number format | [intl](https://pub.dev/packages/intl)
* Flutter model | [Json Serialization](https://flutter.dev/docs/development/data-and-backend/json)
* Alert library | [Flushbar](https://pub.dev/packages/flushbar)

## Assets

* [Font poppins](https://fonts.google.com/specimen/Poppins)
* Image assets source from [undraw](https://undraw.co/illustrations)

## TODO

1 [x] Create app && setup boilerplate for BLoC pattern
2 [x] Define skeleton for laundry pos app needs
3 [x] Define global data store
4 [x] Setup firebase
5 [x] Make App run well with BLoC pattern and firebase
6 [ ] Create models
7 [ ] Create resources
8 [ ] Create blocs
9 [ ] create UI
10 [ ] Done

## Demo App

[Demo](https://filla.id)

## Notes

Firebase in this project only setting for android platform. for another platform you can setup manually with follow this [instruction](https://firebase.flutter.dev/docs/overview).

## Copyrights

Open Source GNU License

Made by [**Mohammad Khaufillah**](https://filla.id) with ❤
