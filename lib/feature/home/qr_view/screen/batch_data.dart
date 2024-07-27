import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gefmartwiringadmin/feature/home/qr_view/screen/qr_viewData.dart';

class BatchListPage extends StatefulWidget {
  @override
  _BatchListPageState createState() => _BatchListPageState();
}

class _BatchListPageState extends State<BatchListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _batches = [];
  Map<String, Map<String, double>> _batchStatusPercentages = {};
  DocumentSnapshot? _lastDocument;
  DocumentSnapshot? _firstDocument;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _canGoBack = false;
  int _batchSize = 10;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _fetchBatches(isNext: true);
  }

  Future<void> _fetchBatches({required bool isNext}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    Query query = _firestore.collection('qr_batches').limit(_batchSize);

    if (!isNext && _firstDocument != null) {
      query = query.endBeforeDocument(_firstDocument!);
    } else if (isNext && _lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isEmpty) {
      setState(() {
        if (isNext) {
          _hasMore = false;
        } else {
          _canGoBack = false;
        }
        _isLoading = false;
      });
      return;
    }

    setState(() {
      if (isNext) {
        _firstDocument = querySnapshot.docs.first;
        _batches = querySnapshot.docs;
        _lastDocument = querySnapshot.docs.last;
        _canGoBack = true;
        _currentPage += 1;
      } else {
        _firstDocument = querySnapshot.docs.first;
        _batches = querySnapshot.docs.reversed.toList();
        _lastDocument = querySnapshot.docs.last;
        _hasMore = true;
        _currentPage -= 1;
      }
      _isLoading = false;
    });

    _fetchAllBatchStatusPercentages(_batches);
  }

  void _fetchAllBatchStatusPercentages(List<DocumentSnapshot> batchDocs) async {
    for (var batch in batchDocs) {
      await _fetchBatchStatusPercentages(batch.id);
    }
  }

  Future<void> _fetchBatchStatusPercentages(String batchId) async {
    QuerySnapshot querySnapshot = await _firestore.collection('qr_batches').doc(batchId).collection('qrLists').get();
    int total = querySnapshot.docs.length;
    int holdCount = 0;
    int readyToScanCount = 0;
    int scannedCount = 0;

    for (var doc in querySnapshot.docs) {
      String status = doc['ScanStatus'];
      if (status == 'Hold') {
        holdCount++;
      } else if (status == 'Ready to Scan') {
        readyToScanCount++;
      } else if (status == 'Scanned') {
        scannedCount++;
      }
    }

    double holdPercentage = (holdCount / total) * 100;
    double readyToScanPercentage = (readyToScanCount / total) * 100;
    double scannedPercentage = (scannedCount / total) * 100;

    setState(() {
      _batchStatusPercentages[batchId] = {
        'Hold': holdPercentage,
        'Ready to Scan': readyToScanPercentage,
        'Scanned': scannedPercentage,
      };
    });
  }

  void _viewBatchDetails(DocumentSnapshot batch) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrViewDataTable(batchId: batch.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batch List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _batches.length,
              itemBuilder: (context, index) {
                var batch = _batches[index];
                var percentages = _batchStatusPercentages[batch.id] ?? {'Hold': 0.0, 'Ready to Scan': 0.0, 'Scanned': 0.0};
                return Column(
                  children: [
                    ListTile(
                      title: Text('${batch.id}'),
                      subtitle: Text(
                        'Hold: ${percentages['Hold']?.toStringAsFixed(1)}%,        '
                            'Ready to Scan: ${percentages['Ready to Scan']?.toStringAsFixed(1)}%,         '
                            'Scanned: ${percentages['Scanned']?.toStringAsFixed(1)}%',
                      ),
                      onTap: () => _viewBatchDetails(batch),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_canGoBack)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _fetchBatches(isNext: false),
                    child: Text('Prev'),
                  ),
                ),
              Spacer(),
              Text('Page $_currentPage'),
              Spacer(),
              if (_hasMore)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _fetchBatches(isNext: true),
                    child: Text('Next'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
