//___FILEHEADER___

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAMEASIDENTIFIER___ ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
}

- (void)createUI {}

#pragma mark - update
//- (void)updateUI {}

#pragma mark - override
#pragma mark - public
#pragma mark - private
#pragma mark - getter / setter
#pragma mark - dealloc
//- (void)dealloc {}

@end
