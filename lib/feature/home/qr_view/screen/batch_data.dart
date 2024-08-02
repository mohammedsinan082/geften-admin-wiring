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
  Map<String, String> _batchCableTypes = {};
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  bool _hasMore = true;
  int _batchSize = 10;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchBatches(isNext: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && _hasMore) {
        _fetchBatches(isNext: true);
      }
    });
  }

  Future<void> _fetchBatches({required bool isNext}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    Query query = _firestore.collection('qr_batches').limit(_batchSize);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isEmpty) {
      setState(() {
        _hasMore = false;
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _batches.addAll(querySnapshot.docs);
      _lastDocument = querySnapshot.docs.last;
      _isLoading = false;
    });

    _fetchAllBatchStatusPercentages(querySnapshot.docs);
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

    String cableType = 'Unknown';
    for (var doc in querySnapshot.docs) {
      String status = doc['ScanStatus'];
      if (status == 'Hold') {
        holdCount++;
      } else if (status == 'Ready to Scan') {
        readyToScanCount++;
      } else if (status == 'Scanned') {
        scannedCount++;
      }

      // Fetch RewardPoint and Loyaltyint to determine cable type
      int rewardPoint = doc['RewardPoint'];
      int loyaltyInt = doc['Loyaltyint'];

      if (rewardPoint == 20 && loyaltyInt == 0) {
        cableType = 'White Cable';
      } else if (rewardPoint == 30 && loyaltyInt == 1) {
        cableType = 'Green Cable';
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
      _batchCableTypes[batchId] = cableType;
    });
  }

  void _viewBatchDetails(DocumentSnapshot batch) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrViewDataTable(batchId: batch.id)),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              controller: _scrollController,
              itemCount: _batches.length + (_hasMore ? 1 : 0), // Add one for the loading indicator
              itemBuilder: (context, index) {
                if (index == _batches.length) {
                  return Center(child: CircularProgressIndicator());
                }

                var batch = _batches[index];
                var percentages = _batchStatusPercentages[batch.id] ?? {'Hold': 0.0, 'Ready to Scan': 0.0, 'Scanned': 0.0};
                var cableType = _batchCableTypes[batch.id] ?? 'Unknown';
                return Column(
                  children: [
                    ListTile(
                      title: Text('${batch.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hold: ${percentages['Hold']?.toStringAsFixed(1)}%,        '
                                'Ready to Scan: ${percentages['Ready to Scan']?.toStringAsFixed(1)}%,         '
                                'Scanned: ${percentages['Scanned']?.toStringAsFixed(1)}%',
                          ),
                          Text('Cable Type: $cableType', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      onTap: () => _viewBatchDetails(batch),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
          if (_isLoading && _batches.isEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
