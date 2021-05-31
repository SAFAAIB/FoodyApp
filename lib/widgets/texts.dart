import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

textTitle(String text){
  return Text(
    text,
    style: GoogleFonts.breeSerif(
        fontSize: SizeConfig.scaleTextFont(36),
        fontWeight: FontWeight.w900,
        color: Colors.black),
  );
}

textSubTitle(String text , double height){
  return Padding(
    padding: EdgeInsetsDirectional.only(
      top: SizeConfig.scaleHeight(8),
      bottom: SizeConfig.scaleHeight(8)
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: SizeConfig.scaleTextFont(16),
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        height: SizeConfig.scaleHeight(height),
      ),

    ),
  );
}

textTitle2(String text , Color color){
  return Padding(
    padding: EdgeInsetsDirectional.only(
        bottom: SizeConfig.scaleHeight(8),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: SizeConfig.scaleTextFont(24),
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}