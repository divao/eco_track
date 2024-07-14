import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/data/view/model/feed_post_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedPostItem extends ConsumerWidget {
  const FeedPostItem({
    required this.feedPost,
    required this.isLast,
    super.key,
  });

  final FeedPostVM feedPost;
  final bool isLast;

  void navigateTo(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 88 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      CachedNetworkImageProvider(feedPost.profileImageUrl),
                ),
                const SizedBox(width: 8),
                Text(
                  feedPost.name,
                  style: ref.textStyles.feedPostUserName,
                )
              ],
            ),
          ),
          CachedNetworkImage(
            imageUrl: feedPost.postImageUrl,
            width: double.infinity,
          ),
          const SizedBox(height: 4),
          if (feedPost.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                feedPost.description,
                style: ref.textStyles.feedPostDescription,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => navigateTo(feedPost.geolocation.latitude,
                  feedPost.geolocation.longitude),
              child: Text(
                ref.s.postLocationLabel,
                style: ref.textStyles.feedPostGeolocation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
