# Flutter Laundry POS System

## Description

This app made for laundry company to easily manage their transactions and make more productive.

## Pattern

This project using **Flutter BLoC pattern**. The gist of BLoC is that everything in the app should be represented as stream of events: widgets submit events; other widgets will respond. BLoC sits in the middle, managing the conversation.

## libraries in this app

* Firebase library | [Firebase](https://firebase.flutter.dev/)
* Make simplest way in flutter | [GetX](https://pub.dev/packages/get)
* Handle http request | [HTTP](https://pub.dev/packages/http)
* Load svg file | [Flutter SVG](https://pub.dev/packages/flutter_svg)
* Number format | [intl](https://pub.dev/packages/intl)
* Flutter model | [Json Serialization](https://flutter.dev/docs/development/data-and-backend/json)
* Datetime picker | [Flutter Datetime Picker](https://pub.dev/packages/flutter_datetime_picker)
* JWT creator | [Jaguar JWT](https://pub.dev/packages/jaguar_jwt)

## Assets

* [Font poppins](https://fonts.google.com/specimen/Poppins)
* Image assets source from [undraw](https://undraw.co/illustrations)

## TODO

* [x] Create app && setup boilerplate for BLoC pattern
* [x] Define skeleton for laundry pos app needs
* [x] Define global data store
* [x] Setup firebase
* [x] Make App run well with BLoC pattern and firebase
* [x] Create models
* [x] Create resources
* [x] Create blocs
* [x] create UI
* [x] Done
* [ ] Publish APK

## Demo App

[Demo](https://filla.id)

## Notes

Firebase in this project only setting for android platform. for another platform you can setup manually with follow this [instruction](https://firebase.flutter.dev/docs/overview).

Run in terminal to generate model

```bash
flutter pub run build_runner build
```

## Copyrights

Open Source GNU License

Made by [**Mohammad Khaufillah**](https://filla.id) with ❤
