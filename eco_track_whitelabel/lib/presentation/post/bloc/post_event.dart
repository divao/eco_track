import 'dart:io';

abstract class PostEvent {}

class TakePhoto extends PostEvent {
  TakePhoto({
    required this.file,
  });

  final File file;
}

class Post extends PostEvent {}