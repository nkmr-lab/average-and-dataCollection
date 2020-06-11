class Chara {
  String name;
  int numOfStroke;

  Chara(String _name, int _stroke) {
    name = _name;
    numOfStroke = _stroke;
  }
}

class Pair {
  int x;
  int y;

  Pair() {
    x = 0;
    y = 0;
  }

  Pair(int _x, int _y) {
    x = _x;
    y = _y;
  }

  Pair randomPair(int _min1, int _max1, int _min2, int _max2) {
    return new Pair(int(random(_min1, _max1)), int(random(_min2, _max2)));
  }

  Pair randomPairNoDuplicate(Pair []_p, int _min1, int _max1, int _min2, int _max2) {
    // 被りを排除したrandomアルゴリズム(厳密にはrandomでもない)
    Pair newPair = randomPair(_min1, _max1, _min2, _max2);

    // 被りなければそのまま通す
    if (!isDuplicate(_p, newPair)) return newPair;

    // x, yどっちが多くのペアで使われてるか調べる
    Pair count = new Pair();
    for (Pair pair : _p) {
      if (pair.x == newPair.x) count.x++;
      if (pair.y == newPair.y) count.y++;
    }
    // 多い方を変える(一緒の時はyを変える)
    if (count.x > count.y) {
      // xの方が多いのでxだけ変える
      int []index = new int[_max1-_min1-count.x];
      for (int i=0; i<_max1-_min1; i++) {
        if (!isDuplicate(_p, new Pair(i+_min1, newPair.y))) index = append(index, i+_min1);
      }
      newPair.x = index[int(random(index.length))];
      return newPair;
    }
    // yの方が多いのでyだけ変える
    int []index = new int[_max2-_min2-count.y];
    for (int i=0; i<_max2-_min2; i++) {
      if (!isDuplicate(_p, new Pair(newPair.x, i+_min2))) index = append(index, i+_min2);
    }
    newPair.y = index[int(random(index.length))];
    return newPair;
  }

  boolean isDuplicate(Pair []_pair, Pair _newPair) {
    for (Pair pair : _pair) {
      if (Objects.nonNull(pair)) {
        if (isSameX(pair, _newPair)&&isSameY(pair, _newPair)) return true;
      }
    }
    return false;
  }

  boolean isSameX(Pair _pair1, Pair _pair2) {
    return _pair1.x == _pair2.x;
  }

  boolean isSameY(Pair _pair1, Pair _pair2) {
    return _pair1.y == _pair2.y;
  }

  void printPair() {
    println("x: "+x+", y: "+y);
  }
}
