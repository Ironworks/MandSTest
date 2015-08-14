//
//  ViewController.m
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import "ViewController.h"
#import "Universe.h"
#import "AlienShip.h"
#import "NetworkManager.h"

//Default email address
NSString * const kEmail = @"trevor.doodes@googlemail.com";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (strong, nonatomic) AlienShip *ship;
@property (strong, nonatomic) NetworkManager *networkManager;


- (IBAction)submitButtonPressed:(id)sender;
@end

@implementation ViewController {
    
    NSArray *_directions;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.activityLabel.text = @"Getting data, please wait";
    
    //Create a universe (10 x 10)
    Universe *universe = [[Universe alloc] initWithDimension:10];
    
    //Create a ship
    self.ship = [[AlienShip alloc] initWithUniverse:universe];


    //Create a network manager
    self.networkManager = [[NetworkManager alloc] init];
    
    //Create a weak reference to self to avoid retain cycle in block
    __weak typeof (self) weakSelf = self;
    
    
    
    //Get the navigation data from the server
    [self.networkManager probeNavigationGetDataForEmail:kEmail
                                         requestSuccess:^(NSArray *directionsArray) {
                                             
                                             _directions = [directionsArray copy];
                                             [weakSelf startnavigation];
                                         } requestFailure:^(NSString *message, NSInteger statusCode) {
                                             
                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                             message:message
                                                                                            delegate:nil
                                                                                   cancelButtonTitle:@"OK"
                                                                                   otherButtonTitles:nil, nil];
                                             
                                             [alert show];
                                             
                                         }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Perform the direction instructions to move the ship in the universe
 */
- (void) startnavigation {
    
    self.activityLabel.text = @"Data recieved, starting navigation";
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (NSString *direction in _directions) {
            
            sleep(1); //Add delay to add some suspense!!!!
            
            if ([self.ship performManoeuvre:direction]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.activityLabel.text = [NSString stringWithFormat:@"Manoeuvre: %@,\n New Coords: (%.0f,%.0f)",
                                               direction,
                                               self.ship.coordinates.x,
                                               self.ship.coordinates.y];

                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"The Aliens have left the universe"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    
                    [alert show];

                });
                
                
                //Abort, abort!!!!!!
                return;
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self navigationComplete];
        });
        
    });
    
    

    
}

/**
 *  navigation is complete so we need to report it back to the server
 *  so the probe can be launched.
 */
- (void) navigationComplete {
    
    self.activityLabel.text = [NSString stringWithFormat:@"Final coordinates are: (%.0f, %.0f)",
                               self.ship.coordinates.x,
                               self.ship.coordinates.y];
    self.submitButton.hidden = NO;
    
    
    
}

- (IBAction)submitButtonPressed:(id)sender {
    
    self.activityLabel.text = @"Sending coordinates to server";
    
    [self.networkManager probeNavigationSubmitDataForEmail:kEmail
                                               coordinates:self.ship.coordinates
                                            requestSuccess:^(NSString *message, NSInteger statusCode) {
                                                self.activityLabel.text = message;
                                                self.submitButton.hidden = YES;
                                            } requestFailure:^(NSString *message, NSInteger statusCode) {
                                                self.activityLabel.text = message;
                                                self.submitButton.hidden = YES;
                                            }];
    
}


@end
