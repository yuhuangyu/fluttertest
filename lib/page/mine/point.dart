
class Point {
  int x;
  int y;

  Point(this.x, this.y);

  Point operator +(Point point) {
    return Point(x + point.x, y + point.y);
  }

  Point operator -(Point point) {
    return Point(x - point.x, y - point.y);
  }
}