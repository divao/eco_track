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

  /// `OK`
  String get confirm {
    return Intl.message(
      'OK',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `SIM`
  String get yes {
    return Intl.message(
      'SIM',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `NÃO`
  String get no {
    return Intl.message(
      'NÃO',
      name: 'no',
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

  /// `Algo deu errado.`
  String get genericError {
    return Intl.message(
      'Algo deu errado.',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Erro interno do servidor.`
  String get timeoutError {
    return Intl.message(
      'Erro interno do servidor.',
      name: 'timeoutError',
      desc: '',
      args: [],
    );
  }

  /// `Sem conexão com a internet.`
  String get noInternetError {
    return Intl.message(
      'Sem conexão com a internet.',
      name: 'noInternetError',
      desc: '',
      args: [],
    );
  }

  /// `TENTAR NOVAMENTE`
  String get tryAgain {
    return Intl.message(
      'TENTAR NOVAMENTE',
      name: 'tryAgain',
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

  /// `Nome`
  String get signUpNameLabel {
    return Intl.message(
      'Nome',
      name: 'signUpNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Digite seu nome`
  String get signUpNameHintText {
    return Intl.message(
      'Digite seu nome',
      name: 'signUpNameHintText',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get signUpEmailLabel {
    return Intl.message(
      'E-mail',
      name: 'signUpEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Digite seu e-mail`
  String get signUpEmailHintText {
    return Intl.message(
      'Digite seu e-mail',
      name: 'signUpEmailHintText',
      desc: '',
      args: [],
    );
  }

  /// `Senha`
  String get signUpPasswordLabel {
    return Intl.message(
      'Senha',
      name: 'signUpPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Digite sua senha`
  String get signUpPasswordHintText {
    return Intl.message(
      'Digite sua senha',
      name: 'signUpPasswordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar senha`
  String get signUpPasswordConfirmationLabel {
    return Intl.message(
      'Confirmar senha',
      name: 'signUpPasswordConfirmationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Digite sua senha novamente`
  String get signUpPasswordConfirmationHintText {
    return Intl.message(
      'Digite sua senha novamente',
      name: 'signUpPasswordConfirmationHintText',
      desc: '',
      args: [],
    );
  }

  /// `O nome é obrigatório`
  String get signUpNameEmptyError {
    return Intl.message(
      'O nome é obrigatório',
      name: 'signUpNameEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `O nome deve ter pelo menos 3 caracteres`
  String get signUpNameInvalidError {
    return Intl.message(
      'O nome deve ter pelo menos 3 caracteres',
      name: 'signUpNameInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `O email é obrigatório`
  String get signUpEmailEmptyError {
    return Intl.message(
      'O email é obrigatório',
      name: 'signUpEmailEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Campo inválido! Exemplo: exemplo@email.com`
  String get signUpEmailInvalidError {
    return Intl.message(
      'Campo inválido! Exemplo: exemplo@email.com',
      name: 'signUpEmailInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `A senha é obrigatória`
  String get signUpPasswordEmptyError {
    return Intl.message(
      'A senha é obrigatória',
      name: 'signUpPasswordEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `A senha deve ter pelo menos 6 caracteres`
  String get signUpPasswordInvalidError {
    return Intl.message(
      'A senha deve ter pelo menos 6 caracteres',
      name: 'signUpPasswordInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `A confirmação de senha não pode ser vazia`
  String get signUpPasswordConfirmationEmptyError {
    return Intl.message(
      'A confirmação de senha não pode ser vazia',
      name: 'signUpPasswordConfirmationEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `As senhas não são iguais, tente novamente`
  String get signUpPasswordConfirmationInvalidError {
    return Intl.message(
      'As senhas não são iguais, tente novamente',
      name: 'signUpPasswordConfirmationInvalidError',
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

  /// `Carregar foto`
  String get signUpPageUploadPhotoButton {
    return Intl.message(
      'Carregar foto',
      name: 'signUpPageUploadPhotoButton',
      desc: '',
      args: [],
    );
  }

  /// `Informativo`
  String get permissionsInfoDialogTitle {
    return Intl.message(
      'Informativo',
      name: 'permissionsInfoDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `EcoTrack é um app que fomenta o turismo pelo meio ambiente. Ao postar uma foto, a sua localização será marcada para possibilitar que outros usuários visualizem e visitem o mesmo local.\nPortanto, para postar fotos, é necessário conceder as permissões de localização e câmera.`
  String get permissionsInfoDialogContent {
    return Intl.message(
      'EcoTrack é um app que fomenta o turismo pelo meio ambiente. Ao postar uma foto, a sua localização será marcada para possibilitar que outros usuários visualizem e visitem o mesmo local.\nPortanto, para postar fotos, é necessário conceder as permissões de localização e câmera.',
      name: 'permissionsInfoDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Alguma permissão não foi concedida, tente novamente!`
  String get flushbarPermissionsErrorMessage {
    return Intl.message(
      'Alguma permissão não foi concedida, tente novamente!',
      name: 'flushbarPermissionsErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível obter a localização, tente novamente!`
  String get flushbarGeolocationErrorMessage {
    return Intl.message(
      'Não foi possível obter a localização, tente novamente!',
      name: 'flushbarGeolocationErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Erro ao postar a foto, tente novamente!`
  String get flushbarPostErrorMessage {
    return Intl.message(
      'Erro ao postar a foto, tente novamente!',
      name: 'flushbarPostErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Postar`
  String get postPreviewTitle {
    return Intl.message(
      'Postar',
      name: 'postPreviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Postar`
  String get postButton {
    return Intl.message(
      'Postar',
      name: 'postButton',
      desc: '',
      args: [],
    );
  }

  /// `Ver no Maps`
  String get postLocationLabel {
    return Intl.message(
      'Ver no Maps',
      name: 'postLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Legenda`
  String get postDescriptionLabel {
    return Intl.message(
      'Legenda',
      name: 'postDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Legenda (opcional)`
  String get postDescriptionHintText {
    return Intl.message(
      'Legenda (opcional)',
      name: 'postDescriptionHintText',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get profilePageTitle {
    return Intl.message(
      'Perfil',
      name: 'profilePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Editar perfil`
  String get editProfileButton {
    return Intl.message(
      'Editar perfil',
      name: 'editProfileButton',
      desc: '',
      args: [],
    );
  }

  /// `Excluir conta`
  String get deleteAccountButton {
    return Intl.message(
      'Excluir conta',
      name: 'deleteAccountButton',
      desc: '',
      args: [],
    );
  }

  /// `Sair`
  String get logoutButton {
    return Intl.message(
      'Sair',
      name: 'logoutButton',
      desc: '',
      args: [],
    );
  }

  /// `Editar perfil`
  String get editProfilePageTitle {
    return Intl.message(
      'Editar perfil',
      name: 'editProfilePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Salvar`
  String get editProfilePageSubmitButton {
    return Intl.message(
      'Salvar',
      name: 'editProfilePageSubmitButton',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get signOutDialogTitle {
    return Intl.message(
      'Logout',
      name: 'signOutDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deseja realmente sair?`
  String get signOutDialogContent {
    return Intl.message(
      'Deseja realmente sair?',
      name: 'signOutDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Excluir conta`
  String get deleteUserDialogTitle {
    return Intl.message(
      'Excluir conta',
      name: 'deleteUserDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deseja realmente excluir sua conta?`
  String get deleteUserDialogContent {
    return Intl.message(
      'Deseja realmente excluir sua conta?',
      name: 'deleteUserDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Erro ao sair, tente novamente!`
  String get flushbarSignOutErrorMessage {
    return Intl.message(
      'Erro ao sair, tente novamente!',
      name: 'flushbarSignOutErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Erro ao excluir a conta, tente novamente!`
  String get flushbarDeleteUserErrorMessage {
    return Intl.message(
      'Erro ao excluir a conta, tente novamente!',
      name: 'flushbarDeleteUserErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Mapa`
  String get bottomNavigationMapItem {
    return Intl.message(
      'Mapa',
      name: 'bottomNavigationMapItem',
      desc: '',
      args: [],
    );
  }

  /// `Para visualizar a localização das fotos postadas, é necessário conceder a permissão de localização para que o mapa inicie perto de você.`
  String get locationPermissionInfoDialogContent {
    return Intl.message(
      'Para visualizar a localização das fotos postadas, é necessário conceder a permissão de localização para que o mapa inicie perto de você.',
      name: 'locationPermissionInfoDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Mapa`
  String get mapPageTitle {
    return Intl.message(
      'Mapa',
      name: 'mapPageTitle',
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
