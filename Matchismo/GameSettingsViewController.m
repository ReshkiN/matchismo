//
//  GameSettingsViewController.m
//  Matchismo
//
//  Created by Dmitry Reshetnik on 8/25/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import "GameSettingsViewController.h"
#import "GameSettings.h"

@interface GameSettingsViewController ()

@property (strong, nonatomic) GameSettings *gameSettings;
@property (weak, nonatomic) IBOutlet UIStepper *bonusStepper;
@property (weak, nonatomic) IBOutlet UIStepper *flipCostStepper;
@property (weak, nonatomic) IBOutlet UIStepper *penaltyStepper;
@property (weak, nonatomic) IBOutlet UILabel *bonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *penaltyLabal;

@end

@implementation GameSettingsViewController

- (GameSettings *)gameSettings {
    if (!_gameSettings) {
        _gameSettings = [[GameSettings alloc] init];
    }return _gameSettings;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)setupUI {
    self.bonusStepper.value = self.gameSettings.bonus;
    self.penaltyStepper.value = self.gameSettings.penalty;
    self.flipCostStepper.value = self.gameSettings.flipCost;
    self.bonusLabel.text = [NSString stringWithFormat:@"Match Bonus: %d", self.gameSettings.bonus];
    self.penaltyLabal.text = [NSString stringWithFormat:@"Mismatch Penalty: %d", self.gameSettings.penalty];
    self.flipCostLabel.text = [NSString stringWithFormat:@"Flip Cost: %d", self.gameSettings.flipCost];
}

- (IBAction)stepperBonusChanged:(UIStepper *)sender {
    self.bonusLabel.text = [NSString stringWithFormat:@"Match Bonus: %d", (int)round(self.bonusStepper.value)];
    self.gameSettings.bonus = (int)round(self.bonusStepper.value);
}

- (IBAction)stepperFlipCostChanged:(UIStepper *)sender {
    self.flipCostLabel.text = [NSString stringWithFormat:@"Flip Cost: %d", (int)round(self.flipCostStepper.value)];
    self.gameSettings.flipCost = (int)round(self.flipCostStepper.value);
}

- (IBAction)stepperPenaltyChanged:(UIStepper *)sender {
    self.penaltyLabal.text = [NSString stringWithFormat:@"Mismatch Penalty: %d", (int)round(self.penaltyStepper.value)];
    self.gameSettings.penalty = (int)round(self.penaltyStepper.value);
}

- (IBAction)setDefaultsPressed:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
