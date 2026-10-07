import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height / 4.5,
                width: size.width / 1.5,
                margin: EdgeInsets.all(10),
                color: Colors.black38,
                child: Image.network(fit: BoxFit.cover, 'https://placehold.co/600x400.png'),
              ),
              Positioned(
                  bottom: 45,
                  left: 30,
                  child: Text("HAPPY DASHIANNNNN!!!",
                overflow: TextOverflow.ellipsis, maxLines: 2,
                style: TextStyle(color: Colors.amber, fontSize: 18),
              )),
              Positioned(
                  bottom: 20,
                  left: 30,
                  child: Text("2026/10/7",
                    style: TextStyle(color: Colors.amber, fontSize: 18),
                  )
              ),

            ],
          )
        ],
      )
    );
  }
}