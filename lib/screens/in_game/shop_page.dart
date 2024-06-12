import 'package:flutter/material.dart';
import '../../components/transport_option.dart';

class ShopPage extends StatelessWidget {
  final List<TransportOption> transportOptions = [
    TransportOption(
      name: 'Train',
      icon: Icons.train,
      description: 'Fast and reliable train service.',
      price: 10.0,
      validDuration: '1 Day',
    ),
    TransportOption(
      name: 'Bus',
      icon: Icons.directions_bus,
      description: 'Comfortable city buses.',
      price: 5.0,
      validDuration: '1 Day',
    ),
    TransportOption(
      name: 'Taxi',
      icon: Icons.local_taxi,
      description: 'Convenient taxi service.',
      price: 20.0,
      validDuration: '1 Hour',
    ),
    TransportOption(
    name: 'Subway', 
    icon: Icons.subway_outlined, 
    description: '5min of riding subway system', 
    price: 10.0, 
    validDuration: '5min')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Public Transports',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemCount: transportOptions.length,
                itemBuilder: (context, index) {
                  final transport = transportOptions[index];
                  return GestureDetector(
                    onTap: () {
                      _showTransportDetails(context, transport);
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            transport.icon,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            transport.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Challenges',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Add your Challenge widgets here
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Curses',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Add your Course widgets here
          ],
        ),
      ),
    );
  }

  void _showTransportDetails(BuildContext context, TransportOption transport) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${transport.name} Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(transport.description),
              SizedBox(height: 10),
              Text('Price: \$${transport.price}'),
              SizedBox(height: 10),
              Text('Valid Duration: ${transport.validDuration}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the buy action
                Navigator.of(context).pop();
              },
              child: Text('Buy'),
            ),
          ],
        );
      },
    );
  }
}
