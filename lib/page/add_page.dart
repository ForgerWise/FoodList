import 'package:flutter/material.dart';
import '../database/ingredient.dart';
import 'package:intl/intl.dart';
import '../database/data.dart';

import '../database/sub_category.dart';
import '../generated/l10n.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? _selectedCategory;
  String? _selectedSubcategory;
  DateTime? _dateTime;
  int? editIndex;
  InputDataBase IDB = InputDataBase();
  CategoryDataBase CDB = CategoryDataBase();

  @override
  void initState() {
    super.initState();

    loadDataAsync();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments is AddPageArguments) {
        final AddPageArguments data = arguments;
        setState(() {
          _dateTime = DateFormat('yyyy/MM/dd').parse(data.expdate);
          loadEditData(data);
        });
      }
    });
  }

  Future<void> loadDataAsync() async {
    await CDB.loadData();
    setState(() {});
  }

  Future<void> loadEditData(data) async {
    await IDB.loadData();
    editIndex = IDB.searchIndex(
      data.category,
      data.subcategory,
      data.expdate,
      IDB.ingredientsList,
    );
    _selectedCategory = CDB.categoryMap.keys.firstWhere(
        (key) => CDB.categoryMap[key] == data.category,
        orElse: () => '');
    _selectedSubcategory = CDB.subCategoryMap[_selectedCategory!]
        ?.firstWhere((subCategory) => subCategory.name == data.subcategory,
            orElse: () => SubCategory(id: '', name: ''))
        .id;
    if (_selectedCategory == '' || _selectedSubcategory == '') {
      // * If the category or subcategory is deleted, show the dialog and pop
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.of(context).error),
              content: Text(S.of(context).catOrSubcatIsDelError),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).confirm),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void dropDownCallBack(String? selectedCategory) {
    if (selectedCategory is String) {
      setState(() {
        _selectedCategory = selectedCategory;
        _selectedSubcategory = null;
      });
    } else {
      setState(() {
        _selectedCategory = null;
        _selectedSubcategory = null;
      });
    }
  }

  void dropDownSubcategoryCallBack(String? selectedSubcategory) {
    if (selectedSubcategory is String) {
      setState(() {
        _selectedSubcategory = selectedSubcategory;
      });
    } else {
      setState(() {
        _selectedSubcategory = null;
      });
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 100),
    ).then(
      (value) {
        if (value != null) {
          setState(
            () {
              _dateTime = value;
            },
          );
        }
      },
    );
  }

  addData(
      String category, String subcategory, String inputdate, String expdate) {
    setState(() {
      IDB.loadData();
      IDB.ingredientsList.add([category, subcategory, inputdate, expdate]);
    });
    IDB.updateData();
  }

  editData(int index, String category, String subcategory, String expdate) {
    setState(() {
      IDB.loadData();
      IDB.editData(index, category, subcategory, expdate, IDB.ingredientsList);
    });
    IDB.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          handlePopInvoked();
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: buildAppBar(),
        body: buildBody(),
        resizeToAvoidBottomInset: false,
        floatingActionButton: buildFloatingActionButtons(context),
      ),
    );
  }

  void handlePopInvoked() {
    setState(() {
      _selectedCategory = null;
      _selectedSubcategory = null;
      _dateTime = null;
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      title: editIndex != null && editIndex != -1
          ? Text(S.of(context).editIngredients,
              style: const TextStyle(color: Colors.white))
          : Text(S.of(context).addIngredients,
              style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.blueGrey,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            buildCategoryRow(),
            buildCategoryDropdown(),
            buildSubcategoryRow(),
            buildSubcategoryDropdown(),
            buildExpireDateRow(),
            buildExpireDateButton(),
          ],
        ),
      ),
    );
  }

  Row buildCategoryRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
          child: Text(
            S.of(context).category,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildCategoryDropdown() {
    return DropdownMenu<String>(
      initialSelection: _selectedCategory,
      onSelected: (String? newValue) {
        if (newValue != null) {
          dropDownCallBack(newValue);
        }
      },
      dropdownMenuEntries: CDB.categoryKeys.map((option) {
        return DropdownMenuEntry<String>(
          value: option,
          label: CDB.categoryMap[option] ?? '',
        );
      }).toList(),
      menuHeight: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.9,
      enableFilter: true,
      hintText: S.of(context).selectCategoryHint,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Row buildSubcategoryRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
          child: Text(
            S.of(context).subcategory,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildSubcategoryDropdown() {
    return DropdownMenu<String>(
      initialSelection: _selectedSubcategory,
      onSelected: (String? newValue) {
        if (newValue != null) {
          dropDownSubcategoryCallBack(newValue);
        }
      },
      dropdownMenuEntries: CDB.subCategoryMap[_selectedCategory]?.map((option) {
            return DropdownMenuEntry<String>(
              value: option.id,
              label: option.name,
            );
          }).toList() ??
          [],
      menuHeight: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.9,
      enableFilter: true,
      hintText: S.of(context).selectSubcategoryHint,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Row buildExpireDateRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
          child: Text(
            S.of(context).expireDate,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Row buildExpireDateButton() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: MaterialButton(
            onPressed: _showDatePicker,
            child: Text(
              _dateTime != null
                  ? S.of(context).expireDateConfirmMessage(_dateTime!)
                  : S.of(context).selectDate,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFloatingActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 30.0),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.red[400],
              onPressed: () {
                setState(() {
                  _selectedCategory = null;
                  _selectedSubcategory = null;
                  _dateTime = null;
                });
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel, color: Colors.white),
              label: Text(S.of(context).cancel,
                  style: const TextStyle(color: Colors.white)),
              elevation: 0,
            ),
          ),
          Visibility(
            visible: _dateTime != null,
            child: const SizedBox(width: 40.0),
          ),
          Visibility(
            visible: _dateTime != null,
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.green[400],
                onPressed: () {
                  setState(
                    () {
                      editIndex != null && editIndex != -1
                          ? editData(
                              editIndex!,
                              CDB.categoryMap[_selectedCategory!]!,
                              _selectedSubcategory != null
                                  ? CDB.subCategoryMap[_selectedCategory!]
                                          ?.firstWhere((subCategory) =>
                                              subCategory.id ==
                                              _selectedSubcategory)
                                          .name ??
                                      ''
                                  : '',
                              DateFormat('yyyy/MM/dd').format(_dateTime!),
                            )
                          : addData(
                              CDB.categoryMap[_selectedCategory!]!,
                              _selectedSubcategory != null
                                  ? CDB.subCategoryMap[_selectedCategory!]
                                          ?.firstWhere((subCategory) =>
                                              subCategory.id ==
                                              _selectedSubcategory)
                                          .name ??
                                      ''
                                  : '',
                              DateFormat('yyyy/MM/dd').format(DateTime.now()),
                              DateFormat('yyyy/MM/dd').format(_dateTime!),
                            );
                      _selectedCategory = null;
                      _selectedSubcategory = null;
                      _dateTime = null;
                      Navigator.pop(context, true);
                    },
                  );
                },
                icon: const Icon(Icons.done, color: Colors.white),
                label: Text(S.of(context).confirm,
                    style: const TextStyle(color: Colors.white)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddPageArguments {
  final String category;
  final String subcategory;
  final String inputdate;
  final String expdate;

  AddPageArguments({
    required this.category,
    required this.subcategory,
    required this.inputdate,
    required this.expdate,
  });
}
