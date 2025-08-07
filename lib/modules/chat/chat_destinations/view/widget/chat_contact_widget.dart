import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:intl/intl.dart';

class ChatContactWidget extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  final String time;
  final String? imageUrl;
  final int? unreadCount;
  final VoidCallback? onTap;

  const ChatContactWidget({
    super.key,
    required this.contactName,
    required this.lastMessage,
    required this.time,
    this.imageUrl,
    this.unreadCount,
    this.onTap,
  });

  String _formatContactTime(String isoString) {
    if (isoString.isEmpty) return '';
    try {
      final DateTime dateTime = DateTime.parse(isoString);
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime yesterday = today.subtract(const Duration(days: 1));

      if (dateTime.isAfter(today)) {
        return DateFormat.jm().format(dateTime);
      } else if (dateTime.isAfter(yesterday)) {
        return 'Yesterday';
      } else {
        return DateFormat.yMd().format(dateTime);
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final int safeUnreadCount = unreadCount ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkCardBackground
                  : AppColors.lightCardBackground,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: (imageUrl != null && imageUrl!.isNotEmpty)
                        ? CachedNetworkImage(
                            imageUrl: imageUrl!,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) => const Center(
                                    child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.grey),
                          )
                        : const Icon(Icons.person,
                            size: 30, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              contactName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatContactTime(time),
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              lastMessage,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                                fontWeight: safeUnreadCount > 0
                                    ? FontWeight.w600 // Make bold if unread
                                    : FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (safeUnreadCount > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                safeUnreadCount.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
