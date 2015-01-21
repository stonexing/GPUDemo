//
//  ViewController.m
//  GPUDemo
//
//  Created by Xingyan on 15/1/21.
//  Copyright (c) 2015年 Xingyan. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>

@interface ViewController ()
{
    GPUImageView *gpuImageView;
    GPUImageUIElement *pic1;
    GPUImagePicture * pic2;
    GPUImageAlphaBlendFilter *filter;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //show a UIImageView
    UIImageView *uiElement= [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 458)];
    [uiElement setImage:[UIImage imageNamed:@"Google.png"]];
    [uiElement setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:uiElement];
    
    // Creat input targer
    pic1 = [[GPUImageUIElement alloc]initWithView:uiElement];
    pic2 = [[GPUImagePicture alloc]initWithImage:[UIImage imageNamed:@"Girl.jpg"]];
    
    
    //show gpuImageView
    gpuImageView = [[GPUImageView alloc]initWithFrame:CGRectMake(350, 50, 320, 458)];
    [self.view addSubview:gpuImageView];
    
    //Blend the ImageView and the Image
    filter = [[GPUImageAlphaBlendFilter alloc]init];
    filter.mix = 0.9;
    [pic2 addTarget:filter atTextureLocation:0];
    [pic1 addTarget:filter atTextureLocation:1];
    [filter addTarget:gpuImageView];
    
    
    [pic1 update];
    [pic2 processImage];
    [filter useNextFrameForImageCapture];
    
    
    //use the Button to test the API of [GPUImageFilter imageFromCurrentFramebuffer]
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 520, 100, 44)];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"取图" forState:0];
    [button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)btnPressed:(UIButton*)btn{
    
    [pic1 update];
    [pic2 processImage];
    
    UIImage *image = [filter imageFromCurrentFramebuffer];
    
    //The image is aways be nil at the second times click the button;
    NSLog(image.debugDescription);
}

@end
