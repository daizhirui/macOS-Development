#import "ViewController.h"
#import "HPSPlainView.h"
#import "NSView+Animation.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController(){
}

@property (weak) IBOutlet HPSPlainView *someView;

@property (weak) IBOutlet NSTextField *m11Field;
@property (weak) IBOutlet NSTextField *m12Field;
@property (weak) IBOutlet NSTextField *m13Field;
@property (weak) IBOutlet NSTextField *m14Field;
@property (weak) IBOutlet NSTextField *m21Field;
@property (weak) IBOutlet NSTextField *m22Field;
@property (weak) IBOutlet NSTextField *m23Field;
@property (weak) IBOutlet NSTextField *m24Field;
@property (weak) IBOutlet NSTextField *m31Field;
@property (weak) IBOutlet NSTextField *m32Field;
@property (weak) IBOutlet NSTextField *m33Field;
@property (weak) IBOutlet NSTextField *m34Field;
@property (weak) IBOutlet NSTextField *m41Field;
@property (weak) IBOutlet NSTextField *m42Field;
@property (weak) IBOutlet NSTextField *m43Field;
@property (weak) IBOutlet NSTextField *m44Field;

@property (weak) IBOutlet NSTextField *aField;
@property (weak) IBOutlet NSTextField *bField;
@property (weak) IBOutlet NSTextField *cField;
@property (weak) IBOutlet NSTextField *dField;
@property (weak) IBOutlet NSTextField *txField;
@property (weak) IBOutlet NSTextField *tyField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [_someView setWantsLayer:YES];
    
    [_someView addObserver:self
                forKeyPath:@"layer.transform"
                   options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                   context:NULL];
}

float roundValue(float value){
    if(fabs(value - 0.0)<0.000001){
        return 0;
    }else{
        return value;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    _m11Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m11)];
    _m12Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m12)];
    _m13Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m13)];
    _m14Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m14)];
    
    _m21Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m21)];
    _m22Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m22)];
    _m23Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m23)];
    _m24Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m24)];
    
    _m31Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m31)];
    _m32Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m32)];
    _m33Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m33)];
    _m34Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m34)];
    
    _m41Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m41)];
    _m42Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m42)];
    _m43Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m43)];
    _m44Field.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.transform.m44)];
    
    _aField.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.affineTransform.a)];
    _bField.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.affineTransform.b)];
    _cField.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.affineTransform.c)];
    _dField.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.affineTransform.d)];
    _txField.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.affineTransform.tx)];
    _tyField.stringValue = [NSString stringWithFormat:@"%.0f", roundValue(_someView.layer.affineTransform.ty)];
}

- (IBAction)verticalFlipButtonAction:(id)sender{
    [_someView hpsFlipVertical];
}

- (IBAction)horizontalFlipButtonAction:(id)sender{
    [_someView hpsFlipHorizontal];
}

- (IBAction)leftRoateButtonAction:(id)sender{
    [_someView hpsRotateByAngle:90];
}

- (IBAction)rightRoateButtonAction:(id)sender{
    [_someView hpsRotateByAngle:-90];
}

- (IBAction)resetButtonAction:(id)sender{
    [_someView hpsResetRotate];
}

@end
