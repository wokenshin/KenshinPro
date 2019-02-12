//
//  LocalizedMeVC.m
//  KenshinPro
//
//  Created by apple on 2019/2/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "LocalizedMeVC.h"

@interface LocalizedMeVC ()
@property (nonatomic, weak) IBOutlet UILabel     *labLocal;
@property (nonatomic, weak) IBOutlet UIImageView *imgViewFlag;
@property (nonatomic, weak) IBOutletCollection(UILabel) NSArray *labels;

@end

@implementation LocalizedMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"未完成";
    NSLocale *locale = [NSLocale currentLocale];
    NSString *currentLangID = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *displayLang   = [locale displayNameForKey:NSLocaleLanguageCode value:currentLangID];
    NSString *capitalized   = [displayLang capitalizedStringWithLocale:locale];
    _labLocal.text = capitalized;
    
    [_labels[0] setText:NSLocalizedString(@"LABEL_ONE",   @"The number 1")];
    [_labels[1] setText:NSLocalizedString(@"LABEL_TWO",   @"The number 2")];
    [_labels[2] setText:NSLocalizedString(@"LABEL_THREE", @"The number 3")];
    [_labels[3] setText:NSLocalizedString(@"LABEL_FOUR",  @"The number 4")];
    [_labels[4] setText:NSLocalizedString(@"LABEL_FIVE",  @"The number 5")];
    
    NSString *flagFile = NSLocalizedString(@"FLAG_FILE",  @"Name of the flag");
    _imgViewFlag.image = [UIImage imageNamed:flagFile];
    
}


@end
