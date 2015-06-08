//
//  ViewController.h
//  CameraApp
//
//  Created by Ricardo Champa on 07/06/15.
//  Copyright (c) 2015 Clickmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSMutableData+Multipart.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagen;
- (IBAction)hacerFoto:(id)sender;
- (IBAction)seleccionarFoto:(id)sender;
- (IBAction)subirImagen:(id)sender;

@end

