import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;
import 'dart:math';
import 'package:csv/csv.dart';
import '../../../../model/qr_batchmodel.dart';
import '../../../../model/qr_model.dart';

class QrGenerateDataTable extends StatefulWidget {
  @override
  QrGenerateDataTableState createState() => QrGenerateDataTableState();
}

class QrGenerateDataTableState extends State<QrGenerateDataTable> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> _allData = [];
  final List<Map<String, dynamic>> _filteredData = [];
  final Set<String> _generatedCodes = {};
  final Set<String> _existingCodes = {};
  int _rowsPerPage = 5;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  final ScrollController _scrollController = ScrollController();
  final Random _random = Random();
  bool _selectAll = false;
  String _selectedStatus = "All";
  bool _isDownloading = false;
  int _currentBatchNumber = 1;

  @override
  void initState() {
    super.initState();
    _initializeBatchNumber();
  }

  Future<void> _initializeBatchNumber() async {
    final querySnapshot = await _firestore.collection('qr_batches').get();
    setState(() {
      _currentBatchNumber = querySnapshot.docs.length + 1;
    });
    await _fetchExistingCodes();
  }

  Future<void> _fetchExistingCodes() async {
    final querySnapshot = await _firestore.collectionGroup('qrLists').get();
    for (var doc in querySnapshot.docs) {
      _existingCodes.add(doc.data()['QrNumber']);
    }
  }

  void _generateUniqueCodes(int count) {
    List<GenerateQrCodeModel> generatedCodes = [];
    List<String> eliminatedDuplicates = [];

    for (int i = 0; i < count; i++) {
      String uniqueCode;
      do {
        uniqueCode = _generateUniqueCode();
      } while (_generatedCodes.contains(uniqueCode) || _existingCodes.contains(uniqueCode));

      if (_generatedCodes.contains(uniqueCode) || _existingCodes.contains(uniqueCode)) {
        eliminatedDuplicates.add(uniqueCode);
      } else {
        _generatedCodes.add(uniqueCode);
        generatedCodes.add(
          GenerateQrCodeModel(
            id: uniqueCode,
            QrNumber: uniqueCode,
            ScanStatus: "Hold",
            RewardPoint: 0,
            Loyaltyint: 0,
            CreatedDate: DateTime.now(),
            ExportedDate: DateTime.now(),
            ExportStatus: false,
            ScannedDate: null,
          ),
        );
      }
    }

    setState(() {
      _allData.addAll(generatedCodes.map((e) => e.toMap()));
      _filterData();
    });

    if (eliminatedDuplicates.isNotEmpty) {
      _showDuplicatePopup(eliminatedDuplicates);
    }
  }

  String _generateUniqueCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(6, (index) => chars[_random.nextInt(chars.length)]).join();
  }

  Future<void> _showGenerateDialog() async {
    int? count;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Generate QR Codes'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter number of codes to generate'),
            onChanged: (value) {
              count = int.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                if (count != null && count! > 0) {
                  _generateUniqueCodes(count!);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDuplicatePopup(List<String> eliminatedDuplicates) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Duplicate Codes Eliminated'),
          content: SingleChildScrollView(
            child: ListBody(
              children: eliminatedDuplicates
                  .map((code) => Text('You have prevented duplicate code "$code"'))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectAllRows(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      for (var item in _filteredData) {
        item['selected'] = _selectAll;
      }
    });
  }

  void _filterData() {
    setState(() {
      if (_selectedStatus == "All") {
        _filteredData.clear();
        _filteredData.addAll(_allData);
      } else {
        _filteredData.clear();
        _filteredData.addAll(
          _allData.where((item) => item['ScanStatus'] == _selectedStatus).toList(),
        );
      }
    });
  }

  void _showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  int _getSelectedRowCount() {
    return _filteredData.where((item) => item['selected'] == true).length;
  }

  Future<void> _downloadCsv() async {
    if (_allData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No QR codes available to download')),
      );
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      List<Map<String, dynamic>> dataToSave = _allData.where((item) => item['ScanStatus'] == "Hold").toList();

      if (dataToSave.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No QR codes with status "Hold" to download')),
        );
        setState(() {
          _isDownloading = false;
        });
        return;
      }

      List<Map<String, dynamic>> uniqueData = await _removeDuplicates(dataToSave);

      if (uniqueData.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No unique QR codes to save')),
        );
        setState(() {
          _isDownloading = false;
        });
        return;
      }

      await _saveToFirebase(uniqueData);

      List<List<String>> csvData = [
        <String>['Qr Number'],
        ...uniqueData.map((item) => [item['QrNumber']]),
      ];

      String csv = const ListToCsvConverter().convert(csvData);

      final bytes = html.Blob([csv]);
      final url = html.Url.createObjectUrlFromBlob(bytes);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "qr_numbers.csv")
        ..click();
      html.Url.revokeObjectUrl(url);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('CSV file downloaded')),
      );

      setState(() {
        _allData.clear();
        _filteredData.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download CSV file: $e')),
      );
    }

    setState(() {
      _isDownloading = false;
    });
  }

  Future<List<Map<String, dynamic>>> _removeDuplicates(List<Map<String, dynamic>> dataToSave) async {
    Set<String> newCodes = dataToSave.map((item) => item['QrNumber'] as String).toSet();
    List<Map<String, dynamic>> uniqueData = [];
    List<String> eliminatedDuplicates = [];

    for (var item in dataToSave) {
      if (newCodes.contains(item['QrNumber'])) {
        uniqueData.add(item);
      }
    }

    final querySnapshot = await _firestore.collectionGroup('qrLists').get();
    for (var doc in querySnapshot.docs) {
      if (newCodes.contains(doc.data()['QrNumber'])) {
        eliminatedDuplicates.add(doc.data()['QrNumber']);
        newCodes.remove(doc.data()['QrNumber']);
      }
    }

    uniqueData = uniqueData.where((item) => newCodes.contains(item['QrNumber'])).toList();

    if (eliminatedDuplicates.isNotEmpty) {
      _showDuplicatePopup(eliminatedDuplicates);
    }

    return uniqueData;
  }

  Future<void> _saveToFirebase(List<Map<String, dynamic>> dataToSave) async {
    List<GenerateQrCodeModel> uniqueModels = dataToSave.map((data) {
      data['ExportStatus'] = true;
      return GenerateQrCodeModel.fromMap(data);
    }).toList();

    String batchId = 'Batch$_currentBatchNumber';
    final batchData = QrBatchmodel(
      batchId: batchId,
      createdDate: DateTime.now(),
      status: false,
      batchStatus: "Hold",
    ).toMap();

    await _firestore.collection('qr_batches').doc(batchId).set(batchData);

    for (var qrModel in uniqueModels) {
      await _firestore.collection('qr_batches').doc(batchId).collection('qrLists').doc(qrModel.id).set(qrModel.toMap()).then((value) {
        _firestore.collection('qr_batches').doc(batchId).collection('qrLists').doc(qrModel.id).update({
          "batchId": batchId
        });
      });
    }

    setState(() {
      _currentBatchNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedCount = _getSelectedRowCount();

    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _showGenerateDialog,
                  child: Text('Generate QR Codes'),
                ),
                DropdownButton<String>(
                  value: _selectedStatus,
                  items: ["All", "Hold", "Ready to Scan"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                      _filterData();
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _downloadCsv,
                  child: Text('Download CSV'),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: PaginatedDataTable(
                  header: Text('QR Codes Data'),
                  columns: [
                    DataColumn(
                      label: Checkbox(
                        value: _selectAll,
                        onChanged: _selectAllRows,
                      ),
                    ),
                    DataColumn(
                      label: Text('Qr Number'),
                      onSort: (int columnIndex, bool ascending) {
                        _sort<String>((Map<String, dynamic> d) => d['QrNumber'], columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: Text('Scan Status'),
                      onSort: (int columnIndex, bool ascending) {
                        _sort<String>((Map<String, dynamic> d) => d['ScanStatus'], columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: Text('Export Status'),
                      onSort: (int columnIndex, bool ascending) {
                        _sort<bool>((Map<String, dynamic> d) => d['ExportStatus'], columnIndex, ascending);
                      },
                    ),
                    DataColumn(label: Text('Exported Date')),
                    DataColumn(label: Text('Blank')),
                    DataColumn(label: Text('Blank')),
                    DataColumn(label: Text('Blank')),
                    DataColumn(label: Text('Blank')),
                  ],
                  source: _DataTableSource(_filteredData),
                  onRowsPerPageChanged: (int? value) {
                    setState(() {
                      _rowsPerPage = value ?? _rowsPerPage;
                    });
                  },
                  availableRowsPerPage: [5, 10, 15, 20],
                  rowsPerPage: _rowsPerPage,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  dataRowHeight: 100.0,
                  onPageChanged: (pageIndex) {
                    _scrollController.jumpTo(0);
                  },
                ),
              ),
            ),
          ],
        ),
        if (_isDownloading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  void _sort<T>(Comparable<T> Function(Map<String, dynamic> d) getField, int columnIndex, bool ascending) {
    _filteredData.sort((a, b) {
      if (!ascending) {
        final Map<String, dynamic> c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }
}

class _DataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> data;

  _DataTableSource(this.data);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= data.length) {
      return DataRow.byIndex(
        index: index,
        cells: List.generate(8, (_) => DataCell(Container())),
      );
    }
    final item = data[index];
    return DataRow.byIndex(
      index: index,
      selected: item['selected'] ?? false,
      onSelectChanged: (value) {
        item['selected'] = value ?? false;
        notifyListeners();
      },
      cells: [
        DataCell(Checkbox(
          value: item['selected'] ?? false,
          onChanged: (value) {
            item['selected'] = value ?? false;
            notifyListeners();
          },
        )),
        DataCell(Text(item['QrNumber'] ?? '')),
        DataCell(Text(item['ScanStatus'] ?? '')),
        DataCell(Text(item['ExportStatus'] == true ? 'Exported' : 'Not Exported')),
        DataCell(Text(item['ExportedDate']?.toString() ?? '')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => data.where((item) => item['selected'] == true).length;
}