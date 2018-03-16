//
//  SLStatusCell.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLStatusCell.h"
#import "SLStatusCard.h"
#import "SLStatus.h"
#import "SLUser.h"
#import "SLStatusLayout.h"
#import <YYText.h>


@implementation SLStatusCellTopView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.avatarView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.sourceLabel];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.frame = CGRectMake(0, 0, kSLScreenWidth, 0.5);
        line.backgroundColor = kSLColorHex(@"E6E6E6");
        [self addSubview:line];
    }
    return self;
}
- (void)setStatus:(SLStatus *)status {
    _status = status;
    
    SLUser *user = status.user;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:user.avatar_hd]];
    
    self.nameLabel.text = user.screen_name;
    [self.nameLabel sizeToFit];
    
    self.timeLabel.text = status.created_at;
    [self.timeLabel sizeToFit];
    
    if (status.source) {
        NSMutableAttributedString *temStr = [[NSMutableAttributedString alloc] initWithString:status.source];
        [temStr setAttributes:@{NSFontAttributeName:self.sourceLabel.font, NSForegroundColorAttributeName:self.sourceLabel.textColor}
                        range:NSMakeRange(0, temStr.length)];
        if (status.source_allowclick) {
            [temStr setAttributes:@{NSFontAttributeName:self.sourceLabel.font, NSForegroundColorAttributeName:kSLOrangeColor}
                            range:NSMakeRange(2, temStr.length-2)];
        }
        
        YYTextContainer *container = [[YYTextContainer alloc] init];
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:temStr];
        self.sourceLabel.textLayout = layout;
        self.sourceLabel.attributedText = temStr;
        [self.sourceLabel sizeToFit];
        self.sourceLabel.mj_x = self.timeLabel.mj_x+self.timeLabel.mj_w+4;
        
    }
    
    NSLog(@"%@", NSStringFromCGRect(self.avatarView.frame));
}
#pragma mark - getter
- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.frame = CGRectMake(kSLStatusCellPadding_lr, kSLStatusCellPadding_t, kSLStatusCellAvatar_h, kSLStatusCellAvatar_h);
        _avatarView.frame = CGRectMake(12, 14, 40, 40);
        _avatarView.layer.cornerRadius = kSLStatusCellAvatar_h * 0.5;
        _avatarView.layer.borderColor = [kSLColorHex(@"E2E4E8") CGColor];
        _avatarView.layer.borderWidth = 0.5;
        _avatarView.clipsToBounds = YES;
    }
    return _avatarView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        CGFloat x = kSLStatusCellPadding_lr + kSLStatusCellAvatar_h + 6;
        _nameLabel.frame = CGRectMake(x, 16, 0, 20);
        _nameLabel.font = kSLFont(kNameFontSize);
        _nameLabel.textColor = kSLOrangeColor;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        CGFloat x = kSLStatusCellPadding_lr + kSLStatusCellAvatar_h + 6;
        _timeLabel.frame = CGRectMake(x, 36, 0, 0);
        _timeLabel.font = kSLFont(12);
        _timeLabel.textColor = kSLColorHex(@"929394");
    }
    return _timeLabel;
}
- (YYLabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [[YYLabel alloc] init];
        CGFloat x = kSLStatusCellPadding_lr + kSLStatusCellAvatar_h + 6;
        _sourceLabel.frame = CGRectMake(x, 36, 0, 0);
        _sourceLabel.font = kSLFont(12);
        _sourceLabel.textColor = kSLColorHex(@"929394");
    }
    return _sourceLabel;
}
@end
@implementation SLStatusCellCenterView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.textLabel];
    }
    return self;
}
- (void)setStatusLayout:(SLStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    
    SLStatus *status = statusLayout.status;
    self.textLabel.textLayout = statusLayout.textLayout;
    self.textLabel.mj_h = statusLayout.textHeight;
    
//    YYTextDebugOption *op = [YYTextDebugOption new];
//    op.baselineColor = [UIColor redColor];
//    op.CTLineFillColor = [UIColor colorWithRed:0.000 green:0.484 blue:1.000 alpha:0.165];
//    [YYTextDebugOption setSharedDebugOption:op];
//    self.textLabel.debugOption = op;
//    
//    self.textLabel.layer.borderColor = [[UIColor redColor] CGColor];
//    self.textLabel.layer.borderWidth = 0.5;
    
    self.mj_h = statusLayout.textHeight;
//    _textLabel.mj_h =
}
- (YYLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[YYLabel alloc] init];
        _textLabel.frame = CGRectMake(kSLStatusCellPadding_lr, kSLStatusCellText_t, kSLStatusCellContent_w, 0);
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = kSLFont(16);
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}
@end
@implementation SLStatusCellBarView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.retweetButton];
        [self addSubview:self.commentButton];
        [self addSubview:self.diggButton];
    }
    return self;
}
- (void)setStatusLayout:(SLStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    SLStatus *status = statusLayout.status;
    [self updateShowWithStatus:status];
}
- (void)updateShowWithStatus:(SLStatus *)status {
    
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%zd", status.reposts_count] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd", status.comments_count] forState:UIControlStateNormal];
    [self.diggButton setTitle:[NSString stringWithFormat:@"%zd", status.attitudes_count] forState:UIControlStateNormal];
}
- (UIButton *)retweetButton {
    if (!_retweetButton) {
        _retweetButton = [[UIButton alloc] init];
        _retweetButton.frame = CGRectMake(0, 0, kSLScreenWidth/3, kSLStatusCellBar_h);
        [_retweetButton setBackgroundImage:[UIImage resizedImageWithName:@"timeline_barbutton_highlighted"] forState:UIControlStateHighlighted];
        [_retweetButton setTitleColor:kSLColorHex(@"929292") forState:UIControlStateNormal];
        [_retweetButton setTitleColor:kSLOrangeColor forState:UIControlStateSelected];
        _retweetButton.titleLabel.font = kSLFont(12);
    }
    return _retweetButton;
}
- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] init];
        _commentButton.frame = CGRectMake(kSLScreenWidth/3, 0, kSLScreenWidth/3, kSLStatusCellBar_h);
        [_commentButton setBackgroundImage:[UIImage resizedImageWithName:@"timeline_barbutton_highlighted"] forState:UIControlStateHighlighted];
        [_commentButton setTitleColor:kSLColorHex(@"929292") forState:UIControlStateNormal];
        [_commentButton setTitleColor:kSLOrangeColor forState:UIControlStateSelected];
        _commentButton.titleLabel.font = kSLFont(12);
    }
    return _commentButton;
}
- (UIButton *)diggButton {
    if (!_diggButton) {
        _diggButton = [[UIButton alloc] init];
        _diggButton.frame = CGRectMake(kSLScreenWidth/3*2, 0, kSLScreenWidth/3, kSLStatusCellBar_h);
        [_diggButton setBackgroundImage:[UIImage resizedImageWithName:@"timeline_barbutton_highlighted"] forState:UIControlStateHighlighted];
        [_diggButton setTitleColor:kSLColorHex(@"929292") forState:UIControlStateNormal];
        [_diggButton setTitleColor:kSLOrangeColor forState:UIControlStateSelected];
        _diggButton.titleLabel.font = kSLFont(12);
    }
    return _diggButton;
}
@end




@implementation SLStatusCellContentView
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];
        [self addSubview:self.centerView];
        [self addSubview:self.barView];
    }
    return self;
}
- (void)setStatusLayout:(SLStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    self.centerView.statusLayout = statusLayout;
    
    self.topView.status = statusLayout.status;
    
    self.barView.statusLayout = statusLayout;
    self.barView.mj_y = statusLayout.cellHight - kSLStatusCellBar_h - kSLStatusCellSpace_h;
}
- (SLStatusCellTopView *)topView {
    if (!_topView) {
        _topView = [[SLStatusCellTopView alloc] init];
        _topView.frame = CGRectMake(0, 0, kSLScreenWidth, kSLStatusCellPadding_t + kSLStatusCellAvatar_h);
    }
    return _topView;
}
- (SLStatusCellCenterView *)centerView {
    if (!_centerView) {
        _centerView = [[SLStatusCellCenterView alloc] init];
        _centerView.frame = CGRectMake(0, kSLStatusCellPadding_t + kSLStatusCellAvatar_h, kSLScreenWidth, 0);
    }
    return _centerView;
}
- (SLStatusCellBarView *)barView {
    if (!_barView) {
        _barView = [[SLStatusCellBarView alloc] init];
        _barView.frame = CGRectMake(0, 0, kSLScreenWidth, kSLStatusCellBar_h);
    }
    return _barView;
}
@end


@interface SLStatusCell()

@end

@implementation SLStatusCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"status";
    SLStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SLStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        // cell.backgroundColor = SLColor(226, 226, 226);
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [[UIView alloc] init];
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.statusView];
    }
    return self;
}


- (void)setStatusCard:(SLStatusCard *)statusCard {
    _statusCard = statusCard;
    
    
}
- (void)setStatusLayout:(SLStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    
    self.statusView.statusLayout = statusLayout;
    self.statusView.frame = CGRectMake(0, 0, kSLScreenWidth, statusLayout.cellHight-kSLStatusCellSpace_h);
}
#pragma mark - getter
- (SLStatusCellContentView *)statusView {
    if (!_statusView) {
        _statusView = [[SLStatusCellContentView alloc] init];
        _statusView.backgroundColor = [UIColor whiteColor];
    }
    return _statusView;
}
@end
