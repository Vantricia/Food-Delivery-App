import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/admin/receipt_page.dart';

class OrdersTable extends StatefulWidget {
  final List<Map<String, dynamic>> orders;
  final Function(String) handleDelete;

  OrdersTable({super.key, required this.orders, required this.handleDelete});

  @override
  _OrdersTableState createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
  late Map<String, String?> _selectedDrivers;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSelectedDrivers();
    _sortOrdersByDate();
  }

  void _sortOrdersByDate() {
    widget.orders.sort((a, b) {
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);
      return dateB.compareTo(dateA); // Sort by date in descending order
    });
  }

  Future<void> _initializeSelectedDrivers() async {
    _selectedDrivers = {for (var order in widget.orders) order['id']: null};

    for (var order in widget.orders) {
      var orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(order['id'])
          .get();
      if (orderSnapshot.exists) {
        setState(() {
          _selectedDrivers[order['id']] =
              orderSnapshot.data()?['driver'] ?? 'Bill';
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _updateDriver(String orderId, String newDriver) {
    setState(() {
      _selectedDrivers[orderId] = newDriver;
    });
    FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'driver': newDriver,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              dividerThickness: 0,
              dataRowMaxHeight: double.infinity,
              columnSpacing: 16.0,
              columns: const [
                DataColumn(
                  label: Text('Date',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Email',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Location',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Total Item',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Total Price',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Receipt',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Driver',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Actions',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              rows: widget.orders.map((order) {
                return DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      }
                      if (widget.orders.indexOf(order) % 2 == 0) {
                        return Colors.grey.withOpacity(0.1);
                      }
                      return null;
                    },
                  ),
                  cells: [
                    DataCell(SizedBox(
                      width: 100, // Adjust width to fit the content
                      child: Text(order['date'] ?? '',
                          style: const TextStyle(fontSize: 14)),
                    )),
                    DataCell(SizedBox(
                      width: 150, // Adjust width to fit the content
                      child: Text(order['email'] ?? '',
                          style: const TextStyle(fontSize: 14)),
                    )),
                    DataCell(SizedBox(
                      width: 150, // Adjust width to fit the content
                      child: Text(order['location'] ?? '',
                          style: const TextStyle(fontSize: 14)),
                    )),
                    DataCell(SizedBox(
                      width: 100, // Adjust width to fit the content
                      child: Text(order['totalItem']?.toString() ?? '0',
                          style: const TextStyle(fontSize: 14)),
                    )),
                    DataCell(SizedBox(
                      width: 100, // Adjust width to fit the content
                      child: Text(order['total'],
                          style: const TextStyle(fontSize: 14)),
                    )),
                    DataCell(
                      IconButton(
                        icon: const Icon(
                          Icons.receipt,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReceiptPage(orderId: order['id']),
                            ),
                          );
                        },
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          Text(_selectedDrivers[order['id']] ?? 'Bill'),
                          IconButton(
                            icon: const Icon(Icons.arrow_drop_down),
                            onPressed: () async {
                              String? selectedDriver = await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: const Text('Select Driver'),
                                    children: ['Bill', 'Bob', 'Bot']
                                        .map((String value) {
                                      return SimpleDialogOption(
                                        onPressed: () {
                                          Navigator.pop(context, value);
                                        },
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  );
                                },
                              );
                              if (selectedDriver != null) {
                                _updateDriver(order['id'], selectedDriver);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => widget.handleDelete(order['id']),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
