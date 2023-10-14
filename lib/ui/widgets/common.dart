import 'package:flutter/material.dart';

enum SpaceType{
  el,
  l,
  m,
  s,
  es
}
class VerticalSpace extends StatelessWidget {
  final SpaceType  spaceType;
  const VerticalSpace({
    super.key, required this.spaceType,
  });

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.sizeOf(context).height;
    var div=9;
    if(spaceType==SpaceType.el){
      div=9;
    } if(spaceType==SpaceType.l){
      div=12;
    } if(spaceType==SpaceType.m){
      div=55;
    } if(spaceType==SpaceType.es){
      div=95;
    }
    if(spaceType==SpaceType.s){
      div=65;
    }

    return SizedBox(height:h /div,);
  }
}

class HorizontalSpace extends StatelessWidget {
  final SpaceType  spaceType;
  const HorizontalSpace({
    super.key, required this.spaceType,
  });

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.sizeOf(context).height;
    var div=1;
    if(spaceType==SpaceType.el){
      div=9;
    } if(spaceType==SpaceType.l){
      div=12;
    } if(spaceType==SpaceType.m){
      div=45;
    } if(spaceType==SpaceType.s){
      div=50;
    }
    if(spaceType==SpaceType.es){
      div=45;
    }

    return SizedBox(width:h /div,);
  }
}
