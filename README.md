# KPKContacts (v1.2.0)

 This package was also created help a stranger's problem. He tried _billions_ of tutorials to try and chop an image up into four but kept deleting his code as none worked for him.
 I figured there's got to be a way to allow a new person coming into Swift to be able to chop up an image into as many equal quadrants as they like.
 I figured he probably wanted to chop up the image into four quadrants for a tile game. Then it struck me, why create a simple extension to chop an image into 4, why not a matrix?
 Right?
 And so the idea was born!
 
Here's what you can do with this package:

  - You can crop an image into a square
  - You can crop an image into as many quadrants as you like, by specifying the number of rows and columns, a matrix.
  
### Demo 
A demo is available which allows you:
  - to pick an image,
  - specify your matrix
  - and view your chopped up image into a nice collection view

### Installation

There isn't a cocoapod for this package as of today, didn't have the time to do so just yet. 
For now, simply dragging the single source file into your project is all that's required.

### How to use
You simply have an instance of a UIImage you loaded yourself, from somewhere, anywhere:
```Swift
    var myImage = UIImage(imageNamed:"maybe from the assets, or the image picker class")
```
Define and instantiate an array which will hold your cropped UIImages
```Swift
    var images = [UIImage]()
```


You can either crop your image into a nice square
```Swift
    var profileImageView.image = myImage.cropToSquare()
```

Or if you want to make a game or something and require your images to be cropped up into equal quadrants then simply pass a matrix into the cropWithMatrix method.
You need to insert a tuple which consists of two ints which are attributed to rows and columns.
```Swift
        let rowsNum = 2
        let colsNum = 2
        images = image.cropToMatrix((rowsNum, colsNum))
```

You'll then get your very own images array which contains your cropped/chopped up image.

### To-dos
+ Implement background processing within the package
+ Add more helper functions to the PKImageMatrixCropper
+ Write Tests

### Development

Want to contribute? Great!

PKImageMatrixCropper uses git for fast developing.
+ Fork this repo
+ Make a change
+ And then make a pull request.


License
----

MIT


**Free Software, Hell Yeah!**
