import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/avatar_frame_type.dart';
import 'package:twinfix/core/enums/avatar_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/images/app_cached_image.dart';

class UserAvatar extends StatelessWidget {
  final AvatarType avatarType;
  final AvatarFrameType frameType;
  final double height;
  final double width;
  final double borderWidth;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    required this.avatarType,
    required this.frameType,
    required this.height,
    required this.width,
    this.borderWidth = 4,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: (height * 0.2).paddingTop,
          child: avatarType.path.isNotEmpty
              ? (avatarType.path.startsWith('assets')
                    ? AppAssetImage(path: avatarType.path)
                    : AppCachedImage(imageUrl: avatarType.path))
              : Icon(Icons.person, size: width * 0.5),
        ),
      ),
    );
  }
}
