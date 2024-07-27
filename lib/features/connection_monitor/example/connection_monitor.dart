import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:antinna_ui_kit/antinna_ui_kit.dart';
import 'package:flutter/widgets.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return ConnectivityBannerHost(
            isConnected: isConnected,
            banner: Material(
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Text(
                  'No Internet Connection',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            child: child!);
      },
      home: Scaffold(
        // bottomNavigationBar: BottomAppBar(
        //   height: 80,
        // ),
        body: ConnectionMonitor(
          child: ConnectivityBannerHost(
            isConnected: isConnected,
            banner: Material(
              color: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 14,
                          width: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.green)),
                      Text(
                        'No Internet Connection',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("SignUp"),
                          Text("Long Heading"),
                          EditableText(
                              controller: TextEditingController(),
                              focusNode: FocusNode(),
                              style: TextStyle(color: Colors.red, fontSize: 10),
                              cursorColor: Colors.black,
                              backgroundCursorColor: Colors.green),
                          EditableText(
                              controller: TextEditingController(),
                              focusNode: FocusNode(),
                              style: TextStyle(color: Colors.red, fontSize: 10),
                              cursorColor: Colors.black,
                              backgroundCursorColor: Colors.green),
                          EditableText(
                              controller: TextEditingController(),
                              focusNode: FocusNode(),
                              style: TextStyle(color: Colors.red, fontSize: 10),
                              cursorColor: Colors.black,
                              backgroundCursorColor: Colors.green),
                          EditableText(
                              controller: TextEditingController(),
                              focusNode: FocusNode(),
                              style: TextStyle(color: Colors.red, fontSize: 10),
                              cursorColor: Colors.black,
                              backgroundCursorColor: Colors.green),
                          EditableText(
                              controller: TextEditingController(),
                              focusNode: FocusNode(),
                              style: TextStyle(color: Colors.red, fontSize: 10),
                              cursorColor: Colors.black,
                              backgroundCursorColor: Colors.green),
                          EditableText(
                              controller: TextEditingController(),
                              focusNode: FocusNode(),
                              style: TextStyle(color: Colors.red, fontSize: 10),
                              cursorColor: Colors.black,
                              backgroundCursorColor: Colors.green)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isConnected = !isConnected;
                  });
                },
                child: Text(isConnected ? 'Disconnect' : 'Connect'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class ConnectionMonitor extends StatefulWidget {
  const ConnectionMonitor({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ConnectionMonitor> createState() => _ConnectionMonitorState();
}

class _ConnectionMonitorState extends State<ConnectionMonitor> {
  late final _connectivity = _connectivityStream();

  Stream<ConnectivityResult> _connectivityStream() async* {
    final connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();
    yield result.first;
    yield* connectivity.onConnectivityChanged
        .expand((results) => results); // Flatten the stream
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _connectivity,
      builder:
          (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return widget.child;
        }
        final result = snapshot.requireData;
        return ConnectivityBannerHost(
          isConnected: result != ConnectivityResult.none,
          banner: const Material(
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
              child: Text(
                'Please check your internet connection',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
