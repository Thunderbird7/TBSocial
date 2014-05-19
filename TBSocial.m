//
//  TBSocial.m
//  THUNDERBIRD Social Sharing 1.0
//
//  Created by Thunderbird on 5/15/2557 BE.
//  Copyright (c) 2557 E-Commerce Solution Co.,Ltd. All rights reserved.
//

#import "TBSocial.h"

@implementation TBSocial
{
    UIDocumentInteractionController *documentController;
}

+ (instancetype)sharedInstance
{
    static TBSocial *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[TBSocial alloc] init];
    });
    return shareInstance;
}

#pragma mark - Share to LINE

+ (BOOL)isiOS7
{
    NSArray *versions = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    return [versions[0] intValue] >= 7;
}

+ (UIPasteboard *)pasteboard
{
    if ([self isiOS7]) {
        return [UIPasteboard generalPasteboard];
    } else {
        return [UIPasteboard pasteboardWithName:@"jp.naver.linecamera.pasteboard" create:YES];
    }
}

+ (BOOL)isLineInstalled
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]];
}

+ (BOOL)shareLineText:(NSString *)text
{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"line://msg/text/%@", [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

+ (BOOL)shareLineImage:(UIImage *)image
{
    UIPasteboard *pasteboard = self.pasteboard;
    [pasteboard setData:UIImageJPEGRepresentation(image, 0.8) forPasteboardType:@"public.jpeg"];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"line://msg/image/%@", pasteboard.name]]];
}

#pragma mark - Share to Instagram

+ (BOOL)isInstagramInstalled
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"instagram://"]];
}

+ (BOOL)isInstagramImageCorrectSize:(UIImage *)image
{
    CGImageRef cgImage = [image CGImage];
    return (CGImageGetWidth(cgImage) >= 612 && CGImageGetHeight(cgImage) >= 612);
}

+ (void)shareInstagramImage:(UIImage *)image inView:(UIView *)aView
{
    [self shareInstagramImageWithCaption:nil andImage:image inView:aView];
}

+ (void)shareInstagramImageWithCaption:(NSString *)aCaption andImage:(UIImage *)aImage inView:(UIView *)aView
{
    [self shareInstagramImageWithCaption:aCaption andImage:aImage inView:aView delegate:nil];
}

+ (void)shareInstagramImageWithCaption:(NSString *)aCaption andImage:(UIImage *)aImage inView:(UIView *)aView delegate:(id<UIDocumentInteractionControllerDelegate>)aDelegate
{
    [[TBSocial sharedInstance] shareInstagramImageWithCaption:aCaption andImage:aImage inView:aView delegate:aDelegate];
}

- (void)shareInstagramImageWithCaption:(NSString *)aCaption andImage:(UIImage *)aImage inView:(UIView *)aView delegate:(id<UIDocumentInteractionControllerDelegate>)aDelegate
{
    NSData *imageData = UIImageJPEGRepresentation(aImage, 1.0);
    NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
    [imageData writeToFile:writePath atomically:YES];

    NSURL *fileURL = [NSURL fileURLWithPath:writePath];
    documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    documentController.delegate = aDelegate;
    [documentController setDelegate:aDelegate];
    [documentController setUTI:@"com.instagram.exclusivegram"];
    if (aCaption)
        [documentController setAnnotation:@{@"InstagramCaption" : aCaption}];
    [documentController presentOpenInMenuFromRect:CGRectZero inView:aView animated:YES];
}


#pragma mark - Share to Facebook

+ (void)shareFacebookWithText:(NSString *)aText andURL:(NSURL *)aURL andImage:(UIImage *)aImage inView:(UIViewController *)aView
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:aText];
        [controller addURL:aURL];
        [controller addImage:aImage];
        
        [aView presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark - Share to Twitter

+ (void)shareTwitterWithText:(NSString *)aText andURL:(NSURL *)aURL andImage:(UIImage *)aImage inView:(UIViewController *)aView
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [controller setInitialText:aText];
        [controller addURL:aURL];
        [controller addImage:aImage];
        
        [aView presentViewController:controller animated:YES completion:nil];
    }
}

@end
