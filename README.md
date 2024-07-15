# EcoTrack

## Introdução

EcoTrack é um aplicativo focado em fomentar o turismo pelo meio ambiente! Nele, os usuários podem fotografar suas aventuras, que serão associadas a sua geolocalização para que os outros usuários possam conhecer.
Além disso, EcoTrack é um aplicativo *White Label*, ou seja, customizável para possíveis compradores.

O EcoTrack é implementado para ser executado em dispositivos Android e iOS. Porém, a falta de um MacOS para o desenvolvimento do app impossibilitou a *build* para iOS, uma vez que os arquivos gerados ao rodar o app no iOS, como o `Podfile`, precisam de alterações ao implementar as permissões, por exemplo.
No entanto, a *build* para iOS necessita de poucos ajustes ao rodar o app por um MacOS.
Independentemente, recomenda-se rodar o app em um dispositivo Android.

O app EcoTrack foi desenvolvido com a versão 3.22.2 do Flutter.

## Arquitetura

Dentre padrões de projeto e bibliotecas utilizadas, destacam-se:
 * Padrões de projeto: Clean Architecture e BLoC;
 * Navegação com GoRouter;
 * Injeção de dependências com Riverpod;
 * Consumo de API com Firebase;
 * *Unit Tests* com Mockito;
 * App *White Label*.

### *White Label*

A principal função para configuração o app como *white label* é o `dependency_overrides` do `pubspec.yaml`.
A organização do projeto é a seguinte:
 * Na raiz do repositório, cria-se um projeto base (`eco_track_whitelabel`) e o(s) projeto(s) que o sobrescreve(m) (`cachoeira_ferreira`);
 * Em todos os projetos, deve-se criar um diretório `common` na raiz, onde ficará tudo o que deve ser sobrescrito;
 * No `pubspec.yaml` dos projetos que sobrescrevem, adicionamos uma `dependency_overrides` que aponta para o caminho do diretório `common` e uma `dependency` para o projeto base;
 * No arquivo `main.dart` dos repositórios que sobrescrevem, apontamos a função `main` para a `main` do projeto base;
 * A partir disso, tudo o que estiver no diretório `common` do projeto base deve também deve estar no `common` dos outros projetos, podendo ser customizado.

Essa organização de projeto permite customização de temas e de `widgets`, porém, nesse exemplo foram sobrescritos apenas cores, assets e textStyles.

### Padrões de Projeto

A Clean Architecture, *design pattern* criado pelo Uncle Bob, permite a separação da lógica de negócios com a aplicação.
Na raiz do projeto, cria-se um package `domain`. Esse package independe de *frameworks* e é utilizado apenas para a lógica de negócios. Nele, cria-se os casos de uso, ou *use cases*, que ditam as funcionalidades principais do aplicativo.
Os *use cases* se comunicam com os *data sources* (classes que interagem com APIs, cache, memória, etc) através de *repositories*, e são os casos de uso que são chamados no `BLoC`.

O `BLoC` é um padrão de projeto de gerenciamento de estado. Pode ser implementado livre de bibliotecas ou através da *lib* [BLoC](https://pub.dev/packages/flutter_bloc). 
Essa biblioteca abstrai as `sinks` e `streams` da programação reativa através de `events` e `states`, permitindo a atualização dos `widgets` ao disparar um evento, que emitirá um novo estado.

## Instalação

Para rodar o app base (EcoTrack), basta acessar o diretório `eco_track_whitelabel` e rodar o comando:
> flutter run

Para rodar o app "do cliente", basta acessar o diretório `cachoeira_ferreira` e rodar o comando:
> flutter run

Ou então configurar a IDE de preferência para rodar a partir desses diretórios.
Recomenda-se a versão 3.22.2 do Flutter.

## Lojas (PlayStore e AppStore)

O app EcoTrack foi desenvolvido atentando-se por diretrizes e políticas da PlayStore e AppStore, como por exemplo:
 * Os [pedidos de permissões](https://support.google.com/googleplay/android-developer/answer/9888170?visit_id=638566342931822175-1922719266&rd=1) no app (localização e camera) possuem dialogs prévios esclarecendo a necessidade do acesso a essas funcionalidades;
 * O app utiliza as [versões mais recentes](https://support.google.com/googleplay/android-developer/answer/11917020) da API dos sistemas operacionais, dada a restrição à versões antigas.