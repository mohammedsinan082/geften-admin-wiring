import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/qr_batchmodel.dart';
import '../../../../model/qr_model.dart';

class QrViewDataTable extends StatefulWidget {
  @override
  _QrViewDataTableState createState() => _QrViewDataTableState();
}

class _QrViewDataTableState extends State<QrViewDataTable> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<GenerateQrCodeModel> _allData = [];
  final List<Map<String, dynamic>> _filteredData = [];
  int _rowsPerPage = 5;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  final ScrollController _scrollController = ScrollController();
  bool _selectAll = false;
  String _selectedStatus = "All";

  @override
  void initState() {
    super.initState();
    _streamQrCodes();
  }

  void _streamQrCodes() {
    _firestore.collectionGroup('qrLists').snapshots().listen((querySnapshot) {
      setState(() {
        _allData.clear();
        _allData.addAll(
          querySnapshot.docs.map((doc) {
            // print(doc.reference.parent.parent?.id);
            // print(doc.id);
            var data = doc.data();
            data['id'] = doc.id; // Include document ID for updates
            data['batchId'] =
                doc.reference.parent.parent?.id; // Include batch ID for updates
            return GenerateQrCodeModel.fromMap(data);
          }).toList(),
        );
        print(_allData);
        _filterData();
      });
    });
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
        _filteredData.addAll(_allData.map((model) => model.toMap()).toList());
      } else {
        _filteredData.clear();
        _filteredData.addAll(
          _allData
              .where((model) => model.ScanStatus == _selectedStatus)
              .map((model) => model.toMap())
              .toList(),
        );
      }
    });
  }

  void _showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _updateSelectedRowsStatus(String status) async {
    int selectedCount = _getSelectedRowCount();
    if (selectedCount == 0) {
      _showSnackBarMessage('No rows selected');
      return;
    }

    List<Map<String, dynamic>> selectedRows =
        _filteredData.where((item) => item['selected'] == true).toList();

    // Optimistically update UI
    setState(() {
      for (var item in selectedRows) {
        item['ScanStatus'] = status;
      }
      _filterData(); // Re-filter data to reflect changes
    });

    // Update Firestore
    for (var item in selectedRows) {
      // print(item['batchId']);
      // print(item['id']);
      if (item['batchId'] != null && item['id'] != null) {
        final qrDocRef = _firestore
            .collection('qr_batches')
            .doc(item['batchId'])
            .collection('qrLists')
            .doc(item['id']);
        try {
          await qrDocRef.update({'ScanStatus': status});
          print(
              "Successfully updated document ${item['id']} in batch ${item['batchId']} with status $status");
        } catch (e) {
          print(
              "Failed to update document ${item['id']} in batch ${item['batchId']}: $e");
          _showSnackBarMessage('Failed to update some rows');
        }
      } else {
        print("Missing batchId or id for item: $item");
      }
    }

    _showSnackBarMessage('Selected rows updated successfully');
  }

  int _getSelectedRowCount() {
    return _filteredData.where((item) => item['selected'] == true).length;
  }

  @override
  Widget build(BuildContext context) {
    int selectedCount = _getSelectedRowCount();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () async {
                String? selectedStatus = await _showStatusDialog(context);
                if (selectedStatus != null) {
                  _updateSelectedRowsStatus(selectedStatus);
                }
              },
              child: Text('Change Status'),
            ),
            DropdownButton<String>(
              value: _selectedStatus,
              items: ["All", "Hold", "Ready to Scan", "Scanned"]
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
                    _sort<String>((Map<String, dynamic> d) => d['QrNumber'],
                        columnIndex, ascending);
                  },
                ),
                DataColumn(
                  label: Text('Scan Status'),
                  onSort: (int columnIndex, bool ascending) {
                    _sort<String>((Map<String, dynamic> d) => d['ScanStatus'],
                        columnIndex, ascending);
                  },
                ),
                DataColumn(
                  label: Text('Reward Points'),
                  onSort: (int columnIndex, bool ascending) {
                    _sort<int>((Map<String, dynamic> d) => d['RewardPoint'],
                        columnIndex, ascending);
                  },
                ),
                DataColumn(
                  label: Text('Loyalty Points'),
                  onSort: (int columnIndex, bool ascending) {
                    _sort<int>((Map<String, dynamic> d) => d['Loyaltyint'],
                        columnIndex, ascending);
                  },
                ),
                DataColumn(label: Text('Created Date')),
                DataColumn(label: Text('Exported Date')),
                DataColumn(
                  label: Text('Export Status'),
                  onSort: (int columnIndex, bool ascending) {
                    _sort<bool>((Map<String, dynamic> d) => d['ExportStatus'],
                        columnIndex, ascending);
                  },
                ),
                DataColumn(label: Text('Scanned Date')),
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
              dataRowHeight: 100.0, // Increase the row height
              onPageChanged: (pageIndex) {
                _scrollController
                    .jumpTo(0); // Scroll to the top when page changes
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> _showStatusDialog(BuildContext context) {
    String? selectedStatus;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Scan Status'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                value: selectedStatus,
                items: ["Hold", "Ready to Scan", "Scanned"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue;
                  });
                },
              );
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
              child: Text('Change'),
              onPressed: () {
                Navigator.of(context).pop(selectedStatus);
              },
            ),
          ],
        );
      },
    );
  }

  void _sort<T>(Comparable<T> Function(Map<String, dynamic> d) getField,
      int columnIndex, bool ascending) {
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
        cells: List.generate(
            8, (_) => DataCell(Container())), // Create empty cells
      );
    }
    final item = data[index];
    return DataRow.byIndex(
      index: index,
      selected:
          item['selected'] ?? false, // Ensure default value for 'selected'
      onSelectChanged: (value) {
        item['selected'] = value ?? false;
        notifyListeners();
      },
      cells: [
        DataCell(Checkbox(
          value:
              item['selected'] ?? false, // Ensure default value for 'selected'
          onChanged: (value) {
            item['selected'] = value ?? false;
            notifyListeners();
          },
        )),
        DataCell(Text(item['QrNumber'] ?? '')),
        DataCell(Text(item['ScanStatus'] ?? '')),
        DataCell(Text(item['RewardPoint']?.toString() ?? '')),
        DataCell(Text(item['Loyaltyint']?.toString() ?? '')),
        DataCell(Text(item['CreatedDate']?.toString() ?? '')),
        DataCell(Text(item['ExportedDate']?.toString() ?? '')),
        DataCell(
            Text(item['ExportStatus'] == true ? 'Exported' : 'Not Exported')),
        DataCell(Text(item['ScannedDate']?.toString() ?? '')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount =>
      data.where((item) => item['selected'] == true).length;
}
