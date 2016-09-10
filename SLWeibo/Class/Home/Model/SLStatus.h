//
//  SLStatus.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/5.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLUser,SLStatus;
@interface SLStatus : NSObject
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的配图
 */
@property (nonatomic, strong) NSArray *pic_urls;
//@property (nonatomic, copy) NSString *thumbnail_pic;

/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博的作者
 */
@property (nonatomic, strong) SLUser *user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) SLStatus *retweeted_status;


@end