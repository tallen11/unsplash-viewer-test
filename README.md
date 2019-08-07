# unsplash-viewer-test
A simple Swift app that loads and displays images from Unsplash in a UICollectionView.

This was an experiment with collection views, REST API consumption and lazily loading images for each collection view cell using NSOperations.

In order to run, you'll need to first create a file called Keys.swift inside API/ with the following contents:

``` Swift
struct Keys {
  static let accessKey = "<YOUR-UNSPLASH-ACCESS-KEY>"
}
```

The app will load 30 random image thumbnails from Unsplash. New random images will be fetched on each refresh.
