TBSocial
========

THUNDERBIRD Social Sharing for iOS 7

## Features
- Share content to Facebook (Native)
- Share content to twitter (Native)
- Share photo and caption to instagram
- Share photo to LINE App

#### Requirements

* ARC only; iOS 7.0+
* **Social.framework**

#### Get it as: 1) source files

1. Download the TBSocial repository as a [zip file](https://github.com/Thunderbird7/TBSocial.git) or clone it
2. Copy the TBSocial sub-folder into your Xcode project
3. Link your app to Social.framework

------------------------------------
Basic usage
====================================

#### Share to Facebook with code:
```objective-c
 [TBSocial shareFacebookWithText:shareText andURL:shareURL andImage:shareImage inView:self]; 
```

#### Share to Twitter with code:
```objective-c
[TBSocial shareTwitterWithText:shareText andURL:shareURL andImage:shareImage inView:self];
```

#### Share to Instagram with code:
```objective-c
            if ([TBSocial isInstagramInstalled]) {
                if ([TBSocial isInstagramImageCorrectSize:shopImage]) {
                    [TBSocial shareInstagramImageWithCaption:text andImage:shopImage inView:self.view];
                }
            }
```


