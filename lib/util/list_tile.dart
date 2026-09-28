import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../database/category.dart';
import '../database/data.dart';

import '../generated/l10n.dart';
import 'theme.dart';

/// Fill colour for a status (backgrounds, large numbers).
Color statusColor(ExpiryStatus s) => switch (s) {
  ExpiryStatus.expired => AppColors.expired,
  ExpiryStatus.soon => AppColors.soon,
  ExpiryStatus.fresh => AppColors.fresh,
};

/// Readable text colour for a status on the current surface.
Color statusTextColor(BuildContext context, ExpiryStatus s) => switch (s) {
  ExpiryStatus.expired => context.c.expiredText,
  ExpiryStatus.soon => context.c.soonText,
  ExpiryStatus.fresh => context.c.freshText,
};

class IngredientTile extends StatelessWidget {
  final Ingredient item;
  final VoidCallback onTap;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? consumeFunction;

  const IngredientTile({
    super.key,
    required this.item,
    required this.onTap,
    this.deleteFunction,
    this.consumeFunction,
  });

  String _daysLabel(BuildContext context, int diff) {
    if (diff < 0) return S.of(context).expiredDaysAgo(-diff);
    if (diff == 0) return S.of(context).expiresToday;
    if (diff == 1) return S.of(context).expiresTomorrow;
    return S.of(context).daysLeft(diff);
  }

  @override
  Widget build(BuildContext context) {
    final int diff = item.daysLeft;
    final Color color = statusColor(item.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.5,
          children: [
            // "Used one": the most common real action — eat one egg.
            SlidableAction(
              onPressed: consumeFunction,
              icon: Icons.check_rounded,
              label: S.of(context).useOne,
              backgroundColor: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            const SizedBox(width: 4),
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete_outline,
              label: S.of(context).delete,
              backgroundColor: AppColors.expired,
              borderRadius: BorderRadius.circular(16),
            ),
          ],
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      getCategoryIcon(item.categoryKey),
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: context.c.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.quantity > 1
                              ? '×${item.quantity}  ·  ${item.expdate}'
                              : item.expdate,
                          style: TextStyle(
                            fontSize: 13,
                            color: context.c.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (diff <
                      3650) // hide absurd counts like the 2999 sample item
                    Text(
                      _daysLabel(context, diff),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: statusTextColor(context, item.status),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
