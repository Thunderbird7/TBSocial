//
//  TBSocial.h
//  THUNDERBIRD Social Sharing 1.0
//
//  Created by Thunderbird on 5/15/2557 BE.
//  Copyright (c) 2557 E-Commerce Solution Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>

@interface TBSocial : NSObject<UIDocumentInteractionControllerDelegate>

+ (BOOL)isLineInstalled;
+ (BOOL)isInstagramInstalled;
+ (BOOL)isInstagramImageCorrectSize:(UIImage *)image;

+ (BOOL)shareLineText:(NSString *)text;
+ (BOOL)shareLineImage:(UIImage *)image;

+ (void)shareInstagramImage:(UIImage*)image inView:(UIView *)aView;
+ (void)shareInstagramImageWithCaption:(NSString *)aCaption andImage:(UIImage *)aImage inView:(UIView *)aView;
+ (void)shareInstagramImageWithCaption:(NSString *)aCaption andImage:(UIImage *)aImage inView:(UIView *)aView delegate:(id<UIDocumentInteractionControllerDelegate>)aDelegate;

+ (void)shareFacebookWithText:(NSString *)aText andURL:(NSURL *)aURL andImage:(UIImage *)aImage inView:(UIViewController *)aView;
+ (void)shareTwitterWithText:(NSString *)aText andURL:(NSURL *)aURL andImage:(UIImage *)aImage inView:(UIViewController *)aView;

@end

