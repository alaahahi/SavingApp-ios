import 'package:flutter/material.dart';

class RemoteList<T> extends StatelessWidget {
  RemoteList({
    Key key,
    @required this.future,
    @required this.filler,
    @required this.ifEmpty,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  final Future<List<T>> future;
  final Widget Function(T) filler;
  final Widget ifEmpty;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return renderLoader();
        }

        if (snapshot.hasError) {
          return renderError(snapshot);
        }

        if (snapshot.hasData && snapshot.data.length > 0) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(width: 30),
            padding: EdgeInsets.symmetric(horizontal: 40),
            scrollDirection: scrollDirection,
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => filler(snapshot.data[index]),
          );
        }

        return ifEmpty;
      },
    );
  }

  Center renderLoader() => Center(child: CircularProgressIndicator());

  Padding renderError(AsyncSnapshot<List> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 10),
          Text(
            snapshot.error.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
