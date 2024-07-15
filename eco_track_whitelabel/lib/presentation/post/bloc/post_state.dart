import 'dart:io';

import 'package:eco_track_whitelabel/presentation/common/utils/status/post_status.dart';

final class PostState {
  const PostState({
    required this.status,
    required this.file,
  });


  PostState copyWith({
    PostStatus? status,
    File? file,
  }) {
    return PostState(
      status: status ?? this.status,
      file: file ?? this.file,
    );
  }

  final PostStatus status;
  final File? file;
}
