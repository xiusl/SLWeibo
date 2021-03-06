//
//  SLPhotoView.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/11.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FLAnimatedImage.h>
@class SLStatusPicutre;
@interface SLPhotoView : FLAnimatedImageView
@property (nonatomic, strong) SLStatusPicutre *photo;
@property (nonatomic, assign) BOOL onlyOne;
@end
