import 'package:flutter/material.dart';

class OtherCitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'other city'.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  fontFamily: 'flutterfonts',
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'forecast next 5 days'.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
              ),
              Icon(
                Icons.next_plan_outlined,
                color: Colors.black45,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
