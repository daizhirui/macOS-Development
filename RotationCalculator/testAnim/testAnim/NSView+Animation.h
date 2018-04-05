#import <Cocoa/Cocoa.h>

@interface NSView (Animation)

/*
 打印CATransform3D结构体
 */
void printTransform3d(CATransform3D transform);

/**
 以中心点为轴心，旋转指定角度
 angle，角度。比如，90度，直角。
 如果angle>0，逆时针旋转
 
 @param angle 旋转角度
 */
- (void)hpsRotateByAngle:(CGFloat)angle;

/**
 以中心点为轴心，垂直/上下翻转
 */
- (void)hpsFlipVertical;

/**
 以中心点为轴心，水平/左右翻转
 */
- (void)hpsFlipHorizontal;

/**
 立即恢复为没有修改过任何变换矩阵的原有状态，这个方法不带动画效果
 */
- (void)hpsResetRotate;

@end
