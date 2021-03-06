//
//  FriendCell.m
//  Toxicity
//
//  Created by James Linnell on 8/25/13.
//  Copyright (c) 2013 JamesTech. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

@synthesize nickLabel = _nickLabel, messageLabelText = _messageLabelText, statusColor = _statusColor, friendIdentifier = _friendIdentifier;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        cellBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        
        /*****Background Grey Color*****/
        mainLayerBG = [CALayer layer];
        mainLayerBG.frame = self.bounds;
        mainLayerBG.backgroundColor = [[UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f] CGColor];
        mainLayerBG.name = @"Background";
        [cellBackgroundView.layer insertSublayer:mainLayerBG atIndex:0];
        
        /*****Background Gradient*****/
        mainLayerGradient = [CAGradientLayer layer];
        mainLayerGradient.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 1, self.bounds.size.width, self.bounds.size.height - 1);
        UIColor *top = [UIColor colorWithHue:1.0f saturation:0.0f brightness:0.4f alpha:1.0f];
        UIColor *bottom = [UIColor colorWithHue:1.0f saturation:0.0f brightness:0.3f alpha:1.0f];
        mainLayerGradient.colors = [NSArray arrayWithObjects:(id)[top CGColor], (id)[bottom CGColor], nil];
        mainLayerGradient.name = @"Gradient";
        
        [cellBackgroundView.layer insertSublayer:mainLayerGradient atIndex:1];
        
        [self setBackgroundView:cellBackgroundView];
        
        /*****Friend Status Image*****/
        //default is gray
        statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 16, 0, 16, 64)];
        [statusImageView setImage:[UIImage imageNamed:@"status-gray"]];
        [self addSubview:statusImageView];
        
        /*****Nick Label*****/
        self.nickLabel = [[UILabel alloc] init];
        [self.nickLabel setTextColor:[UIColor whiteColor]];
        [self.nickLabel setBackgroundColor:[UIColor clearColor]];
        [self.nickLabel setShadowColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
        [self.nickLabel setShadowOffset:CGSizeMake(1.0f, 1.0f)];
        [self.nickLabel setFont:[UIFont systemFontOfSize:18.0f]];
        
        [self.contentView addSubview:self.nickLabel];
        
        /*****Message Label*****/
        messageLabel = [[UILabel alloc] init];
        [messageLabel setTextAlignment:NSTextAlignmentLeft];
        [messageLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [messageLabel setNumberOfLines:2];
        
        [messageLabel setTextColor:[UIColor colorWithRed:0.55f green:0.62f blue:0.68f alpha:1.0f]];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [messageLabel setFont:[UIFont systemFontOfSize:12.0f]];

        [messageLabel setShadowColor:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1.0f]];
        [messageLabel setShadowOffset:CGSizeMake(0.5f, 0.5f)];
        
        [self.contentView addSubview:messageLabel];
        
        /*****Avatar Image View*****/
        avatarImageView = [[UIImageView alloc] init];
        [avatarImageView setBackgroundColor:[UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:1.0f]];
        [avatarImageView.layer setCornerRadius:4.0f];
        [avatarImageView.layer setMasksToBounds:YES];
        [avatarImageView.layer addSublayer:[self getNewInnerShadowLayer]];
        
        [self.contentView addSubview:avatarImageView];
        
        /*****Selected Background View*****/
        UIView *selected = [[UIView alloc] initWithFrame:self.bounds];
        CALayer *selectedBGLayer = [CALayer layer];
        selectedBGLayer.frame = self.bounds;
        selectedBGLayer.backgroundColor = [[UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f] CGColor];
        selectedBGLayer.name = @"SelectedBackground";
        [selected.layer insertSublayer:selectedBGLayer atIndex:0];
        
        CAGradientLayer *selectedGrad = [CAGradientLayer layer];
        selectedGrad.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 1, self.bounds.size.width, self.bounds.size.height - 1);
        UIColor *selectedTop = [UIColor colorWithHue:0.5f saturation:0.0f brightness:0.2f alpha:1.0f];
        UIColor *selectedBottom = [UIColor colorWithHue:0.5f saturation:0.0f brightness:0.3f alpha:1.0f];
        selectedGrad.colors = [NSArray arrayWithObjects:(id)[selectedTop CGColor], (id)[selectedBottom CGColor], nil];
        selectedGrad.name = @"SelectedGradient";
        [selected.layer insertSublayer:selectedGrad atIndex:1];
        

        self.selectedBackgroundView = selected;
        
    }
    return self;
}

- (CAShapeLayer *)getNewInnerShadowLayer {
    CAShapeLayer* shadowLayer = [CAShapeLayer layer];
    [shadowLayer setFrame:CGRectMake(0, 0, 48, 48)];
    
    // Standard shadow stuff
    [shadowLayer setShadowColor:[[UIColor colorWithWhite:0 alpha:1] CGColor]];
    [shadowLayer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [shadowLayer setShadowOpacity:1.0f];
    [shadowLayer setShadowRadius:3];
    
    // Causes the inner region in this example to NOT be filled.
    [shadowLayer setFillRule:kCAFillRuleEvenOdd];
    
    // Create the larger rectangle path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectInset([shadowLayer bounds], -10, -10));
    
    // Add the inner path so it's subtracted from the outer path.
    // someInnerPath could be a simple bounds rect, or maybe
    // a rounded one for some extra fanciness.
    CGPathAddPath(path, NULL, [[UIBezierPath bezierPathWithRect:[shadowLayer bounds]] CGPath]);
    CGPathCloseSubpath(path);
    
    [shadowLayer setPath:path];
    CGPathRelease(path);
    
    return shadowLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
//    NSLog(@"setSelected: %d", (int)selected);
//    mainLayerGradient.hidden = selected;
//    mainLayerBG.hidden = selected;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //calculates the desired width. if it's in editing mde (with the red delete button) use the contentView width and 20px padding (10px on each side)
    //and if not editing use entire width minus 20px padding (10px each side) and the width of the status view
    
    /*
                          <-320px->
      ^   |       +------+                                      |
      |   |       |      |       Nick Label                  | ||
     64px |<-8px->|  Img |<-8px->                    <-10px->| ||
      |   |       |      |       Status Label                | ||
      v   |       +------+                                      |
     
     
     Total padding: 8+8+10 = 26px
     
     Img: 48x48 px
          8px padding vertical each way
     
     */
    
    const int padding = 26;
    const int avatarWidth = 48;
    
    CGFloat labelWidth;
    if (self.editing) {
        labelWidth = self.contentView.bounds.size.width - padding - avatarWidth;
    } else {
        labelWidth = self.bounds.size.width - padding - statusImageView.frame.size.width - avatarWidth;
    }
    
    /*****Nick Label*****/
    [self.nickLabel setFrame:CGRectMake(64, 8, labelWidth, 22)];
    
    /*****Message Label*****/
    [messageLabel setFrame:CGRectMake(64, 30, labelWidth, messageLabel.frame.size.height)];
    
    /*****Avatar Image View*****/
    [avatarImageView setFrame:CGRectMake(8, 8, 48, 48)];
    
    /*****Gradient*****/
    cellBackgroundView.frame = self.bounds;
    //have to redo gradient on height change
    mainLayerGradient.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 1, self.bounds.size.width, self.bounds.size.height - 1);
    mainLayerBG.frame = self.bounds;
    
    /*****Selected View*****/
    for (CAGradientLayer *grad in self.selectedBackgroundView.layer.sublayers) {
        if ([grad.name isEqualToString:@"SelectedGradient"]) {
            grad.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 1, self.bounds.size.width, self.bounds.size.height - 1);
        }
    }
}

- (void)setStatusColor:(FriendCellStatusColor)statusColor {
    switch (statusColor) {
        case FriendCellStatusColor_Gray:
            [statusImageView setImage:[UIImage imageNamed:@"status-gray"]];
            break;
            
        case FriendCellStatusColor_Green:
            [statusImageView setImage:[UIImage imageNamed:@"status-green"]];
            break;
            
        case FriendCellStatusColor_Yellow:
            [statusImageView setImage:[UIImage imageNamed:@"status-yellow"]];
            break;
            
        case FriendCellStatusColor_Red:
            [statusImageView setImage:[UIImage imageNamed:@"status-red"]];
            break;
            
        default:
            break;
    }
}

- (void)setMessageLabelText:(NSString *)messageLabelText {
    [messageLabel setText:messageLabelText];
    [messageLabel sizeToFit];
    CGRect newFrame = messageLabel.frame;
    
    CGFloat labelWidth;
    if (self.editing) {
        labelWidth = self.contentView.bounds.size.width - 20;
    } else {
        labelWidth = self.bounds.size.width - 20 - statusImageView.frame.size.width;
    }
    
    newFrame.size.width = labelWidth;
}

- (void)setAvatarImage:(UIImage *)avatarImage {
    [avatarImageView setImage:avatarImage];
}

@end
