//
//  HYTableViewController.m
//  weibo
//
//  Created by zhangfuqiang on 15/11/24.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYTableViewController.h"

@interface HYTableViewController ()

@end

@implementation HYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tablecell"];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tablecell"];
    }
    cell.textLabel.text = @"自从郭涛被学校开除后，算上这一次，我也就见过他两次面但是每一次见面，我都恨不得把郭涛那孙子抽筋、扒皮现在我对郭涛的恨，可以用恨之入骨来来形容没错，有一种恨也是刻骨铭心的听到电话那头叶峰的话。我说：那小子惹到我了，我要报复。这个时候电话那头的叶峰似乎比刚刚清醒了许多。叶峰在电话那头说：我对那小子头同样也是恨之入骨，麻痹的我15万被骗走了，还他妈一个好没捞上。说到这里，叶峰在电话那头打了一个哈欠。打完一个哈欠后，叶峰说：其实我也想过办那小子一次，也派人调查过，不过那小子好像是住在九爷的家里。听到叶峰叶峰这话，我突然间想起了一件事儿。就是那次秦牧九的寿宴宴会上，秦牧九曾自己说过郭涛是他干儿子。电话那端的叶峰说完这话后，然后深深的发出了一声叹息，哎了声。而后叶峰说道：如果不是那小子在秦牧九家里住，我早就办他了。叶峰说完这话后，停顿了一下。片刻后。叶峰突然说：我感觉李哥的死，我应该跟秦牧九有关。从叶峰嘴里人突然冒出了这么一句话，我也是大吃一惊。我一直以为叶峰再也不愿意提起关于李哥死这件事儿了。缓回神后，我皱了皱眉头，然后说：为什么这么说？电话那头，叶峰停顿了一下，然后说：也是我猜的，应该说是一种直觉。说完这话后，叶峰话锋突然又转了一下。然后对我说道：其实我觉得还有一个人杀死李哥的嫌疑大。电话那头的叶峰说这话，挺犹豫的。从叶峰说话发的犹豫中，我已经猜到了他接下来要说出的人名。跟我想的一样，叶峰说出的人名，是郑磊。说完郑磊的名字，叶峰解释道：这也是我的猜测。但是总觉得郑磊的出现了似乎太巧了，像是突然间冒出了这么一个人。并且这个人还是呼风唤雨的一个人物。此时叶峰一顿，然后说：并且似乎郑磊的背景，以及郑磊背后的那股子强大力量非常神秘，让人琢磨不透。";
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
