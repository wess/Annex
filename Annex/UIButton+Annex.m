//
//  UIButton+Annex.m
//  Annex
//
//  Created by Wess Cope on 3/7/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UIButton+Annex.h"
#import "AnnexImageCache.h"
#import <objc/runtime.h>

@implementation UIButton (Annex)
static char ANNEX_BUTTON_BACKGROUNDS_KEY;
static char ANNEX_BUTTON_PLACEHOLDER_IMAGE;

@dynamic backgroundColors;
@dynamic placeholderImage;

- (void)setBackgroundColors:(NSMutableDictionary *)backgroundColors
{
    objc_setAssociatedObject(self, &ANNEX_BUTTON_BACKGROUNDS_KEY, backgroundColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)backgroundColors
{
    return (NSMutableDictionary *)objc_getAssociatedObject(self, &ANNEX_BUTTON_BACKGROUNDS_KEY);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    if([self backgroundColors] == NULL)
        [self setBackgroundColors:[NSMutableDictionary new]];
    
    [[self backgroundColors] setObject:backgroundColor forKey:@(state)];
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    objc_setAssociatedObject(self, &ANNEX_BUTTON_PLACEHOLDER_IMAGE, placeholderImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)placeholderImage
{
    return (UIImage *)objc_getAssociatedObject(self, &ANNEX_BUTTON_PLACEHOLDER_IMAGE);
}

- (void)setImageForURL:(NSURL *)url forState:(UIControlState)state
{
    if([AnnexImageCache imageForKey:url.absoluteString])
    {
        [self setImage:[AnnexImageCache imageForKey:url.absoluteString] forState:UIControlStateNormal];
    }
    else
    {
        [AnnexImageCache imageFromURL:url completion:^(UIImage *image, NSError *error) {
            if(error)
            {
                NSLog(@"UIButton image loading failed: %@", error.debugDescription);
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setImage:image forState:state];                    
                });
            }
        }];
    }
}

#pragma mark - Handle Background color toggle -
- (void)animateBackgroundToColor:(NSNumber *)key
{
    UIColor *backgroundColor = [[self backgroundColors] objectForKey:key];
    if(backgroundColor)
    {
        [UIView animateWithDuration:0.1f animations:^{
            self.backgroundColor = backgroundColor;
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateHighlighted]];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateNormal]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateNormal]];
}

@end
