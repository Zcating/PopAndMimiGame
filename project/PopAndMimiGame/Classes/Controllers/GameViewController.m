//
//  ViewController.m
//  PopTeamEpicGame
//
//  Created by  zcating on 2018/2/8.
//  Copyright © 2018 com.zcating. All rights reserved.
//

#import "GameViewController.h"

#import "PMAnimation.h"
#import <AVFoundation/AVFoundation.h>

@interface GameViewController ()<AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mimiButton;
@property (weak, nonatomic) IBOutlet UIButton *popButton;
@property (weak, nonatomic) IBOutlet UIImageView *animationView;

@property (strong, nonatomic) NSMutableDictionary<NSString*, PMAnimation*> *animationSet;

@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAnimationView];
    [self initAudio];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initAnimationView {
    NSLog(@"%s", __func__);
    self.animationSet = [NSMutableDictionary dictionaryWithCapacity:4];
    
    PMAnimation *punchAnimation = [PMAnimation animationWithCapacity:14];
    PMAnimation *popAskingAnimation = [PMAnimation animationWithCapacity:8];
    PMAnimation *mimiAnsweringAnimation = [PMAnimation animationWithCapacity:9];
    for (int index = 0; index < 14; index++) {
        NSString *name = [NSString stringWithFormat:@"punch_%d", index];
        UIImage *image = [UIImage imageNamed:name];
        [punchAnimation.images addObject:image];
    }
    
    for (int index = 0; index < 8; index++) {
        NSString *name = [NSString stringWithFormat:@"ask_anger_%d", index];
        UIImage *image = [UIImage imageNamed:name];
        [popAskingAnimation.images addObject:image];
    }
    
    for (int index = 0; index < 9; index++) {
        NSString *name = [NSString stringWithFormat:@"not_angry_%d", index];
        UIImage *image = [UIImage imageNamed:name];
        [mimiAnsweringAnimation.images addObject:image];
    }
    
    [self.animationSet setObject:punchAnimation forKey:@"Punch"];
    [self.animationSet setObject:popAskingAnimation forKey:@"Asking"];
    [self.animationSet setObject:mimiAnsweringAnimation forKey:@"Answering"];
    
    self.animationView.animationRepeatCount = 0;
}


- (void)initAudio {
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
}


- (IBAction)playPop:(id)sender {
    [self playSoundWithFileName:@"punch"];
    [self playAnimationWithKey:@"Punch"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playSoundWithFileName:@"asking"];
        [self playAnimationWithKey:@"Asking"];
    });
//    [self playAnimationWithKey:@"AskingAnger"];
//    [self playSoundWithFileName:@"asking"];
}

- (IBAction)playMimi:(id)sender {
    [self playAnimationWithKey:@"Answering"];
    [self playSoundWithFileName:@"not_angry"];
}


- (void)playAnimationWithKey:(NSString *)key{
    NSLog(@"%@", self.animationSet[key]);
    self.animationView.animationImages = self.animationSet[key].images;
    self.animationView.animationDuration = self.animationSet[key].duration;
    [self.animationView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.animationSet[key].duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animationView stopAnimating];
    });
}

- (void)playSoundWithFileName:(NSString *)filename {

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:@"mp3"];
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    self.player.delegate = self;
    self.player.numberOfLoops = 0;
    [self.player play];
}

@end
