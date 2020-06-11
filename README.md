# average-character-processing
 - 指定ファイル内の手書きjsonデータを平均化するプログラム

## usage
1. dataフォルダ内に平均化する文字群ごとまとめたフォルダを置く
2. プログラムを起動し実行する
3. 結果が`save`内に保存される

## 平均化のためのフォルダ構成例
 - `data`
   - `pair1`
     - `1.json`
     - `2.json`
   - `pair2`
     - `3.json`
     - `4.json`
     - `5.json`
  
`sample_data`のフォルダを参考に

## サンプルの実行
`avgCharStrokesFromJSON.pde`の12行目の`path`を`sample_data`に変えて実行

## 補足
### 出力画像の画像サイズが合わない場合
`Config.pde`内の`canvasWidth`及び`canvasHeight`を調整してください  


author: [ni-no](https://github.com/ni-no)