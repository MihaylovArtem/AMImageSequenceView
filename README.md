## AMImageSequenceView

![Pod Version](https://img.shields.io/cocoapods/v/AMImageSequenceView.svg?style=flat)
![Platforms](https://cocoapod-badges.herokuapp.com/p/AMImageSequenceView/badge.png)
![License](https://cocoapod-badges.herokuapp.com/l/AMImageSequenceView/badge.(png|svg))


`AMImageSequenceView` is a simple View to create image sequence in your iOS app. This view is intended for viewing 360-spin images. It supports 360-degree horizontal rotation and image zooming.

## Image examples

You can try 360-spin images on this resources:\
http://www.ajax-zoom.com/examples/example15.php \
https://www.yofla.com/3d-rotate/examples/backpack-360-view/

## Getting started

### From CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like `SVProgressHUD` in your projects. First, add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'AMImageSequenceView'
```

Second, install `AMImageSequenceView` into your project:

```ruby
pod install
```

### Manually

Drag the `SVProgressHUD/SVProgressHUD` folder into your project.

## Usage

AMImageSequenceView is subclass of UIView. This view has one subview - `UIScrollView` for zooming images. `UIScrollView` has one subview - `UIImageView` with gesture recognizer for rotating.

### Init
To init view you should use following method:
```objective-c
[[AMImageSequenceView alloc] initWithImages:imagesArray frame:viewFrame]
```
### Customize

#### Zoom

```objective-c
imageSequenceView.zoomEnabled        = YES;  //Default is NO
imageSequenceView.zoomBouncesEnabled = YES;  //Default is NO
imageSequenceView.maximumZoomScale   = 2.5;  //Default is 1.0
```
Note, that you can't set `minimumZoomScale` property, because it is readonly, and it's value is always 1.0.
It is necessary for correct work of rotating gesture recognizer.
Also, if current zoom scale of image is bigger than 1.0 you will not be able to rotate it.

#### Sensivity

You can customize the sensivity of rotating gesture recognizer (how fast it will rotate image) with following line:
```objective-c
imageSequenceView.sensivity = 1.5;  //Default is 0.8
```
Notice, that higher sensivity means slower rotation of image.

#### Inertia

You can enable rotation inertia (continue rotating for some time with deceleration after 
you end rotating gesture, similarly as scrolling of UITableView) with following line:
```objective-c
imageSequenceView.inertiaEnabled = YES;  //Default is NO
```

#### Image content mode

To set content mode of image use this:
```objective-c
imageSequenceView.contentMode = UIViewContentModeScaleCenter;  //Default is UIViewContentModeScaleAspectFit
```

## License

`AMImageSequenceView` is distributed under the terms and conditions of the [MIT license](https://github.com/MihaylovArtem/AMImageSequenceView/blob/master/LICENSE.txt). 

## Credits

`AMImageSequenceView` is brought to you by [Artem Mihaylov](http://mihaylovartem.ru). 
If you're using `AMImageSequenceView` in your project, attribution would be very appreciated.
