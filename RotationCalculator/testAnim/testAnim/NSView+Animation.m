#import "NSView+Animation.h"
#import <QuartzCore/QuartzCore.h>

@implementation NSView (Animation)

NSString * transform3dToString(CATransform3D transform){
    NSString *s = [NSString stringWithFormat:@"\n%.0f,%.0f,%.0f,%.0f,\n%.0f,%.0f,%.0f,%.0f,\n%.0f,%.0f,%.0f,%.0f,\n%.0f,%.0f,%.0f,%.0f,\n", transform.m11,transform.m12,transform.m13,transform.m14,
                   transform.m21,transform.m22,transform.m23,transform.m24,
                   transform.m31,transform.m32,transform.m33,transform.m34,
                   transform.m41,transform.m42,transform.m43,transform.m44];
    return s;
}

bool equalTransform(CATransform3D a, CATransform3D b){
    bool f11 = fabs(a.m11-b.m11)<0.000001;
    bool f12 = fabs(a.m12-b.m12)<0.000001;
    bool f13 = fabs(a.m13-b.m13)<0.000001;
    bool f14 = fabs(a.m14-b.m14)<0.000001;
    
    bool f21 = fabs(a.m21-b.m21)<0.000001;
    bool f22 = fabs(a.m22-b.m22)<0.000001;
    bool f23 = fabs(a.m23-b.m23)<0.000001;
    bool f24 = fabs(a.m24-b.m24)<0.000001;
    
    bool f31 = fabs(a.m31-b.m31)<0.000001;
    bool f32 = fabs(a.m32-b.m32)<0.000001;
    bool f33 = fabs(a.m33-b.m33)<0.000001;
    bool f34 = fabs(a.m34-b.m34)<0.000001;
    
    bool f41 = fabs(a.m41-b.m41)<0.000001;
    bool f42 = fabs(a.m42-b.m42)<0.000001;
    bool f43 = fabs(a.m43-b.m43)<0.000001;
    bool f44 = fabs(a.m44-b.m44)<0.000001;
    
    return f11 && f12 && f13 && f14
    && f21 && f22 && f23 && f24
    && f31 && f32 && f33 && f34
    && f41 && f42 && f43 && f44;
}

- (void)addAnimationFrom:(NSValue *)fromValue
                      to:(NSValue *)toValue
                duration:(CFTimeInterval)duration
                     key:(NSString *)key{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)hpsRotateByAngle:(CGFloat)angle{
    CGRect frame = self.layer.frame;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    self.layer.position = center;
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    CATransform3D t1 = self.layer.transform;
    CATransform3D t2 = CATransform3DConcat(t1, CATransform3DMakeRotation((angle * M_PI ) / 180.0, 0, 0, 1));
    
    [self addAnimationFrom:[NSValue valueWithCATransform3D:t1]
                        to:[NSValue valueWithCATransform3D:t2]
                  duration:0.3
                       key:@"rotate"];
    
    [self.layer setTransform: t2];
}

// flag == YES 水平翻转，否则，垂直翻转
- (void)hpsFlip:(BOOL)flag{
    CGRect frame = self.layer.frame;
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    self.layer.position = center;
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    CATransform3D t1 = self.layer.transform;
    CATransform3D t2;
    
    if(flag){
        t2 = CATransform3DConcat(t1, CATransform3DMakeRotation( M_PI, 0, 1, 0));
    }else{
        t2 = CATransform3DConcat(t1, CATransform3DMakeRotation( M_PI, 1, 0, 0));
    }
    
    [self addAnimationFrom:[NSValue valueWithCATransform3D:t1]
                        to:[NSValue valueWithCATransform3D:t2]
                  duration:0.3
                       key:@"flip"];
    
    [self.layer setTransform:t2];
}

- (void)hpsFlipVertical{
    [self hpsFlip:NO];
}

- (void)hpsFlipHorizontal{
    [self hpsFlip:YES];
}

- (void)hpsResetRotate{
    [self.layer removeAllAnimations];
    
    [self.layer setAffineTransform: CGAffineTransformIdentity];
}

@end
