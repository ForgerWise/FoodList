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
  bool _addToSubcategory = false;
  DateTime? _dateTime;
  String _ingredientName = '';
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
      } else {
        print('Arguments are not of type AddPageArguments');
      }
    });
  }

  Future<void> loadDataAsync() async {
    await CDB.loadData();
    setState(() {
      print(CDB.subCategoryMap);
    });
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
  }

  void dropDownCallBack(String? selectedCategory) {
    if (selectedCategory is String) {
      setState(() {
        _selectedCategory = selectedCategory;
        _selectedSubcategory = null;
      });
    }
  }

  void dropDownSubcategoryCallBack(String? selectedSubcategory) {
    if (selectedSubcategory is String) {
      setState(() {
        _selectedSubcategory = selectedSubcategory;
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
    print("Data Added");
  }

  editData(int index, String category, String subcategory, String expdate) {
    setState(() {
      IDB.loadData();
      IDB.editData(index, category, subcategory, expdate, IDB.ingredientsList);
    });
    IDB.updateData();
    print("Data Edited");
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

  bool showNameInput() {
    if (_selectedCategory != null &&
        _selectedCategory != '' &&
        _selectedSubcategory != null &&
        _selectedSubcategory != SubCategory(id: '', name: '')) {
      // * If the selected subcategory is the last one(which is Other), then show the name input field
      List<SubCategory>? subCategories;
      subCategories = CDB.subCategoryMap[_selectedCategory!];

      if (subCategories != null && subCategories.isNotEmpty) {
        print(subCategories.last.id);
        print(_selectedSubcategory);
        SubCategory lastSubCategory = subCategories.last;
        return _selectedSubcategory == lastSubCategory.id;
      }
    }
    return false;
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
            // * If the selected subcategory is the last one(which is Other), then show the name input field
            showNameInput() ? buildNameRow() : const SizedBox(),
            showNameInput() ? buildNameInput() : const SizedBox(),
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
    return Container(
      child: DropdownMenu<String>(
        initialSelection: _selectedCategory,
        onSelected: (String? newValue) {
          if (newValue != null) {
            dropDownCallBack(newValue);
          }
        },
        dropdownMenuEntries: CDB.categoryMap.entries
            .map(
              (category) => DropdownMenuEntry<String>(
                value: category.key,
                label: category.value,
              ),
            )
            .toList(),
        menuHeight: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        enableFilter: true,
        hintText: S.of(context).selectCategoryHint,
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
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
    return Container(
      child: DropdownMenu<String>(
        initialSelection: _selectedSubcategory,
        onSelected: (String? newValue) {
          if (newValue != null) {
            dropDownSubcategoryCallBack(newValue);
          }
        },
        dropdownMenuEntries:
            CDB.subCategoryMap[_selectedCategory]?.map((option) {
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
      ),
    );
  }

  Row buildNameRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
          child: Text(
            S.of(context).subcategoryName,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Column buildNameInput() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: S.of(context).subcategoryNameInputHint,
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                _ingredientName = value.isNotEmpty
                    ? value[0].toUpperCase() + value.substring(1)
                    : '';
                if (_ingredientName.isEmpty) {
                  _addToSubcategory = false;
                }
              });
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Checkbox(
              value: _addToSubcategory && _ingredientName.isNotEmpty,
              onChanged: _ingredientName.isNotEmpty
                  ? (value) {
                      if (value != null) {
                        setState(() {
                          _addToSubcategory = value;
                        });
                      }
                    }
                  : null,
              activeColor: Colors.blueGrey,
            ),
            Text(S.of(context).addToSubcategory),
          ],
        )
      ],
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
            visible: _selectedSubcategory != null && _dateTime != null,
            child: const SizedBox(width: 40.0),
          ),
          Visibility(
            visible: _selectedSubcategory != null && _dateTime != null,
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
                              _ingredientName.isNotEmpty
                                  ? _ingredientName
                                  : CDB.subCategoryMap[_selectedCategory!]
                                          ?.firstWhere((subCategory) =>
                                              subCategory.id ==
                                              _selectedSubcategory)
                                          .name ??
                                      '',
                              DateFormat('yyyy/MM/dd').format(_dateTime!),
                            )
                          : addData(
                              CDB.categoryMap[_selectedCategory!]!,
                              _ingredientName.isNotEmpty
                                  ? _ingredientName
                                  : CDB.subCategoryMap[_selectedCategory!]
                                          ?.firstWhere((subCategory) =>
                                              subCategory.id ==
                                              _selectedSubcategory)
                                          .name ??
                                      '',
                              DateFormat('yyyy/MM/dd').format(DateTime.now()),
                              DateFormat('yyyy/MM/dd').format(_dateTime!),
                            );
                      if (_addToSubcategory && _ingredientName.isNotEmpty) {
                        List<SubCategory>? subCategoryList =
                            CDB.subCategoryMap[_selectedCategory!];

                        // * Create a new SubCategory object
                        SubCategory newSubCategory =
                            SubCategory.fromNameWithMapCheck(
                                _ingredientName, CDB.subCategoryMap);

                        // * Add the new SubCategory object to the list
                        if (subCategoryList != null &&
                            subCategoryList.isNotEmpty) {
                          subCategoryList.insert(
                              subCategoryList.length - 1, newSubCategory);
                        } else {
                          // * If the list is empty, create a new list with the new SubCategory object and the 'Other' SubCategory object is the last one
                          String otherNewIngredient =
                              S.of(context).other + _selectedCategory!;
                          SubCategory otherNewSubCategory =
                              SubCategory.fromNameWithMapCheck(
                                  otherNewIngredient, CDB.subCategoryMap);
                          subCategoryList = [
                            newSubCategory,
                            otherNewSubCategory
                          ];
                        }

                        // * Update the SubCategoryMap
                        CDB.subCategoryMap[_selectedCategory!] =
                            subCategoryList;
                        CDB.updateSubCategoryData();
                      }
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
