
// avgCharWithJSON by nino
// JSON形式のストローク情報を格納したファイルを読み込み,文字を数式化したり平均したりするシステム

// jsonToPointsでmagin分(50px)ずらして読み込んでいるので注意!!

import java.io.*;
import java.util.*;

/* Global settings */
boolean isSaveAsImage = true; // 画像として保存する場合はtrue
String path = ""; // dataの場合は"", サンプルの場合は"sample_data"

void setup() {
  ArrayList<String[]> toAverageGroups = loadTargetFiles(path);
  if (toAverageGroups != null) {
    println(toAverageGroups.size() + " groups found.");
    int index=1;
    for (String []toAverageGroup : toAverageGroups) {
      println("Processing... Task: "+index+"/"+toAverageGroups.size());
      CharStroke average = averageCharStrokesFromPaths(toAverageGroup);
      String name = extractGroupName(toAverageGroup[0]);
      average.saveStrokes("save/json/"+name+".json");
      if (isSaveAsImage) {
        saveAsImage(average, "save/img/"+name+".png");
      }
      index += 1;
    }
    println("All tasks completed.");
  }
  exit();
}



ArrayList<String[]> loadTargetFiles(String _parentPath) {
  /*
  平均化するグループごとにわけてファイルパスを取得
   */
  if (_parentPath != "") {
    // File APIの場合dataからの相対で指定する必要あり
    _parentPath = "../" + _parentPath;
  }
  ArrayList<String[]> targetFiles = new ArrayList();
  String []groups = (new File(dataPath(_parentPath))).list();
  if (Objects.isNull(groups)) {
    _parentPath += _parentPath == "" ? "data" : "";
    println("No files in "+_parentPath+" folder.");
    return null;
  }
  for (String group : groups) {
    String []figureNames =(new File(dataPath(_parentPath+"/"+group))).list();
    String []figurePaths = new String[figureNames.length];
    for (int i=0; i<figureNames.length; i++) {
      if (_parentPath == "") {
        figurePaths[i] = "data/"+group+"/"+figureNames[i];
      } else {
        // Processing側だと相対指定でバグるので../を削る
        figurePaths[i] = _parentPath.substring(3)+"/"+group+"/"+figureNames[i];
      }
    } 
    targetFiles.add(figurePaths);
  }
  return targetFiles;
}

CharStroke averageCharStrokesFromPaths(String []_toAverageFilepaths) {
  ArrayList<CharStroke> toAverageChars = new ArrayList();
  for (String filepath : _toAverageFilepaths) {
    toAverageChars.add(createCharStrokeFromJSON(filepath));
  }
  return getAverageCharStroke(toAverageChars);
}

String extractGroupName(String _path) {
  String []dirs = _path.split("/");
  return dirs[1];
}

void saveAsImage(CharStroke _charStroke, String _savePath) {
  PGraphics canvas = createCanvas(Config.canvasWidth, Config.canvasHeight);
  _charStroke.displayStrokeByFourierOnCanvas(Config.g_iMultiple, canvas, color(0, 0, 255));
  canvas.save(_savePath);
}

PGraphics createCanvas(int _width, int _height) {
  PGraphics canvas = createGraphics(_width, _height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  return canvas;
}
