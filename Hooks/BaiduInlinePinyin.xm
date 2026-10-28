#import <UIKit/UIKit.h>
#import <UIKit/UIInputViewController.h>
#import <substrate.h>

static UIInputViewController *gKB;

%hook BIInputViewController
- (void)viewDidLoad {
    %orig;
    gKB = (UIInputViewController *)self;
}
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    gKB = (UIInputViewController *)self;
}
%end

%hook BICoreManager
- (void)updateMainCand:(id)cand inputTitle:(NSString *)title type:(NSInteger)type {
    %orig;
    if (!gKB) return;
    id<UIInputViewController> kb = gKB;
    id proxy = [kb textDocumentProxy];
    if (!proxy) return;
    @try {
        if ([title isKindOfClass:[NSString class]] && title.length > 0) {
            [proxy setMarkedText:title selectedRange:NSMakeRange(title.length, 0)];
        } else {
            [proxy setMarkedText:@"" selectedRange:NSMakeRange(0, 0)];
        }
    } @catch (NSException *e) {}
}

- (void)updateMainCandAndTitleFromCoreEventData:(id)data type:(NSInteger)type {
    %orig;
    if (!gKB) return;
    id proxy = [gKB textDocumentProxy];
    if (!proxy) return;
    @try {
        id sub = [data valueForKey:@"subCand"] ?: [data valueForKey:@"cand"];
        NSString *title = [sub valueForKey:@"inputTitle"];
        if ([title isKindOfClass:[NSString class]] && title.length > 0) {
            [proxy setMarkedText:title selectedRange:NSMakeRange(title.length, 0)];
        } else {
            [proxy setMarkedText:@"" selectedRange:NSMakeRange(0, 0)];
        }
    } @catch (NSException *e) {}
}
%end
