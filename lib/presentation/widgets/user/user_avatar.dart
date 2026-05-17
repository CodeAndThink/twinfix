import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/avatar_frame_type.dart';
import 'package:twinfix/core/enums/avatar_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/images/app_cached_image.dart';

class UserAvatar extends StatelessWidget {
  final AvatarType avatarType;
  final AvatarFrameType frameType;
  final double size;
  final double borderWidth;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    required this.avatarType,
    required this.frameType,
    this.size = 96,
    this.borderWidth = 4,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final frameColor = frameType.color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        color: frameColor,
        child: Padding(
          padding: (size * 0.25).paddingTop,
          child: avatarType.path.isNotEmpty
              ? (avatarType.path.startsWith('assets')
                    ? AppAssetImage(path: avatarType.path)
                    : AppCachedImage(imageUrl: avatarType.path))
              : Icon(Icons.person, size: size * 0.5),
        ),
      ),
    );
  }
}
