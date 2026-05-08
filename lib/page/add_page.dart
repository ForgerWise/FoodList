import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/data.dart';
import '../database/ingredient.dart';
import '../generated/l10n.dart';

// ---------------------------------------------------------------------------
// Arguments passed when navigating to AddPage for editing
// ---------------------------------------------------------------------------
class AddPageArguments {
  final String categoryKey;
  final String name;
  final String expdate;
  final int quantity;

  AddPageArguments({
    required this.categoryKey,
    required this.name,
    required this.expdate,
    required this.quantity,
  });
}

// ---------------------------------------------------------------------------
// AddPage
// ---------------------------------------------------------------------------
class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? _selectedCategoryKey;
  final TextEditingController _nameController = TextEditingController();
  DateTime? _dateTime;
  int _quantity = 1;
  int? editIndex;

  final InputDataBase _idb = InputDataBase();
  final CategoryDataBase _cdb = CategoryDataBase();

  @override
  void initState() {
    super.initState();
    _loadData();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleArguments());
  }

  Future<void> _loadData() async {
    await _cdb.loadData();
    setState(() {});
  }

  void _handleArguments() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is AddPageArguments) {
      setState(() {
        _selectedCategoryKey = args.categoryKey;
        _nameController.text = args.name;
        _dateTime = DateFormat('yyyy/MM/dd').parse(args.expdate);
        _quantity = args.quantity;
      });
      _findEditIndex(args);
    }
  }

  Future<void> _findEditIndex(AddPageArguments args) async {
    await _idb.loadData();
    final idx = _idb.searchIndex(
        args.categoryKey, args.name, args.expdate, _idb.ingredientsList);
    setState(() => editIndex = idx);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateTime ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 100),
    ).then((value) {
      if (value != null) setState(() => _dateTime = value);
    });
  }

  bool get _canConfirm =>
      _nameController.text.trim().isNotEmpty && _dateTime != null;

  Future<void> _onConfirm() async {
    final String name = _nameController.text.trim();
    final String catKey = _selectedCategoryKey ?? 'others';
    final String expdate = DateFormat('yyyy/MM/dd').format(_dateTime!);

    await _idb.loadData();
    if (editIndex != null && editIndex != -1) {
      _idb.editData(
          editIndex!, catKey, name, expdate, _quantity, _idb.ingredientsList);
    } else {
      _idb.ingredientsList.add([catKey, name, expdate, _quantity]);
    }
    _idb.updateData();
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = editIndex != null && editIndex != -1;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          isEdit
              ? S.of(context).editIngredients
              : S.of(context).addIngredients,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionLabel(S.of(context).ingredientName),
            const SizedBox(height: 8),
            _buildNameField(),
            const SizedBox(height: 24),
            _buildSectionLabel(S.of(context).category),
            const SizedBox(height: 12),
            _buildCategoryGrid(),
            const SizedBox(height: 24),
            _buildSectionLabel(S.of(context).quantity),
            const SizedBox(height: 8),
            _buildQuantityRow(),
            const SizedBox(height: 24),
            _buildSectionLabel(S.of(context).expireDate),
            const SizedBox(height: 8),
            _buildDateButton(),
            const SizedBox(height: 36),
            _buildActionButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── Section label ─────────────────────────────────────────────────────────
  Widget _buildSectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.blueGrey,
          letterSpacing: 0.5,
        ),
      );

  // ── Name field ────────────────────────────────────────────────────────────
  Widget _buildNameField() => TextField(
        controller: _nameController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: S.of(context).ingredientNameHint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Colors.blueGrey, width: 2),
          ),
        ),
      );

  // ── Category icon grid ────────────────────────────────────────────────────
  Widget _buildCategoryGrid() {
    final keys = _cdb.categoryKeys;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: keys.map((key) {
        final bool selected = _selectedCategoryKey == key;
        final String icon = getCategoryIcon(key);
        final String label = _cdb.categoryMap[key] ?? key;
        return GestureDetector(
          onTap: () => setState(() => _selectedCategoryKey = key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? Colors.blueGrey : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? Colors.blueGrey : Colors.grey.shade200,
                width: selected ? 2 : 1,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(icon, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Quantity row ──────────────────────────────────────────────────────────
  Widget _buildQuantityRow() => Row(
        children: [
          _quantityButton(
            icon: Icons.remove,
            onTap: () {
              if (_quantity > 1) setState(() => _quantity--);
            },
          ),
          Container(
            width: 56,
            alignment: Alignment.center,
            child: Text(
              '$_quantity',
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          _quantityButton(
            icon: Icons.add,
            onTap: () => setState(() => _quantity++),
          ),
        ],
      );

  Widget _quantityButton(
          {required IconData icon, required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      );

  // ── Date button ───────────────────────────────────────────────────────────
  Widget _buildDateButton() => GestureDetector(
        onTap: _showDatePicker,
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _dateTime != null
                  ? Colors.blueGrey
                  : Colors.grey.shade200,
              width: _dateTime != null ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 20,
                  color: _dateTime != null
                      ? Colors.blueGrey
                      : Colors.grey.shade400),
              const SizedBox(width: 10),
              Text(
                _dateTime != null
                    ? S.of(context).expireDateConfirmMessage(_dateTime!)
                    : S.of(context).selectDate,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _dateTime != null
                      ? Colors.blueGrey
                      : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      );

  // ── Action buttons ────────────────────────────────────────────────────────
  Widget _buildActionButtons() => Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, size: 18),
              label: Text(S.of(context).cancel),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                side: BorderSide(color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _canConfirm ? _onConfirm : null,
              icon: const Icon(Icons.check, size: 18, color: Colors.white),
              label: Text(
                S.of(context).confirm,
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      );
}
