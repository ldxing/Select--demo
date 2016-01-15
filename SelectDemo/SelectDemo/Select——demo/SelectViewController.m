/*
 *
 *  主要思路：分为 点击 和 数据
 *      点击：点击同个cell上的不同button，只选中一个button
 *      数据：点击不同的cell之间的关系，点击全选按钮，相应的列要全部选择。。。等等
 *           cell的重用，相应的显示，展示cell 的时候判断数据。
 *
 */

#define UIHeight [[UIScreen mainScreen] bounds].size.height
#define UIWidth [[UIScreen mainScreen] bounds].size.width

#import "SelectViewController.h"
#import "SelectModel.h"
#import "SelectTableViewCell.h"

@interface SelectViewController ()<UITableViewDataSource,UITableViewDelegate,SelectTableViewCellDelegate>
{
    ///tableview
    UITableView *mainTableView;
    ///标题的数组
    NSArray * dataArray;
    ///承装model的数组
    NSMutableArray * modelArray;
    
    ///标记  全选 的cell
    SelectTableViewCell * markCell;

}


@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*  获取数据  */
    [self getData];
    /*  布局UI  */
    [self buildUI];
}

- (void)getData{
    /*  给数据数组赋值  */
     dataArray = @[@[@"列全选",@"列全选",@"列全选"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"],@[@"张小雅",@"李小二",@"孙大"]];
    /*  初始化model数组 并赋值  */
    if (!modelArray) {
        modelArray = [NSMutableArray array];
    }
    /*  保证两个数组的元素个数相同  */
    for (int i = 0 ; i < dataArray.count; i++) {
        SelectModel * model = [SelectModel new];
        model.numOfBtn = -100;
        [modelArray addObject:model];
    }

}

- (void)buildUI{
    /*  初始化tableview  */
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIWidth, UIHeight) style:UITableViewStylePlain];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.backgroundColor = [UIColor redColor];
    mainTableView.showsVerticalScrollIndicator = NO;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
    /*  返回按钮  */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(Action)];
    
    
}
- (void)Action{
    [self.navigationController  dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -----------UITableViewDataSource-----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuse1 = @"timeCell";
    SelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
    if (!cell) {
        cell = [[SelectTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuse1];
        cell.delegate = self;
    }
    NSArray * name = dataArray[indexPath.row];
    cell.titleArray = name;
    
    /*  cell出现的时候看model的属性，来展示cell上的button是否选中  */
    SelectModel * model = modelArray[indexPath.row];
    if (model.numOfBtn > 1000) {
        BtnAndLabelView * btnV = [cell.contentView viewWithTag:model.numOfBtn];
        btnV.selectBtn.selected = YES;
        /*  很重要，必须赋值，否则会使得选择发生混乱  */
        cell.selectedView = btnV;
    }
    
    return cell;
    
}
/**
 *  cell结束展示的方法
 */
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*  cell结束展示的时候让cell上的选中的button变成不选中状态  */
    [(SelectTableViewCell *)cell selectedView].selectBtn.selected = NO;
}



#pragma mark ------------------SelectTableViewCellDelegate------------

/**
 *  列全选 button点击的事件
 */
- (void)selectTableViewCell:(SelectTableViewCell *)SelectCell allBtnDidClicked:(UIButton *)btn
{
    /*  选中  */
    if (btn.selected) {
        markCell = SelectCell;
        SelectModel * model = modelArray[0];
        /*  列全选 行  */
        model.numOfBtn = btn.superview.tag;
        for (int i = 1; i < modelArray.count; i++) {
            SelectModel * model = modelArray[i];
            model.numOfBtn = btn.superview.tag;
            /*  获取btnView  */
            NSIndexPath * indxpath = [NSIndexPath indexPathForRow:i  inSection:0];
            SelectTableViewCell * cell = [mainTableView cellForRowAtIndexPath:indxpath];
            BtnAndLabelView * btnView = [cell.contentView viewWithTag:btn.superview.tag];
            /*  赋值  */
            cell.selectedView.selectBtn.selected = NO;
            btnView.selectBtn.selected = YES;
            cell.selectedView = btnView;
            
        }
    }else{
        /*  未选中  */
        SelectModel * model = modelArray[0];
        model.numOfBtn = -100;
        for (int i = 1; i < modelArray.count; i++) {
            SelectModel * model = modelArray[i];
            model.numOfBtn = -100;
            
            NSIndexPath * indxpath = [NSIndexPath indexPathForRow:i inSection:0];
            SelectTableViewCell * cell = [mainTableView cellForRowAtIndexPath:indxpath];
            
            cell.selectedView.selectBtn.selected = NO;
        }
        
        
    }
    
}
/**
 *  其他button的点击事件
 *
 *  @param SelectCell 点击的button所在的view的所在的cell
 *  @param btn        点击的button
 */
- (void)selectTableViewCell:(SelectTableViewCell *)SelectCell otherBtnDidClicked:(UIButton *)btn
{
    NSIndexPath * indxpth = [mainTableView indexPathForCell:SelectCell];
    SelectModel * model = modelArray[indxpth.row];
    if (btn.selected) {
        /*  数据改变  */
        model.numOfBtn = btn.superview.tag;
        /*  判断 全选 是否取消  */
        [self hiddenMarkCellBtn];
        /*  判断numOfBtn 的值是否相等，全部相等的话，执行  */
        if ([self countNumbers]) {
            NSInteger taggg = [modelArray[1] numOfBtn];
            NSIndexPath * indexPath  = [NSIndexPath indexPathForRow:0 inSection:0];
            SelectTableViewCell * cell = [mainTableView cellForRowAtIndexPath:indexPath];
            [(BtnAndLabelView *)[cell.contentView viewWithTag:taggg] selectBtn].selected = YES;
            ((SelectModel *)modelArray[0]).numOfBtn = taggg;
        }
    }else
    {
        model.numOfBtn = -100;
        [self hiddenMarkCellBtn];
    }
}
/**
 *  计算 所有的是否值相等
 */
- (BOOL)countNumbers{
    NSInteger nume = 120;
    for (int i = 1; i < modelArray.count -1; i++) {
        if ([modelArray[i] numOfBtn] != [modelArray[i + 1] numOfBtn]) {
            nume ++;
        }
    }
    if (nume > 120) {
        return NO;
    }else
    {
        return YES;
    }
}
/**
 *  隐藏 全选
 */
- (void)hiddenMarkCellBtn{
    if (markCell && markCell.selectedView.selectBtn.selected) {
        markCell.selectedView.selectBtn.selected = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
