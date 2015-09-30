#import "ViewController.h"
#import "QBaseLanguage.h"

@interface ViewController ()
{
    UILabel *_label;
}
@end

@implementation ViewController

- (void)setUp
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 100)];
    _label.text = qbase_language_get_message(@"hello", @"你好");
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
}

#pragma mark -
#pragma mark 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"语言国际化测试";
    
    [self setUp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    qbase_language_add_listener(self, @selector(languageChanged:));

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    qbase_language_remove_listener(self);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    
    if (i++%2) {
        qbase_language_set_language(QBaseLanguage_en);
    }else {
        qbase_language_set_language(QBaseLanguage_zh_Hans);
    }
}

#pragma mark -
#pragma mark Notification Callback

- (void)languageChanged:(NSNotification *)note
{
    _label.text = qbase_language_get_message(@"hello", @"你好");
}

@end
