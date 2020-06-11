
class PointF {
  float x;
  float y;
  PointF() { 
    x = 0.0; 
    y = 0.0;
  }
  PointF( float _x, float _y ) { 
    x = _x; 
    y = _y;
  }
  void show(){
    println( "(x,y)=", x, y );
  }
}