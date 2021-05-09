import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LangaugeDropdown extends StatelessWidget {
  const LangaugeDropdown({
    Key key,
    @required this.value,
    @required this.onChange,
  }) : super(key: key);

  final String value;
  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      value: value,
      // isExpanded: true
      items: <String>['ar', 'en', 'fa']
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    if (value == 'ar')
                      CachedNetworkImage(
                        imageUrl: 'https://www.countryflags.io/sa/shiny/64.png',
                        width: 40,
                      ),
                    if (value == 'en')
                      CachedNetworkImage(
                        imageUrl: 'https://www.countryflags.io/us/shiny/64.png',
                        width: 40,
                      ),
                    if (value == 'fa')
                      CachedNetworkImage(
                        imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Flag_of_Kurdistan.svg/280px-Flag_of_Kurdistan.svg.png',
                        width: 40,
                      ),
                    SizedBox(width: 10),
                    Text(value.toUpperCase().tr()),
                  ],
                ),
              ))
          .toList(),
      onChanged: onChange,
    );
  }
}
