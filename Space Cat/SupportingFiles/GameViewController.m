//
//  GameViewController.m
//  Space Cat
//
//  Created by Chris William Sehnert on 9/13/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import "GameViewController.h"
#import "TitleScene.h"

@implementation GameViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    // Load 'TitleScene.sks' as a GKScene. This provides gameplay related content
    // including entities and graphs.
    GKScene *scene = [GKScene sceneWithFileNamed:@"TitleScene"];
    
    // Get the SKScene from the loaded GKScene
    TitleScene *sceneNode = (TitleScene *)scene.rootNode;
    
    // Copy gameplay related content over to the scene
    sceneNode.entities = [scene.entities mutableCopy];
    sceneNode.graphs = [scene.graphs mutableCopy];
    
    // Set the scale mode to scale to fit the window
    sceneNode.scaleMode = SKSceneScaleModeAspectFit;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:sceneNode];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
