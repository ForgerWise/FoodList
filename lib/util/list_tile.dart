import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodlist/database/data.dart';
import 'package:foodlist/database/ingredient.dart';
import '../generated/l10n.dart';
import '../page/add_page.dart';

class ListRifTile extends StatefulWidget {
  final String categoryKey;
  final String name;
  final String expdate;
  final int quantity;
  final Function(BuildContext)? deleteFunction;

  const ListRifTile({
    super.key,
    required this.categoryKey,
    required this.name,
    required this.expdate,
    required this.quantity,
    this.deleteFunction,
  });

  @override
  State<ListRifTile> createState() => _ListRifTileState();
}

class _ListRifTileState extends State<ListRifTile> {
  /// Returns days until expiry.
  /// Positive = days remaining, 0 = expires today, negative = already expired.
  int _daysUntilExpiry() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final parts = widget.expdate.split('/');
    final exp = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
    return exp.difference(today).inDays;
  }

  Color _statusColor(int diff) {
    if (diff < 0) return const Color(0xFFE53935); // expired – red
    if (diff == 0) return const Color(0xFFF57C00); // today – deep orange
    if (diff == 1) return const Color(0xFFFFA726); // tomorrow – orange
    return const Color(0xFF43A047); // fresh – green
  }

  String _daysLabel(int diff) {
    if (diff < 0) return S.of(context).expiredDaysAgo(-diff);
    if (diff == 0) return S.of(context).expiresToday;
    if (diff == 1) return S.of(context).expiresTomorrow;
    return S.of(context).daysLeft(diff);
  }

  @override
  Widget build(BuildContext context) {
    final int diff = _daysUntilExpiry();
    final Color statusColor = _statusColor(diff);
    final String icon = getCategoryIcon(widget.categoryKey);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (ctx) => Navigator.pushNamed(
                ctx,
                '/add',
                arguments: AddPageArguments(
                  categoryKey: widget.categoryKey,
                  name: widget.name,
                  expdate: widget.expdate,
                  quantity: widget.quantity,
                ),
              ),
              icon: Icons.edit_outlined,
              backgroundColor: const Color(0xFF1E88E5),
              borderRadius: BorderRadius.circular(12),
              spacing: 2,
            ),
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete_outline,
              backgroundColor: const Color(0xFF424242),
              borderRadius: BorderRadius.circular(12),
              spacing: 2,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Coloured left bar
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(icon,
                                style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF212121),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              child: Text(
                                'x${widget.quantity}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 13, color: Colors.grey.shade500),
                            const SizedBox(width: 4),
                            Text(
                              widget.expdate,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _daysLabel(diff),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
