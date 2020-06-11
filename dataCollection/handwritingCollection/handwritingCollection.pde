Canvas canvas;
Button save;
Button reset;

int timeKeeper = 0;

void setup() {
  size(700, 700);
  background(255);
  canvas = new Canvas(100, 100, 500, 500);
  registerMethod("mouseEvent", canvas);
  save = new Button(550, 50, 50, 25, "Save");
  save.display();
  reset = new Button(100, 50, 50, 25, "Reset", color(255, 50, 50));
  reset.display();
  println("Initialized");
}

void draw() {
  if (reset.clicked()) {
    canvas.reset();
  }
  if (save.clicked()) {
    // 連続保存防止のため2secあける
    if (millis() - timeKeeper > 2000) {
      saveStrokes();
    }
  }
}

void saveStrokes() {
  if (canvas.strokes.size() != 0) {
    CharStroke chSt = new CharStroke("");
    chSt.setStrokes(canvas.strokes);
    String filename = "save/handwriting_data_" + time2str();
    chSt.saveStrokes(filename);
    println("Saved");
    timeKeeper = millis();
  }
}

String time2str() {
  return str(year())+str(month())+str(day()) + "_" + str(hour()) + str(minute()) + str(second());
}
