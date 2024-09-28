import 'package:flutter/material.dart';
import '../database/ingredient.dart';
import 'package:intl/intl.dart';
import '../database/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddPage extends StatefulWidget {
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
  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    if (_myBox.get("SUB_CATEGORY_MAP") == null) {
      CDB.createInitialData();
      CDB.updateData();
    } else {
      CDB.loadData();
    }

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments is AddPageArguments) {
        final AddPageArguments data = arguments;
        setState(() {
          _selectedCategory = data.category;
          _selectedSubcategory = data.subcategory;
          _dateTime = DateFormat('yyyy/MM/dd').parse(data.expdate);
          IDB.loadData();
          editIndex = IDB.searchIndex(
            data.category,
            data.subcategory,
            data.expdate,
            IDB.ingredientsList,
          );
          print(editIndex);
        });
      } else {
        print('Arguments are not of type AddPageArguments');
      }
    });
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
      onPopInvoked: handlePopInvoked,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: buildAppBar(),
        body: buildBody(),
        resizeToAvoidBottomInset: false,
        floatingActionButton: buildFloatingActionButtons(context),
      ),
    );
  }

  void handlePopInvoked(bool isPop) {
    if (isPop) {
      setState(() {
        _selectedCategory = null;
        _selectedSubcategory = null;
        _dateTime = null;
      });
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      title: editIndex != null && editIndex != -1
          ? const Text("Edit Ingredients",
              style: TextStyle(color: Colors.white))
          : const Text("Add Ingredients",
              style: TextStyle(color: Colors.white)),
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
            // * If the selected subcategory is the last one(which is Other), then show the name input field
            _selectedCategory != null &&
                    _selectedSubcategory ==
                        CDB.subCategoryMap[_selectedCategory!]?.last
                ? buildNameRow()
                : const SizedBox(),
            _selectedCategory != null &&
                    _selectedSubcategory ==
                        CDB.subCategoryMap[_selectedCategory!]?.last
                ? buildNameInput()
                : const SizedBox(),
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
          child: const Text(
            "Category",
            style: TextStyle(
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
        dropdownMenuEntries: CDB.categoryList.map((option) {
          return DropdownMenuEntry<String>(
            value: option,
            label: option,
          );
        }).toList(),
        menuHeight: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        enableFilter: true,
        hintText: 'Select Category',
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Row buildSubcategoryRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
          child: const Text(
            "Subcategory",
            style: TextStyle(
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
                    value: option,
                    label: option,
                  );
                }).toList() ??
                [],
        menuHeight: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        enableFilter: true,
        hintText: "Select Subcategory",
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Row buildNameRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
          child: const Text(
            "Name",
            style: TextStyle(
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
            decoration: const InputDecoration(
              hintText: 'Please input the name of the ingredient',
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
            const Text("Add to Subcategory"),
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
          child: const Text(
            "Expire Date",
            style: TextStyle(
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
                  ? "Expire Date: ${DateFormat('yyyy/MM/dd').format(_dateTime!)}"
                  : "Select Date",
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 30.0),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.blueGrey,
              onPressed: () {
                setState(() {
                  _selectedCategory = null;
                  _selectedSubcategory = null;
                  _dateTime = null;
                });
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel, color: Colors.white),
              label:
                  const Text('Cancel', style: TextStyle(color: Colors.white)),
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
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  setState(
                    () {
                      editIndex != null && editIndex != -1
                          ? editData(
                              editIndex!,
                              _selectedCategory!,
                              _ingredientName.isNotEmpty
                                  ? _ingredientName
                                  : _selectedSubcategory!,
                              DateFormat('yyyy/MM/dd').format(_dateTime!),
                            )
                          : addData(
                              _selectedCategory!,
                              _ingredientName.isNotEmpty
                                  ? _ingredientName
                                  : _selectedSubcategory!,
                              DateFormat('yyyy/MM/dd').format(DateTime.now()),
                              DateFormat('yyyy/MM/dd').format(_dateTime!),
                            );
                      if (_addToSubcategory && _ingredientName.isNotEmpty) {
                        List<String>? subCategoryList =
                            CDB.subCategoryMap[_selectedCategory!];
                        if (subCategoryList != null &&
                            subCategoryList.isNotEmpty) {
                          subCategoryList.insert(
                              subCategoryList.length - 1, _ingredientName);
                          CDB.updateData();
                        } else {
                          subCategoryList?.add(_ingredientName);
                          CDB.updateData();
                        }
                      }
                      _selectedCategory = null;
                      _selectedSubcategory = null;
                      _dateTime = null;
                      Navigator.pop(context, true);
                    },
                  );
                },
                icon: const Icon(Icons.done, color: Colors.white),
                label: const Text('Confirm',
                    style: TextStyle(color: Colors.white)),
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
