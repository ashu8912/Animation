import "package:flutter/material.dart";

class FilterOptions extends StatefulWidget {
  @override
  _FilterOptionsState createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _textLeftPaddingAnimation;
  Animation<double> _closeIconAnimation; 
  Animation<double> _textRightPaddingAnimation;
  Animation<double> _dotLeftPositionAnimation;
  Animation<double> _dotTopPositionAnimation;
  Animation<double> _dotHeightAnimation;
  Animation<Color> _colorAnimation;
  final GlobalKey _parentContainer=GlobalKey(debugLabel:"parent_container");
  bool get _animationStatus{
    AnimationStatus _animationStatus=_controller.status;
    return _animationStatus==AnimationStatus.completed;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=AnimationController(vsync: this,duration:Duration(milliseconds: 400));
    _textLeftPaddingAnimation=Tween<double>(begin: 40.0,end:20.0).animate(_controller);
    _closeIconAnimation=Tween<double>(begin:0.0,end:1.0).animate(_controller);
    _textRightPaddingAnimation=Tween<double>(begin:20.0,end:40.0).animate(_controller);
    _dotLeftPositionAnimation=Tween<double>(begin:10.0,end:0.0).animate(_controller);
    _dotTopPositionAnimation=Tween<double>(begin:8.0,end:0.0).animate(_controller);
    _dotHeightAnimation=Tween<double>(begin:20.0,end:40.0).animate(_controller);
    _colorAnimation=ColorTween(begin:Colors.black,end:Colors.black).animate(_controller);
  }
  Animation<double> getWidthOfDot(){
    var width=20.0;
    if(_parentContainer.currentContext!=null)
    {RenderBox _renderBox=_parentContainer.currentContext.findRenderObject();
     width=_renderBox.size.width-2;
    }
    return Tween(begin: 20.0,end:width).animate(_controller);
  }
   Widget getWidget(BuildContext ctx,Widget widget){
     return Center(
      child: InkWell(
        onTap: () {
            print(_animationStatus);
          _animationStatus?_controller.reverse():_controller.forward();
        },
        child: Container(
          key:_parentContainer,
          height: 40.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: _dotLeftPositionAnimation.value,
                top: _dotTopPositionAnimation.value,
                child: Container(
                  height: _dotHeightAnimation.value,
                  width: getWidthOfDot().value,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
              ),
              Align(
                  widthFactor: 1.0,
                  alignment: Alignment.center,
                  child: Container(
                    child: Text("Filter Unselected",style:TextStyle(color: _colorAnimation.value,fontSize: 21)),
                    padding: EdgeInsets.only(left: _textLeftPaddingAnimation.value, right: _textRightPaddingAnimation.value),
                  )),
              Positioned(
                  right: 6.0,
                  top: 8.0,
                  child: ScaleTransition(
                        scale:_closeIconAnimation,
                        child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20.0,
                        )),
                  ))
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1.0),
              borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
    );
   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(builder: getWidget,animation:_controller);
  }
}
