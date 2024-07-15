import 'package:domain/model/feed_post.dart';
import 'package:domain/model/geolocation.dart';

Future<void> mockLogger(
  String errorType,
  dynamic error, [
  StackTrace? stackTrace,
]) async {}

Future<bool> mockAuthenticationExpiredHandler() async => false;

const mockFeedPostList = [
  FeedPost(
    name: 'User Name 1',
    description: "Descricao 1",
    postImageUrl: '',
    profileImageUrl: '',
    geolocation: Geolocation(latitude: 1, longitude: 1),
  ),
  FeedPost(
    name: 'User Name 2',
    description: "Descricao 2",
    postImageUrl: '',
    profileImageUrl: '',
    geolocation: Geolocation(latitude: 2, longitude: 2),
  ),
  FeedPost(
    name: 'User Name 2',
    description: "Descricao 2",
    postImageUrl: '',
    profileImageUrl: '',
    geolocation: Geolocation(latitude: 2, longitude: 2),
  ),
];

const mockPassword = 'Senha12345&';

const mockEmail = 'emailteste@email.com';

const mockUserName = 'Nome Teste';
