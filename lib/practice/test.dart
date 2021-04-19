import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(widget.title),
      body: new Center(
        child: new Column(
          children: [
            Text('Router'),
            ElevatedButton(
                child: Text('Route'),
                onPressed: () => Navigator.of(context)
                    .pushNamed('new_route', arguments: '123123')),
            ElevatedButton(
                child: Text('login'),
                onPressed: () => Navigator.of(context).pushNamed('login')),
            ElevatedButton(
                child: Text('trans'),
                onPressed: () => Navigator.of(context).pushNamed('trans')),
            ElevatedButton(
                child: Text('scroll'),
                onPressed: () => Navigator.of(context).pushNamed('scroll')),
            ElevatedButton(
                child: Text('MyAsyncUi'),
                onPressed: () => Navigator.of(context).pushNamed('MyAsyncUi')),
            ElevatedButton(
                child: Text('MyPress'),
                onPressed: () => Navigator.of(context).pushNamed('MyPress')),
            ElevatedButton(
                child: Text('MyGesture'),
                onPressed: () => Navigator.of(context).pushNamed('MyGesture')),
            ElevatedButton(
                child: Text('MyAniTran'),
                onPressed: () => Navigator.of(context).pushNamed('MyAniTran')),
          ],
        ),
      ),
    );
  }
}
