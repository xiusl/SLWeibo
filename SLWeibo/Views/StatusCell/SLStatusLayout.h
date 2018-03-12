//
//  SLStatusLayout.h
//  SLWeibo
//
//  Created by Sleen Xiu on 2018/3/11.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSLStatusCellSpace_h 10
#define kSLStatusCellAvatar_h 40.0
#define kSLStatusCellPadding_t 14
#define kSLStatusCellPadding_lr 12
#define kSLStatusCellMedia_t 8
#define kSLStatusCellBar_t 12
#define kSLStatusCellBar_h 34
#define kSLStatusCellText_t 12
#define kSLStatusCellImages_m 4
#define kSLStatusCellMedia_scale (332/592.0)
#define kSLStatusCellContent_w (kSLScreenWidth-2*kSLStatusCellPadding_lr)

#define kSLStatusCellMate_t 7
#define kSLStatusCellSource_l 7

#define kTextFontSize 16
#define kNameFontSize 14
#define kMetaFontSize 12


@class SLStatus;
@interface SLStatusLayout : NSObject
+ (instancetype)statusLayoutWithStatus:(SLStatus *)status;
- (instancetype)initWithStatus:(SLStatus *)status;
- (void)layout;

@property (nonatomic, strong) SLStatus *status;

@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) CGFloat cellHight;

@end