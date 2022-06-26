# Flutter Frontend

# Getting Started 🚀

## Installing Very Good CLI

```
dart pub global activate very_good_cli
```

## Installing all dependancies & packages

```
very_good packages get --recursive
```

## Changing IPV4 in flask_api 
**_location -> packages/flask_api/lib/src/flask_api.dart_ - line 22** <br>
_Your ipv4 address can be found using cmd by typing ipconfig in cmd_
_Your ipv4 address can be found in the system preferences network page_

```
packages/flask_api/lib/src/flask_api.dart
static const _baseUrl = 'ipv4'
```

## About

Project structure created using very_good_cli
```
https://github.com/VeryGoodOpenSource/very_good_cli
```

## Bloc

State Management using the Bloc package

```
https://bloclibrary.dev/#/
https://pub.dev/packages/flutter_bloc
https://github.com/felangel/bloc
```


