//
//  ViewController.m
//  KVO(键值观察)
//
//  Created by youngstar on 16/4/12.
//  Copyright © 2016年 杨铭星. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:(CGRectMake(100, 200, 100, 40))];
    textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textField];
    
    self.person = [[Person alloc]init];
    _person.name = @"Jose";
    
   /*
    KVO只能监听通过set方法修改的值
    如果使用KVO监听某个对象的属性, 当对象释放之前一定要移除监听
    经典错误：reason: 'An instance 0x7f9483516610 of class Person was deallocated while key value observers were still registered with it.
    */
    
    // 注册观察者
    [_person addObserver:self  forKeyPath:@"name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    for (int i = 0; i < 100; i++)
    {
        NSLog(@"i= %d", i);
        if (i == 88) {
            _person.name = @"Rose";
            
            // 从p对象上移除self对它的age属性的监听
            [_person removeObserver:self forKeyPath:@"name"];
            
             _person.name = @"Jack";  // 监听已经被移除
        }
    }
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    NSString *oldName = [change objectForKey:@"old"];
    NSString *newName = [change objectForKey:@"new"];
   
    NSLog(@"oldName:%@  newName:%@", oldName, newName);
    
    
    NSLog(@"keyPath:%@, object:%@, newName:%@, context:%@", keyPath, object, change, context);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
