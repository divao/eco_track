// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `EcoTrack`
  String get appTitle {
    return Intl.message(
      'EcoTrack',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Feed`
  String get bottomNavigationFeedItem {
    return Intl.message(
      'Feed',
      name: 'bottomNavigationFeedItem',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get bottomNavigationProfileItem {
    return Intl.message(
      'Perfil',
      name: 'bottomNavigationProfileItem',
      desc: '',
      args: [],
    );
  }

  /// `Entrar`
  String get accessPageSignInButton {
    return Intl.message(
      'Entrar',
      name: 'accessPageSignInButton',
      desc: '',
      args: [],
    );
  }

  /// `Criar conta`
  String get accessPageSignUpButton {
    return Intl.message(
      'Criar conta',
      name: 'accessPageSignUpButton',
      desc: '',
      args: [],
    );
  }

  /// `Entrar`
  String get signInPageTitle {
    return Intl.message(
      'Entrar',
      name: 'signInPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Entrar`
  String get signInPageSignInButton {
    return Intl.message(
      'Entrar',
      name: 'signInPageSignInButton',
      desc: '',
      args: [],
    );
  }

  /// `Cadastro`
  String get signUpPageTitle {
    return Intl.message(
      'Cadastro',
      name: 'signUpPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ocorreu um erro, tente novamente!`
  String get flushbarServerErrorMessage {
    return Intl.message(
      'Ocorreu um erro, tente novamente!',
      name: 'flushbarServerErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `O email informado já está em uso!`
  String get flushbarEmailErrorMessage {
    return Intl.message(
      'O email informado já está em uso!',
      name: 'flushbarEmailErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get signInEmailLabel {
    return Intl.message(
      'E-mail',
      name: 'signInEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Digite seu e-mail`
  String get signInEmailHintText {
    return Intl.message(
      'Digite seu e-mail',
      name: 'signInEmailHintText',
      desc: '',
      args: [],
    );
  }

  /// `Senha`
  String get signInPasswordLabel {
    return Intl.message(
      'Senha',
      name: 'signInPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Digite sua senha`
  String get signInPasswordHintText {
    return Intl.message(
      'Digite sua senha',
      name: 'signInPasswordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Esqueci a senha`
  String get signInForgotPassword {
    return Intl.message(
      'Esqueci a senha',
      name: 'signInForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `E-mail inválido`
  String get signInInvalidEmailError {
    return Intl.message(
      'E-mail inválido',
      name: 'signInInvalidEmailError',
      desc: '',
      args: [],
    );
  }

  /// `E-mail ou senha incorreta`
  String get signInWrongCredentialsError {
    return Intl.message(
      'E-mail ou senha incorreta',
      name: 'signInWrongCredentialsError',
      desc: '',
      args: [],
    );
  }

  /// `O nome é obrigatório`
  String get signUpNameEmptyErrorText {
    return Intl.message(
      'O nome é obrigatório',
      name: 'signUpNameEmptyErrorText',
      desc: '',
      args: [],
    );
  }

  /// `O nome deve ter pelo menos 3 caracteres`
  String get signUpNameInvalidErrorText {
    return Intl.message(
      'O nome deve ter pelo menos 3 caracteres',
      name: 'signUpNameInvalidErrorText',
      desc: '',
      args: [],
    );
  }

  /// `O email é obrigatório`
  String get signUpEmailEmptyErrorText {
    return Intl.message(
      'O email é obrigatório',
      name: 'signUpEmailEmptyErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Campo inválido! Exemplo: exemplo@email.com`
  String get signUpEmailInvalidErrorText {
    return Intl.message(
      'Campo inválido! Exemplo: exemplo@email.com',
      name: 'signUpEmailInvalidErrorText',
      desc: '',
      args: [],
    );
  }

  /// `A senha é obrigatória`
  String get signUpPasswordEmptyErrorText {
    return Intl.message(
      'A senha é obrigatória',
      name: 'signUpPasswordEmptyErrorText',
      desc: '',
      args: [],
    );
  }

  /// `A senha deve ter pelo menos 6 caracteres`
  String get signUpPasswordInvalidErrorText {
    return Intl.message(
      'A senha deve ter pelo menos 6 caracteres',
      name: 'signUpPasswordInvalidErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Nome`
  String get signUpPageNameField {
    return Intl.message(
      'Nome',
      name: 'signUpPageNameField',
      desc: '',
      args: [],
    );
  }

  /// `Confirme a senha`
  String get signUpPageConfirmPasswordField {
    return Intl.message(
      'Confirme a senha',
      name: 'signUpPageConfirmPasswordField',
      desc: '',
      args: [],
    );
  }

  /// `Cadastrar`
  String get signUpPageSignUpButton {
    return Intl.message(
      'Cadastrar',
      name: 'signUpPageSignUpButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
