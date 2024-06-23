import 'package:flutter/material.dart';
import '../../components/transport_option.dart';

class ShopPage extends StatelessWidget {
  final List<TransportOption> transportOptions = [
    TransportOption(
      name: 'Bus',
      icon: Icons.directions_bus_outlined,
      description: '5min of riding bus system',
      price: 5.0,
      validDuration: '5 min',
    ),
    TransportOption(
      name: 'Tram',
      icon: Icons.tram_outlined,
      description: '10min of riding tram system',
      price: 10.0,
      validDuration: '10 min',
    ),
    TransportOption(
      name: 'Subway',
      icon: Icons.subway_outlined,
      description: '5min of riding subway system',
      price: 10.0,
      validDuration: '5min',
    ),
    TransportOption(
      name: 'Suburban Train',
      icon: Icons.directions_subway_outlined,
      description: '10min of riding suburban train system',
      price: 10.0,
      validDuration: '10 min',
    ),
    TransportOption(
      name: 'Train',
      icon: Icons.train_outlined,
      description: '20min of riding train system',
      price: 10.0,
      validDuration: '20 min',
    ),
    TransportOption(
      name: 'E-Scooter/Bike',
      icon: Icons.bike_scooter_outlined,
      description: '10min of riding e-scooter/bike',
      price: 10.0,
      validDuration: '10 min',
    ),
    TransportOption(
      name: 'Taxi',
      icon: Icons.local_taxi_outlined,
      description: '10min of riding taxi system',
      price: 20.0,
      validDuration: '10 min',
    ),
    TransportOption(
      name: 'Ferry',
      icon: Icons.directions_boat_outlined,
      description: '30min on a ferry',
      price: 10.0,
      validDuration: '30min',
    )
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
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Public Transports',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 130,
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
                      width: 130,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            transport.icon,
                            size: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),Center(
                            child: Text(
                              transport.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Challenges',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Add your Challenge widgets here
            const Padding(
              padding: EdgeInsets.all(10.0),
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
              const SizedBox(height: 10),
              Text('Price: \$${transport.price}'),
              const SizedBox(height: 10),
              Text('Valid Duration: ${transport.validDuration}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the buy action
                Navigator.of(context).pop();
              },
              child: const Text('Buy'),
            ),
          ],
        );
      },
    );
  }
}
