import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/widgets/common/RemoteGridNList.dart';
import 'package:coupons/widgets/Items/DisplayMode.dart';
import 'package:coupons/widgets/Items/ListActionBar.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';
import 'package:flutter/material.dart';

class RemoteListNGridScaffold<T> extends StatefulWidget {
  const RemoteListNGridScaffold({
    Key key,
    this.title,
    this.photo,
    this.logo,
    this.future,
    this.filler,
    this.actions,
  }) : super(key: key);

  final String title, photo, logo;
  final Future<List<T>> future;
  final Widget Function(T, bool) filler;
  final List<Widget> actions;

  @override
  _RemoteListNGridScaffoldState createState() =>
      _RemoteListNGridScaffoldState<T>();
}

class _RemoteListNGridScaffoldState<T>
    extends State<RemoteListNGridScaffold<T>> {
  DisplayMode displayMode = DisplayMode.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: widget.title),
      body: ListView(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                imageUrl: widget.photo ?? widget.logo,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              if (widget.logo != null && widget.logo.isNotEmpty)
                Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: widget.logo,
                    height: 80,
                    width: 80,
                  ),
                ),
              if (widget.actions != null)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Column(children: widget.actions),
                ),
            ],
          ),
          Divider(color: Colors.grey.shade200),
          ListActionBar(
            displayMode: displayMode,
            changeDisplayMode: (DisplayMode d) {
              setState(() => displayMode = d);
            },
          ),
          SizedBox(height: 30),
          RemoteGridNList<T>(
            displayMode: displayMode,
            future: widget.future,
            filler: widget.filler,
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
