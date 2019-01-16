//
//  CJLoginController.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/2.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "CJLoginController.h"
#import "UserInfoModel.h"
@interface CJLoginController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isRegister;
}
@property(nonatomic,strong)UIView *middleView;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextField *secrField;
@property(nonatomic,strong)UIView *loginView;
@property(nonatomic,strong)UIView *registerView;

@property(nonatomic,strong)UIView *middleView1;
@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *email;
@property(nonatomic,strong)UITextField *phoneField1;
@property(nonatomic,strong)UITextField *secrField1;
@property(nonatomic,strong)UIButton *headImgBtn;

@property(nonatomic,strong)UIImagePickerController *imagePicker;



@end

@implementation CJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=ZXColor(22, 23, 35);

    isRegister = NO;
    
    UIBarButtonItem *leftBaritem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"9*14白箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem=leftBaritem;
    UIBarButtonItem *rightBaritem=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(regist)];
    self.navigationItem.rightBarButtonItem = rightBaritem;
    self.navigationController.navigationBar.translucent=NO;

    self.navigationController.navigationBar.barTintColor=ZXColor(22, 23, 35);
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self setUI];
}

-(void)regist{
    [self.view layoutIfNeeded];
    __weak typeof(self)mySelf = self;
    [UIView animateWithDuration:.5 animations:^{
        [mySelf.loginView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-WIDTH);
        }];
        [mySelf.view layoutIfNeeded];
    }];
    isRegister = YES;
    self.navigationItem.rightBarButtonItem.title=@"";
}

-(void)back{
    if (isRegister) {
        [self.view layoutIfNeeded];
        __weak typeof(self)mySelf = self;
        [UIView animateWithDuration:.5 animations:^{
            [mySelf.loginView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
            }];
            self.navigationItem.rightBarButtonItem.title=@"注册";

            [mySelf.view layoutIfNeeded];
        }];
        isRegister = NO;

    }
    else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setUI{
    //登录页面
    _loginView=[[UIView alloc]init];
    _loginView.backgroundColor=ZXColor(22, 23, 35);
    [self.view addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(HEIGHT);
        make.width.mas_equalTo(WIDTH);
    }];
    
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(30*WIDTHsCALE, 36*HEIGHTsCALE, 100, 54*HEIGHTsCALE)];
    titleLab.text=@"登录";
    titleLab.font=ControlFont(39);
    titleLab.textColor=[UIColor whiteColor];
    [self.loginView addSubview:titleLab];
    
    
    self.middleView=[[UIView alloc]initWithFrame:CGRectMake(30*WIDTHsCALE, 103*HEIGHTsCALE, 345*WIDTHsCALE, 265*HEIGHTsCALE)];
    self.middleView.backgroundColor=ZXColor(26, 32, 46);
    
    UILabel *phoneLab=[[UILabel alloc]initWithFrame:CGRectMake(20*WIDTHsCALE, 30*HEIGHTsCALE, 100, 22*HEIGHTsCALE)];
    phoneLab.text=@"手机号";
    phoneLab.font=ControlFont(14);
    phoneLab.textColor=ZXColor(0, 120, 255);
    
   _phoneField=[[UITextField alloc]initWithFrame:CGRectMake(20*WIDTHsCALE, CGRectGetMaxY(phoneLab.frame)+3, 325*WIDTHsCALE, 43*HEIGHTsCALE)];
    _phoneField.placeholder=@"手机号";
    [_phoneField setValue:ZXColor(109, 119, 139) forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _phoneField.textColor=[UIColor whiteColor];
    _phoneField.delegate=self;
    _phoneField.clearsOnBeginEditing=YES;

    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0,_phoneField.frame.size.height-1, _phoneField.frame.size.width, 1)];
    
    line1.backgroundColor=ZXColor(46, 53, 70);
    
    [_phoneField addSubview:line1];
    
    
    UILabel *secrLab=[[UILabel alloc]initWithFrame:CGRectMake(20*WIDTHsCALE, 110*HEIGHTsCALE, 50, 22*HEIGHTsCALE)];
    secrLab.text=@"密码";
    secrLab.font=ControlFont(14);
    secrLab.textColor=ZXColor(0, 120, 255);
    
    _secrField=[[UITextField alloc]initWithFrame:CGRectMake(20*WIDTHsCALE, CGRectGetMaxY(secrLab.frame)+3, 325*WIDTHsCALE, 43*HEIGHTsCALE)];
    _secrField.placeholder=@"密码";
    [_secrField setValue:ZXColor(109, 119, 139) forKeyPath:@"_placeholderLabel.textColor"];
    [_secrField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _secrField.textColor=[UIColor whiteColor];
    _secrField.secureTextEntry=YES;
    _secrField.clearsOnBeginEditing=YES;
    _secrField.delegate=self;
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0,_secrField.frame.size.height-1, _secrField.frame.size.width, 1)];
    
    line2.backgroundColor=ZXColor(46, 53, 70);
    
    [_secrField addSubview:line2];
    
    [self.middleView addSubview:phoneLab];
    [self.middleView addSubview:_phoneField];

    [self.middleView addSubview:secrLab];
    [self.middleView addSubview:_secrField];

    
    UIButton *ForgotBtn=[[UIButton alloc]initWithFrame:CGRectMake(20*WIDTHsCALE, 215*HEIGHTsCALE, 60*WIDTHsCALE, 16*HEIGHTsCALE)];
    [ForgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    ForgotBtn.titleLabel.font=ControlFont(11);
    [self.middleView addSubview:ForgotBtn];
    
    
    UIButton *logBtn=[[UIButton alloc]initWithFrame:CGRectMake(265*WIDTHsCALE, 200*HEIGHTsCALE, 49*HEIGHTsCALE, 49*HEIGHTsCALE)];
    [logBtn setImage:[UIImage imageNamed:@"Button"] forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleView addSubview:logBtn];
    
    
    UILabel *otherLab=[[UILabel alloc]initWithFrame:CGRectMake(153*WIDTHsCALE, 384*HEIGHTsCALE, 70, 17)];
    otherLab.text=@"其他登录方式";
    otherLab.textColor=[UIColor whiteColor];
    otherLab.font=ControlFont(11);
    [self.loginView addSubview:otherLab];
    
    UIButton *qqBtn=[[UIButton alloc]initWithFrame:CGRectMake(89*WIDTHsCALE, 422*HEIGHTsCALE, 46, 46)];
    [qqBtn setImage:[UIImage imageNamed:@"分享到-qq图标"] forState:UIControlStateNormal];
    [self.loginView addSubview:qqBtn];
    
    UIButton *wechatBtn=[[UIButton alloc]initWithFrame:CGRectMake(165*WIDTHsCALE, 422*HEIGHTsCALE, 46, 46)];
    [wechatBtn setImage:[UIImage imageNamed:@"分享到-微信好友图标"] forState:UIControlStateNormal];
    [self.loginView addSubview:wechatBtn];

    UIButton *weiboBtn=[[UIButton alloc]initWithFrame:CGRectMake(241*WIDTHsCALE, 422*HEIGHTsCALE, 46, 46)];
    [weiboBtn setImage:[UIImage imageNamed:@"分享到-新浪微博图标"] forState:UIControlStateNormal];
    [self.loginView addSubview:weiboBtn];

    [self.loginView addSubview:self.middleView];
    
    
    //注册页面
    
    _registerView=[[UIView alloc]init];
    _registerView.backgroundColor=ZXColor(22, 23, 35);
    [self.view addSubview:_registerView];
    [_registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginView.mas_right);
        make.top.mas_equalTo(self.loginView.mas_top);
        make.width.mas_equalTo(self.loginView.mas_width);
        make.height.mas_equalTo(self.loginView.mas_height);
    }];
    
    
    UILabel *titleLab1=[[UILabel alloc]initWithFrame:CGRectMake(30*WIDTHsCALE, 36*HEIGHTsCALE, 100, 54*HEIGHTsCALE)];
    titleLab1.text=@"注册";
    titleLab1.font=ControlFont(39);
    titleLab1.textColor=[UIColor whiteColor];
    [self.registerView addSubview:titleLab1];
    
    
    self.middleView1=[[UIView alloc]initWithFrame:CGRectMake(30*WIDTHsCALE, 103*HEIGHTsCALE, 345*WIDTHsCALE, 498*HEIGHTsCALE)];
    self.middleView1.backgroundColor=ZXColor(26, 32, 46);
    
    
    _headImgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_headImgBtn setImage:[UIImage imageNamed:@"Icon"] forState:UIControlStateNormal];
    [_headImgBtn setTitle:@"选择照片" forState:UIControlStateNormal];
    _headImgBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headImgBtn setTitleColor:ZXColor(109, 119, 139) forState:UIControlStateNormal];
    [_headImgBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -180*WIDTHsCALE, 0, 0)];
    [_headImgBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -160*WIDTHsCALE, 0, 0)];
    [_headImgBtn addTarget:self action:@selector(addImg:) forControlEvents:UIControlEventTouchUpInside];
    _headImgBtn.tintColor=ZXColor(26, 34, 50);
    [self.middleView1 addSubview:_headImgBtn];
    [_headImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView1.mas_top);
        make.left.equalTo(self.middleView1.mas_left);
        make.width.mas_equalTo(self.middleView1.mas_width);
        make.height.mas_equalTo(87*HEIGHTsCALE);
    }];
    
    UILabel *userNameLab=[[UILabel alloc]init];
    userNameLab.text=@"用户名";
    userNameLab.font=ControlFont(14);
    userNameLab.textColor=ZXColor(0, 120, 255);
    [self.middleView1 addSubview:userNameLab];
    [userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(self.headImgBtn.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(22*HEIGHTsCALE);
    }];
    
    _userName=[[UITextField alloc]init];
    _userName.placeholder=@"用户名";
    [_userName setValue:ZXColor(109, 119, 139) forKeyPath:@"_placeholderLabel.textColor"];
    [_userName setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _userName.textColor=[UIColor whiteColor];
    _userName.delegate=self;
    _userName.clearsOnBeginEditing=YES;
    [self.middleView1 addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(userNameLab.mas_bottom).offset(3);
        make.width.mas_equalTo(325*WIDTHsCALE);
        make.height.mas_equalTo(43*HEIGHTsCALE);
    }];
    
    
    UIView *line5=[[UIView alloc]init];
    
    line5.backgroundColor=ZXColor(46, 53, 70);
    [self.userName addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName.mas_left);
        make.top.equalTo(self.userName.mas_bottom);
        make.width.mas_equalTo(self.userName.mas_width);
        make.height.mas_equalTo(1);
    }];
    
    
    UILabel *emailLab=[[UILabel alloc]init];
    emailLab.text=@"邮箱";
    emailLab.font=ControlFont(14);
    emailLab.textColor=ZXColor(0, 120, 255);
    [self.middleView1 addSubview:emailLab];
    [emailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(self.userName.mas_bottom).offset(15*HEIGHTsCALE);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(22*HEIGHTsCALE);
    }];
//
    _email=[[UITextField alloc]init];
    _email.placeholder=@"邮箱";
    [_email setValue:ZXColor(109, 119, 139) forKeyPath:@"_placeholderLabel.textColor"];
    [_email setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _email.textColor=[UIColor whiteColor];
    _email.delegate=self;
    _email.clearsOnBeginEditing=YES;
    [self.middleView1 addSubview:_email];
    [_email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(emailLab.mas_bottom).offset(3);
        make.width.mas_equalTo(325*WIDTHsCALE);
        make.height.mas_equalTo(43*HEIGHTsCALE);
    }];


    UIView *line6=[[UIView alloc]init];

    line6.backgroundColor=ZXColor(46, 53, 70);
    [self.email addSubview:line6];
    [line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.email.mas_left);
        make.top.equalTo(self.email.mas_bottom).offset(-1);
        make.width.mas_equalTo(self.email.mas_width);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *phoneLab1=[[UILabel alloc]init];
    phoneLab1.text=@"邮箱";
    phoneLab1.font=ControlFont(14);
    phoneLab1.textColor=ZXColor(0, 120, 255);
    [self.middleView1 addSubview:phoneLab1];
    [phoneLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(self.email.mas_bottom).offset(15*HEIGHTsCALE);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(22*HEIGHTsCALE);
    }];
    //
    _phoneField1=[[UITextField alloc]init];
    _phoneField1.placeholder=@"邮箱";
    [_phoneField1 setValue:ZXColor(109, 119, 139) forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneField1 setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _phoneField1.textColor=[UIColor whiteColor];
    _phoneField1.delegate=self;
    _phoneField1.clearsOnBeginEditing=YES;
    [self.middleView1 addSubview:_phoneField1];
    [_phoneField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(phoneLab1.mas_bottom).offset(3);
        make.width.mas_equalTo(325*WIDTHsCALE);
        make.height.mas_equalTo(43*HEIGHTsCALE);
    }];
    
    
    UIView *line7=[[UIView alloc]init];
    
    line7.backgroundColor=ZXColor(46, 53, 70);
    [self.phoneField1 addSubview:line7];
    [line7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneField1.mas_left);
        make.top.equalTo(self.phoneField1.mas_bottom).offset(-1);
        make.width.mas_equalTo(self.phoneField1.mas_width);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *secreLab1=[[UILabel alloc]init];
    secreLab1.text=@"邮箱";
    secreLab1.font=ControlFont(14);
    secreLab1.textColor=ZXColor(0, 120, 255);
    [self.middleView1 addSubview:secreLab1];
    [secreLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(self.phoneField1.mas_bottom).offset(15*HEIGHTsCALE);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(22*HEIGHTsCALE);
    }];
    //
    _secrField1=[[UITextField alloc]init];
    _secrField1.placeholder=@"邮箱";
    [_secrField1 setValue:ZXColor(109, 119, 139) forKeyPath:@"_placeholderLabel.textColor"];
    [_secrField1 setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _secrField1.textColor=[UIColor whiteColor];
    _secrField1.delegate=self;
    _secrField1.clearsOnBeginEditing=YES;
    [self.middleView1 addSubview:_secrField1];
    [_secrField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(secreLab1.mas_bottom).offset(3);
        make.width.mas_equalTo(325*WIDTHsCALE);
        make.height.mas_equalTo(43*HEIGHTsCALE);
    }];
    
    
    UIView *line8=[[UIView alloc]init];
    
    line8.backgroundColor=ZXColor(46, 53, 70);
    [self.secrField1 addSubview:line8];
    [line8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secrField1.mas_left);
        make.top.equalTo(self.secrField1.mas_bottom).offset(-1);
        make.width.mas_equalTo(self.secrField1.mas_width);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setTitle:@"我已经同意用户协议条款" forState:UIControlStateNormal];
    agreeBtn.titleLabel.font=ControlFont(11);
    [self.middleView1 addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1.mas_left).offset(20*WIDTHsCALE);
        make.top.equalTo(self.secrField1.mas_bottom).offset(30*HEIGHTsCALE);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
    }];
    
    
    UIButton *registBtn=[[UIButton alloc]initWithFrame:CGRectMake(265*WIDTHsCALE, 200*HEIGHTsCALE, 49*HEIGHTsCALE, 49*HEIGHTsCALE)];
    [registBtn setImage:[UIImage imageNamed:@"Button"] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(endRegist:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleView1 addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView1).offset(265*WIDTHsCALE);
        make.centerY.equalTo(agreeBtn.mas_centerY);
        make.width.mas_equalTo(49*HEIGHTsCALE);
        make.height.mas_equalTo(49*HEIGHTsCALE);
    }];

    [self.registerView addSubview:self.middleView1];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneField resignFirstResponder];
    [_secrField resignFirstResponder];

    [_userName resignFirstResponder];
    [_email resignFirstResponder];
    [_phoneField1 resignFirstResponder];
    [_secrField1 resignFirstResponder];

}

-(void)addImg:(id)sender{
    //自定义消息框
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    sheet.tag = 2550;
    //显示消息框
    [sheet showInView:self.view];
   
}

-(void)endRegist:(id)sender{
    
}

-(void)logIn:(id)sender{
    [_phoneField resignFirstResponder];
    [_secrField resignFirstResponder];
    __weak typeof(self)mySelf = self;
    if ([PPNetworkHelper currentNetworkStatus]) { //如果有网
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSString *account = _phoneField.text;
        NSString *password = _secrField.text;
        params[@"account"] = account;
        params[@"password"] = password;
        
        NSString *url =@"https://www.chongwu001.com/api/user/login";
        
        [PPNetworkHelper POST:url parameters:params success:^(id responseObject) {
            NSLog(@"呵呵呵呵呵额=%@",responseObject);
            NSDictionary *dic=responseObject[@"data"][@"userinfo"];
            UserInfoModel *model=[[UserInfoModel alloc]initWithDictionary:dic];
            [singleten shareUserModel].model = model;
        
            //存储用户信息
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //存储登录状态
            [defaults setBool:YES forKey:Login];
            //保存用户名和密码
            [defaults setObject:mySelf.phoneField.text forKey:Account];
            [defaults setObject:mySelf.secrField.text forKey:Password];
            //刷新存储
            [defaults synchronize];
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 2550) {
        NSUInteger sourceType = 0;
        // 判断系统是否支持相机
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerController.delegate = self; //设置代理
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = sourceType; //图片来源
            if (buttonIndex == 0) {
                return;
            }else if (buttonIndex == 1) {
                //拍照
                sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.sourceType = sourceType;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }else if (buttonIndex == 2){
                //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePickerController.sourceType = sourceType;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }else {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.sourceType = sourceType;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    [_headImgBtn setImage:image forState:UIControlStateNormal];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
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
