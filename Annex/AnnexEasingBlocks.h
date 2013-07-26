//
//  AnnexEasingBlocks.h
//  Easing
//
//  Created by Wess Cope on 5/24/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//


#ifndef __ANNEX_EASING_BLOCK__H__
#define __ANNEX_EASING_BLOCK__H__

typedef struct {
    CGFloat time;
    CGFloat start;
    CGFloat delta;
    NSTimeInterval duration;
} AnnexEasingProperty;

AnnexEasingProperty AnnexEasingPropertyCreate(CGFloat time, CGFloat start, CGFloat delta, NSTimeInterval duration);

typedef CGFloat (^AnnexEasingBlock)(AnnexEasingProperty);

#define CONVERT_PROPERTY(property)    \
CGFloat t = property.time,  \
        b = property.start, \
        c = property.delta, \
        d = property.duration


// Easing equations provided by: http://www.dzone.com/snippets/robert-penner-easing-equations

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wsequence-point"

static AnnexEasingBlock AnnexEaseInQuad = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return c * (t /= d) * t + b;
};

static AnnexEasingBlock AnnexEaseOutQuad = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return -c * (t /= d) * (t - 2) + b;
};

static AnnexEasingBlock AnnexEaseInOutQuad = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	if ((t /= d / 2) < 1)
        return c / 2 * t * t + b;
    
	return -c/2 * ((--t)*(t-2) - 1) + b;
};

static AnnexEasingBlock AnnexEaseInCubic = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return c * (t /= d) * t * t + b;
};

static AnnexEasingBlock AnnexEaseOutCubic = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return c * ((t = t / d - 1) * t * t + 1) + b;
};

static AnnexEasingBlock AnnexEaseInOutCubic = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	if ((t /= d / 2) < 1)
        return c / 2 * t * t * t + b;
    
	return c/2*((t-=2)*t*t + 2) + b;
};

static AnnexEasingBlock AnnexEaseInQuart = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return c * (t /= d) * t * t * t + b;
};

static AnnexEasingBlock AnnexEaseOutQuart = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return -c * ((t = t / d - 1) * t * t * t - 1) + b;
};

static AnnexEasingBlock AnnexEaseInOutQuart = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	if ((t /= d / 2) < 1)
        return c / 2 * t * t * t * t + b;
    
	return -c/2 * ((t-=2)*t*t*t - 2) + b;
};

static AnnexEasingBlock AnnexEaseOutQuint = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return c * (t /= d) * t * t * t * t + b;
};

static AnnexEasingBlock AnnexEaseInQuint = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return c * ((t = t/d - 1) * t * t * t * t + 1) + b;
};

static AnnexEasingBlock AnnexEaseInOutQuint = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	if ((t /= d / 2) < 1)
        return c / 2 * t * t * t * t * t + b;
    
	return c / 2 * ((t -= 2) * t * t * t * t + 2) + b;
};

static AnnexEasingBlock AnnexEaseInSine = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return -c * cos(t / d * (M_PI / 2)) + c + b;
};

static AnnexEasingBlock AnnexEaseOutSine = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return c * sin(t / d * (M_PI / 2)) + b;
};

static AnnexEasingBlock AnnexEaseInOutSine = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    return -c / 2 * (cos(M_PI * t / d) - 1) + b;
};

static AnnexEasingBlock AnnexEaseInExpo = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	return (t == 0) ? b : c * pow(2, 10 * (t / d - 1)) + b;
};

static AnnexEasingBlock AnnexEaseOutExpo = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b;
};

static AnnexEasingBlock AnnexEaseInOutExpo = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	if (t == 0) return
        b;
    
	if (t == d)
        return b + c;
    
	if ((t /= d / 2) < 1)
        return c / 2 * pow(2, 10 * (t - 1)) + b;
    
	return c / 2 * (-pow(2, -10 * --t) + 2) + b;
};

static AnnexEasingBlock AnnexEaseInCirc = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	return -c * (sqrt(1 - (t /= d) * t) - 1) + b;
};

static AnnexEasingBlock AnnexEaseOutCirc = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	return c * sqrt(1 - (t = t / d - 1) * t) + b;
};

static AnnexEasingBlock AnnexEaseInOutCirc = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	if ((t /= d / 2) < 1)
        return -c / 2 * (sqrt(1 - t * t) - 1) + b;
    
	return c/2 * (sqrt(1 - (t-=2)*t) + 1) + b;
};

static AnnexEasingBlock AnnexEaseInElastic = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    CGFloat amplitude   = 5;
    CGFloat period      = 0.3;
    CGFloat s           = 0;
    
	if (t == 0)
        return b;
    
    if ((t /= d) == 1)
        return b + c;
    
    if (!period)
        period = d * .3;
    
	if (amplitude < abs(c))
    {
        amplitude = c;
        s = period / 4;
    }
	else
    {
        s = period / (2 * M_PI) * asin(c / amplitude);
    }
	
    return -(amplitude * pow(2, 10 * (t-=1)) * sin( (t * d - s) * (2 * M_PI) / period )) + b;
};

static AnnexEasingBlock AnnexEaseOutElastic = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    CGFloat amplitude   = 5;
    CGFloat period      = 0.3;
    CGFloat s           = 0;
    
    if (t == 0)
        return b;
    else if ((t /= d) == 1)
        return b + c;

    
    if (!period)
        period = d * .3;
    
    if (amplitude < abs(c))
    {
        amplitude = c;
        s = period / 4;
    }
    else
    {
        s = period / (2 * M_PI) * sin(c / amplitude);
    }
    
    return (amplitude * pow(2, -10 * t) * sin((t * d - s) * (2 * M_PI) / period) + c + b);
};

static AnnexEasingBlock AnnexEaseInOutElastic = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    CGFloat amplitude   = 5;
    CGFloat period      = 0.3;
    CGFloat s           = 0;
    
	if (t == 0)
        return b;
    
    if ((t /= d / 2) == 2)
        return b + c;
    
    if (!period)
    {
        period = d * (.3 * 1.5);
    }
    
	if (amplitude < abs(c))
    {
        amplitude = c;
        s = period / 4;
    }
	else
    {
        s = period / (2 * M_PI) * asin (c / amplitude);
    }
    
	if (t < 1)
        return -.5 * (amplitude * pow(2, 10 * (t -= 1)) * sin( (t * d - s) * (2 * M_PI) / period )) + b;
    
	return amplitude * pow(2, -10 * ( t-= 1)) * sin( (t * d - s) * (2 * M_PI) / period ) * .5 + c + b;
};

static AnnexEasingBlock AnnexEaseInBack = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	CGFloat s = 1.70158;
	return c * (t /= d) * t * ((s + 1) * t - s) + b;
};

static AnnexEasingBlock AnnexEaseOutBack = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	CGFloat s = 1.70158;
	return c * (( t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
};

static AnnexEasingBlock AnnexEaseInOutBack = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	CGFloat s = 1.70158;
    
	if ((t /= d / 2) < 1)
        return c / 2 * (t * t * (((s *= (1.525)) + 1) * t - s)) + b;
    
	return c / 2 * ((t -= 2) * t * (((s *= (1.525)) + 1) * t + s) + 2) + b;
};

static AnnexEasingBlock AnnexEaseOutBounce = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
    if ((t /= d) < (1 / 2.75))
        return c * (7.5625 * t * t) + b;
    
    else if (t < (2 / 2.75))
        return c * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75) + b;
    
    else if (t < (2.5 / 2.75))
        return c * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375) + b;
    
    else
        return c * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375) + b;
};

static AnnexEasingBlock AnnexEaseInBounce = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	return c - AnnexEaseOutBounce(AnnexEasingPropertyCreate(d - t, 0, c, d)) + b;
};

static AnnexEasingBlock AnnexEaseInOutBounce = ^CGFloat(AnnexEasingProperty property) {
    CONVERT_PROPERTY(property);
    
	if (t < d/2)
        return AnnexEaseInBounce(AnnexEasingPropertyCreate(t * 2, 0, c, d)) * .5 + b;
    
	return AnnexEaseOutBounce(AnnexEasingPropertyCreate(t * 2 - d, 0, c, d)) * .5 + c * .5 + b;
};

#pragma clang diagnostic pop

#endif
