//
//  ViewController.m
//  CameraApp
//
//  Created by Ricardo Champa on 07/06/15.
//  Copyright (c) 2015 Clickmobile. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL thereIsCamera;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
        thereIsCamera = NO;
        
    }
    else{
        thereIsCamera = YES;
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imagen.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)hacerFoto:(id)sender {
    
    if(thereIsCamera){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else{
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }
    
}

- (IBAction)seleccionarFoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)subirImagen:(id)sender {
    NSData *imageData = UIImagePNGRepresentation(self.imagen.image);
    
    NSString *urlString = @"http://192.168.1.121/subirfichero/subir.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"myIOSboundary";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body initMultipart:boundary];
    [body addPart:@"id" withValue:@"23"];
    [body addPart:@"myFile" withFileName:@"imagen.png" withNSData:imageData];
    [body addPart:@"comentario" withValue:@"un comentario"];
    [body writeLastBoundary];
    [request setHTTPBody:body];
    
    NSURLResponse* response = nil;
    NSError* err = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
    NSInteger statusCode = [HTTPResponse statusCode];
    
    NSString* mensaje = [NSString stringWithFormat:@"Respuesta: %ld",(long)statusCode];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Servidor"
                                                          message:mensaje
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
    
    NSLog(@"Response Meta: %@", response);
    NSLog(@"String sent from server %@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);

    
}
@end
