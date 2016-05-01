//
//  SCCommuntityPostedVC.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/14.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCCommuntityPostedVC.h"

#import "SCPostedImageCell.h"
#import "SCImageModel.h"
#import "SCPhotoManager.h"
#import "SCUploadTokenModel.h"
#import "SCQiNiuUploadManager.h"

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillShowNotif:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboareWillHiddenNotif:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[self class]];
    [[[IQKeyboardManager sharedManager] disabledToolbarClasses] addObject:[self class]];
    
    self.title = @"发表帖子";

    
     _postdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _postdButton.frame = CGRectMake(self.navigationController.navigationBar.bounds.size.width - 40, 27, 40, 30);
    [_postdButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_postdButton setTitle:@"发帖" forState:UIControlStateNormal];
    [_postdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _postdButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.m_navBar addSubview:_postdButton];
    
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
    [choosePicButton setImage:[UIImage imageNamed:@"news_images"] forState:UIControlStateNormal];
    [choosePicButton setImage:[UIImage imageNamed:@"news_selected_images"] forState:UIControlStateSelected];
    [choosePicButton addTarget:self action:@selector(choosePicButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    choosePicButton.frame = CGRectMake(20, (_chooseButtonView.fHeight - 24.0) / 2.0, 24.0, 24.0);
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
    
    _descLabel.text = @"已添加0张，还可以添加9张";
    
    [_textFiled becomeFirstResponder];
    
}

-(void)rightBarButtonClicked:(UIButton *)sender {
    //发帖
    
    if ([SCGlobaUtil isEmpty:_textFiled.text]) {
        [self postMessage:@"标题不能为空"];
        return;
    }
    if ([SCGlobaUtil isEmpty:_textView.text]) {
        [self postMessage:@"内容不能为空"];
        return;
    }
    if (_textView.text.length < 15) {
        [self postMessage:@"内容不能少于15个字"];
        return;
    }
    
    NSString *imageJsonStr = @"[";

    for (int i = 0; i < _imageArray.count; i++) {
        SCImageModel *model = [_imageArray objectAtIndex:i];
        NSString *json = [model toJSONStringWithKeys:@[@"url", @"width", @"height", @"size"]];
        imageJsonStr = [imageJsonStr stringByAppendingString:[NSString stringWithFormat:@"%@,", json]];
    }
    
    imageJsonStr = [imageJsonStr stringByAppendingString:@"]"];
    
    MBProgressHUD *hud = [SCProgressHUD MBHudWithText:@"发帖中" showAddTo:self.view delay:NO];
    self.sessionTask = [SCNetwork topicAddWithTitle:_textFiled.text channelId:_channelId content:_textView.text imageJsonStr:imageJsonStr success:^(SCResponseModel *model) {
        [self postMessage:@"发帖成功，等待审核"];
        [hud hideAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } message:^(NSString *resultMsg) {
        [hud hideAnimated:YES];
        [self postMessage:resultMsg];
    }];
    
}

- (void)choosePicButtonClicked:(UIButton *)sender {
    sender.selected = YES;
    [self.view endEditing:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (_imageArray.count < 9) {
        count = _imageArray.count + 1;
    }else {
        count = 9;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCPostedImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SCPostedImageCell cellIdeatifier] forIndexPath:indexPath];

    if (_imageArray.count != 9 && indexPath.item == _imageArray.count) {
        //+hao
        cell.hiddenDeleteButton = YES;
        cell.image =[UIImage imageNamed:@"add_images"];
    }else {
        cell.hiddenDeleteButton = NO;
        SCImageModel *model = [_imageArray objectAtIndex:indexPath.item];
        cell.image = model.image;
        NSString *size = @"0K";
        if ([SCGlobaUtil getFloat:model.size] > 1024 * 1024) {
            size = [NSString stringWithFormat:@"%dK", [SCGlobaUtil getInt:model.size] / 1024];
        }else {
            size = [NSString stringWithFormat:@"%dM", [SCGlobaUtil getInt:model.size] / (1024 * 1024)];
        }
        cell.size = size;
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
        [[SCPhotoManager shared] showActionSheetInView:self.view fromController:self completion:^(UIImage *image) {
            [self uploadImage:image];
        } cancel:^{}];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (void)uploadImage:(UIImage *)image {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"上传中.." showAddTo:self.view delay:NO];
    self.sessionTask = [SCNetwork getUploadTokenWithSuccess:^(SCUploadTokenModel *model) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", dateStr, [SCUserInfoManager uid]];
        fileName = [fileName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [HUD hideAnimated:YES];
        MBProgressHUD *HUD = [SCProgressHUD MBHudWithText:@"上传中.." showAddTo:self.view delay:NO];
        [[SCQiNiuUploadManager shared] uploadWithData:imageData fileName:fileName token:model.data.uploadToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            [HUD hideAnimated:YES];
            NSString *downloadUrl = [NSString stringWithFormat:@"%@/%@", model.data.spaceUrl, key];
            SCImageModel *model = [[SCImageModel alloc] init];
            model.size = [NSString stringWithFormat:@"%ld", lroundf(imageData.length)];
            model.width = [NSString stringWithFormat:@"%ld", lroundf(image.size.width)];
            model.height = [NSString stringWithFormat:@"%ld", lroundf(image.size.height)];
            model.url = downloadUrl;
            model.image = image;
            [_imageArray addObject:model];
            [_collectionView reloadData];
            _descLabel.text = [NSString stringWithFormat:@"已添加%ld张，还可以添加%ld张", _imageArray.count, 9 - _imageArray.count];
        } option:nil];

    } message:^(NSString *resultMsg) {
        [HUD hideAnimated:YES];
        [self postMessage:resultMsg];
    }];
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
