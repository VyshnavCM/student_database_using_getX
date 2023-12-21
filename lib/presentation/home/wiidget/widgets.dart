import 'package:flutter/material.dart';

import '../../../core/color/colors.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: kButtonColor,
      label:const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.person_add_alt_1_rounded,color: kWhiteColor,),
          ),
          Text('Add student',style: TextStyle(color: kWhiteColor),)
        ],
      ),
      
      onPressed: () {},
    
    );
  }
}