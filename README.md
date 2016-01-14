# Chop Chop (v1)
![ChopChop](https://github.com/pavankataria/ChopChop/blob/master/Resources/ChopChop-cover.png)

Chop an image to as many quadrants as you like at compile time. 
Suitable for games and image processing.

Great for dynamic content, s

Here's what you can do with this package:

  - You can crop an image into a square
  - You can crop an image into as many quadrants as you like, by specifying the number of rows and columns, a matrix.
  
### Screenshots of Demo
 <p>
<a href="url"><img src="https://cloud.githubusercontent.com/assets/1791244/12220110/e0d6c130-b758-11e5-88ee-08af7d865f28.PNG" align="left" height=700px></a>
<a href="url"><img src="https://cloud.githubusercontent.com/assets/1791244/12220111/e2336dbc-b758-11e5-89ff-3eef44a4ce10.PNG" align="left" height=700px></a> 
<p>
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
