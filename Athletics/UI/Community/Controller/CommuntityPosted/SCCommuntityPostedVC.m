//
//  SCCommuntityPostedVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCCommuntityPostedVC.h"

#import "SCPostedImageCell.h"

@interface SCCommuntityPostedVC ()<UITextFieldDelegate, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SCPostedImageCellDelegate>
{
    UITextField    *_textFiled;
    UITextView     *_textView;
    UIButton       *_postdButton;
    
    UIView         *_chooseButtonView;
    UIButton       *_choosePicButton;
    UILabel        *_picNumLabel;
    UIView         *_choosePicView;
    UICollectionView   *_collectionView;
    UILabel        *_descLabel;
    NSMutableArray *_imageArray;
}

@end

static NSInteger choosePicViewH = 180.0f;
static NSString *commentCellId = @"CommentCollectionViewCellId";

@implementation SCCommuntityPostedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发表帖子";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillShowNotif:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillHiddenNotif:) name:UIKeyboardWillHideNotification object:nil];

    
     _postdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _postdButton.frame = CGRectMake(self.navigationController.navigationBar.bounds.size.width - 40, 27, 40, 30);
    [_postdButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_postdButton setTitle:@"发帖" forState:UIControlStateNormal];
    [_postdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _postdButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.m_navBar addSubview:_postdButton];
    _postdButton.enabled = NO;
    
    _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, self.m_navBar.bottom, self.view.fWidth, 44)];
    _textFiled.delegate = self;
    _textFiled.placeholder = @"输入帖子标题(必选)";
    _textFiled.backgroundColor = [UIColor clearColor];
    _textFiled.font = [UIFont systemFontOfSize:kWord_Font_28px];
    _textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_textFiled];
    _textFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _textFiled.fHeight)];
//    _textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _textFiled.fHeight)];
    _textFiled.leftViewMode = UITextFieldViewModeAlways;
//    _textFiled.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, _textFiled.fHeight - 0.5, _textFiled.fWidth - 20, 0.5)];
    line.backgroundColor = k_Border_Color;
    [_textFiled addSubview:line];
    
    _chooseButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.fHeight, self.view.fWidth, 44)];
    _chooseButtonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_chooseButtonView];
    
    UIButton *choosePicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [choosePicButton setImage:nil forState:UIControlStateNormal];
    [choosePicButton setImage:nil forState:UIControlStateSelected];
    [choosePicButton addTarget:self action:@selector(choosePicButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    choosePicButton.frame = CGRectMake(20, (_chooseButtonView.fHeight - 24.0) / 2.0, 24.0, 24.0);
    choosePicButton.backgroundColor = [UIColor cyanColor];
    [_chooseButtonView addSubview:choosePicButton];
    _choosePicButton = choosePicButton;
    
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:kWord_Font_28px];
    [self.view addSubview:_textView];
    
    _WEAKSELF(ws);
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view).offset(10);
        make.right.equalTo(ws.view).offset(-10);
        make.top.equalTo(_textFiled.mas_bottom);
        make.bottom.equalTo(_chooseButtonView.mas_top);
    }];
    
    _choosePicView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.fHeight - choosePicViewH, self.view.fWidth, choosePicViewH)];
    _choosePicView.backgroundColor = [UIColor whiteColor];
    _choosePicView.layer.borderColor = k_Border_Color.CGColor;
    _choosePicView.layer.borderWidth = .5f;
    [self.view addSubview:_choosePicView];
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, _choosePicView.fWidth, 110) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_choosePicView addSubview:_collectionView];
    
    [_collectionView registerClass:[SCPostedImageCell class] forCellWithReuseIdentifier:[SCPostedImageCell cellIdeatifier]];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:commentCellId];
    
    _imageArray = [NSMutableArray array];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _collectionView.bottom + 10, _choosePicView.fWidth - 20, 20)];
    _descLabel.font = [UIFont systemFontOfSize:kWord_Font_20px];
    _descLabel.textColor = kWord_Color_Low;
    _descLabel.textAlignment = NSTextAlignmentCenter;
    [_choosePicView addSubview:_descLabel];
    
    _descLabel.text = @"已添加3张，还可以添加6张";
    
    UIImage *image = [UIImage imageNamed:@"mine_background"];
    [_imageArray addObject:image];
    
    [_textFiled becomeFirstResponder];
    
}

-(void)rightBarButtonClicked:(UIButton *)sender {
    
    
}

- (void)choosePicButtonClicked:(UIButton *)sender {
    [self.view endEditing:YES];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SCPostedImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SCPostedImageCell cellIdeatifier] forIndexPath:indexPath];

    if (indexPath.item == _imageArray.count) {
        //+hao
        cell.hiddenDeleteButton = YES;
        cell.image = nil;
    }else {
        cell.hiddenDeleteButton = NO;
        cell.image = [_imageArray objectAtIndex:indexPath.item];
        cell.size = @"520KB";
    }
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.fWidth - 20) / 5.0, collectionView.fHeight);
}

- (void)deletePostedImageWith:(NSIndexPath *)indexPath {
    [_imageArray removeObjectAtIndex:indexPath.item];
    
    [_collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _imageArray.count) {
        //添加
        
        
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

#pragma mark - keyboard
- (void)keyboareWillShowNotif:(NSNotification *)notification {
    // 键盘信息字典
    NSDictionary* info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = CGRectGetHeight([aValue CGRectValue]);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    {
        _chooseButtonView.frame = CGRectMake(0, self.view.fHeight - keyboardHeight - _chooseButtonView.fHeight, _chooseButtonView.fWidth, _chooseButtonView.fHeight);
        _choosePicView.frame = CGRectMake(0, self.view.fHeight, _choosePicView.fWidth, _choosePicView.fHeight);
    }
    [UIView commitAnimations];
}

- (void)keyboareWillHiddenNotif:(NSNotification *)notification {
    // 键盘信息字典
    NSDictionary* info = [notification userInfo];
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    {
        _chooseButtonView.frame = CGRectMake(0, self.view.fHeight - choosePicViewH - _chooseButtonView.fHeight, _chooseButtonView.fWidth, _chooseButtonView.fHeight);
        _choosePicView.frame = CGRectMake(0, self.view.fHeight - choosePicViewH, _choosePicView.fWidth, _choosePicView.fHeight);
    }
    [UIView commitAnimations];
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
