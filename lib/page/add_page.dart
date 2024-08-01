import 'package:flutter/material.dart';
import 'package:refrigerator_manage/database/ingredient.dart';
import 'package:intl/intl.dart';
import 'package:refrigerator_manage/database/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddPage extends StatefulWidget {
  final String? catagory;
  final String? subcatagory;
  final DateTime? inputdate;
  final DateTime? expdate;

  const AddPage(
    param0,
    param1,
    param2,
    param3, {
    Key? key,
    this.catagory,
    this.subcatagory,
    this.inputdate,
    this.expdate,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? _selectedCatagory;
  String? _selectedSubcatagory;
  bool _addToSubcatagory = false;
  DateTime? _dateTime;
  String _ingredientName = '';
  InputDataBase IDB = InputDataBase();
  CatagoryDataBase CDB = CatagoryDataBase();
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
  }

  void dropDownCallBack(String? selectedCatagory) {
    if (selectedCatagory is String) {
      setState(() {
        _selectedCatagory = selectedCatagory;
        _selectedSubcatagory = null;
      });
    }
  }

  void dropDownSubcatagoryCallBack(String? selectedSubcatagory) {
    if (selectedSubcatagory is String) {
      setState(() {
        _selectedSubcatagory = selectedSubcatagory;
      });
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
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
      String catagory, String subcatagory, String inputdate, String expdate) {
    setState(() {
      IDB.loadData();
      IDB.ingredientsList.add([catagory, subcatagory, inputdate, expdate]);
    });
    IDB.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _selectedCatagory = null;
          _selectedSubcatagory = null;
          _dateTime = null;
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: const Text("Add Ingredients",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        "Catagory",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: DropdownButtonFormField<String>(
                    items: CDB.catagoryList.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                    value: _selectedCatagory,
                    onChanged: dropDownCallBack,
                    isExpanded: true,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    dropdownColor: Colors.grey.shade300,
                    decoration: const InputDecoration(
                      hintText: "Select Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                if (_selectedCatagory != null)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          "Subcatagory",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                if (_selectedCatagory != null)
                  Container(
                    child: DropdownButtonFormField<String>(
                      items:
                          CDB.subCategoryMap[_selectedCatagory]?.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList() ??
                              [],
                      value: _selectedSubcatagory,
                      onChanged: dropDownSubcatagoryCallBack,
                      isExpanded: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      dropdownColor: Colors.grey.shade300,
                      decoration: const InputDecoration(
                        hintText: "Select Subcategory",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (_selectedSubcatagory != null &&
                    _selectedSubcatagory ==
                        CDB.subCategoryMap[_selectedCatagory]?.last)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          "Name",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                if (_selectedSubcatagory != null &&
                    _selectedSubcatagory ==
                        CDB.subCategoryMap[_selectedCatagory]?.last)
                  Column(
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
                                _addToSubcatagory = false;
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Checkbox(
                            value:
                                _addToSubcatagory && _ingredientName.isNotEmpty,
                            onChanged: _ingredientName.isNotEmpty
                                ? (value) {
                                    if (value != null) {
                                      setState(
                                        () {
                                          _addToSubcatagory = value;
                                        },
                                      );
                                    }
                                  }
                                : null,
                            activeColor: Colors.blueGrey,
                          ),
                          const Text("Add to Subcatagory"),
                        ],
                      )
                    ],
                  ),
                if (_selectedSubcatagory != null)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          "Expire Date",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                if (_selectedSubcatagory != null)
                  Row(
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
                  ),
              ],
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: Padding(
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
                      _selectedCatagory = null;
                      _selectedSubcatagory = null;
                      _dateTime = null;
                    });
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel, color: Colors.white),
                  label: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                  elevation: 0,
                ),
              ),
              Visibility(
                visible: _selectedSubcatagory != null && _dateTime != null,
                child: const SizedBox(width: 40.0),
              ),
              Visibility(
                visible: _selectedSubcatagory != null && _dateTime != null,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      setState(
                        () {
                          addData(
                            _selectedCatagory!,
                            _ingredientName.isNotEmpty
                                ? _ingredientName
                                : _selectedSubcatagory!,
                            DateFormat('yyyy/MM/dd').format(DateTime.now()),
                            DateFormat('yyyy/MM/dd').format(_dateTime!),
                          );
                          if (_addToSubcatagory && _ingredientName.isNotEmpty) {
                            List<String>? subCategoryList =
                                CDB.subCategoryMap[_selectedCatagory!];
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
                          _selectedCatagory = null;
                          _selectedSubcatagory = null;
                          _dateTime = null;
                          Navigator.pop(
                            context,
                            true,
                          );
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
        ),
      ),
    );
  }
}
