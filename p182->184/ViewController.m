//
//  ViewController.m
//  p182->184
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *table;


@end

@implementation ViewController

- (IBAction)toggleEdit:(id)sender {
    self.table.editing = !self.table.editing;
}

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    NSString *inputstr = [alertView textFieldAtIndex:0].text;
    return [inputstr length]>2;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == alertView.firstOtherButtonIndex){
        UITextField *newstr = [alertView textFieldAtIndex:0];
        if(newstr.text.length>0){
            [data addObject:newstr.text];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count]-1) inSection:0];
            NSArray *row = [NSArray arrayWithObject:indexPath];
            [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row%3 ==0){
        return UITableViewCellEditingStyleNone;
    }
    else if (indexPath.row%3 ==1){
        return UITableViewCellEditingStyleDelete;
    }
    else{
        return UITableViewCellEditingStyleInsert;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(UITableViewCellEditingStyleDelete == editingStyle){
        NSLog(@"%ld 번째 삭제",indexPath.row);
        [data removeObjectAtIndex:indexPath.row];
        NSArray *rowList = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else{
        NSLog(@"%ld번째 추가",indexPath.row);
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"추가" message:Nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    cell.textLabel.text=data[indexPath.row];
    return cell;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    data =[[NSMutableArray alloc]initWithObjects:@"Item1",@"Item2",@"Item3",@"Item4",@"Item5",@"Item6",@"Item7", nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
