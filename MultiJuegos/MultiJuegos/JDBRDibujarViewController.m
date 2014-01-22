//
//  JDBRDibujarViewController.m
//  MultiJuegos
//
//  Created by Juan Diego Barrera Román on 08/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JDBRDibujarViewController.h"

@interface JDBRDibujarViewController ()

@end

@implementation JDBRDibujarViewController
@synthesize image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSString *tituloTabBar = @"DIBUJAR";
        self.title = tituloTabBar;
        //self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    pincel = 4.0;
    rojo = 0.0;
    verde = 0.0;
    azul = 1.0;
    

    image.multipleTouchEnabled = NO;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    previousPoint1 = [touch previousLocationInView:image];
    currentPoint = [touch locationInView:image];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    previousPoint1 = [touch previousLocationInView:image];
    currentPoint = [touch locationInView:image];
    
    UIGraphicsBeginImageContext(image.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image.image drawInRect:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
    CGContextMoveToPoint(context, previousPoint1.x, previousPoint1.y);
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, pincel);
    CGContextSetRGBStrokeColor(context, rojo, verde, azul, 1.0);
    CGContextStrokePath(context);
    
    image.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
}

-(IBAction)sliderSeMueve:(id)sender
{
    UISlider *sliderAux = (UISlider *) sender;
    NSString *e = [[NSString alloc] initWithFormat:@"%d",(int)[sliderAux value]];
    pincel = [sliderAux value];
    [etiquetaSlider setText:e];
    [e release];
}

-(IBAction)cambioDeColor:(id)sender
{
    int tag = [sender tag];
    switch (tag) {
        case 1:
        {
            //CAMBIO LOS COLORES
            rojo = 0.0;
            verde = 0.0;
            azul = 1.0;
            
            //CAMBIO LA ETIQUETA
            NSString *stringAzul = [[NSString alloc]initWithString:@"Azul"];
            [etiquetaColor setText:stringAzul];
            [etiquetaColor setTextColor:[UIColor blueColor]];            
            [stringAzul release];
            break;
        }
        case 2:
        {
            //CAMBIO LOS COLORES
            rojo = 0.0;
            verde = 1.0;
            azul = 0.0;
            
            //CAMBIO LA ETIQUETA
            NSString *stringVerde = [[NSString alloc]initWithString:@"Verde"];
            [etiquetaColor setText:stringVerde];
            [etiquetaColor setTextColor:[UIColor greenColor]];            
            [stringVerde release];
            break;
        }            
        case 3:
        {
            //CAMBIO LOS COLORES
            rojo = 1.0;
            verde = 0.0;
            azul = 0.0;
            
            //CAMBIO LA ETIQUETA
            NSString *stringRojo = [[NSString alloc]initWithString:@"Rojo"];
            [etiquetaColor setText:stringRojo];
            [etiquetaColor setTextColor:[UIColor redColor]];            
            [stringRojo release];
            break;
        }            
        case 4:
        {
            //CAMBIO LOS COLORES
            rojo = 0.0;
            verde = 0.0;
            azul = 0.0;
            
            //CAMBIO LA ETIQUETA
            NSString *StringNegro = [[NSString alloc]initWithString:@"Negro"];
            [etiquetaColor setText:StringNegro];
            [etiquetaColor setTextColor:[UIColor blackColor]];            
            [StringNegro release];
            break;
        }
        case 5:
        {
            //CAMBIO LOS COLORES
            rojo = 1.0;
            verde = 1.0;
            azul = 1.0;
            
            //CAMBIO LA ETIQUETA
            NSString *StringBlanco = [[NSString alloc]initWithString:@"Blanco"];
            [etiquetaColor setText:StringBlanco];
            [etiquetaColor setTextColor:[UIColor whiteColor]];
            [StringBlanco release];
            break;
        }
        case 6:
        {
            //CAMBIO LOS COLORES
            rojo = 0.5;
            verde = 0.5;
            azul = 0.5;
            
            //CAMBIO LA ETIQUETA
            NSString *StringGris = [[NSString alloc]initWithString:@"Gris"];
            [etiquetaColor setText:StringGris];
            [etiquetaColor setTextColor:[UIColor grayColor]];
            [StringGris release];
            break;
        }
        case 7:
        {
            //CAMBIO LOS COLORES
            rojo = 0.7;
            verde = 0.2;
            azul = 0.8;
            
            //CAMBIO LA ETIQUETA
            NSString *StringMorado = [[NSString alloc]initWithString:@"Morado"];
            [etiquetaColor setText:StringMorado];
            [etiquetaColor setTextColor:[UIColor purpleColor]];
            [StringMorado release];
            break;
        }
        case 8:
        {
            //CAMBIO LOS COLORES
            rojo = 1.0;
            verde = 1.0;
            azul = 0.2;
            
            //CAMBIO LA ETIQUETA
            NSString *StringAmarillo = [[NSString alloc]initWithString:@"Amarillo"];
            [etiquetaColor setText:StringAmarillo];
            [etiquetaColor setTextColor:[UIColor yellowColor]];
            [StringAmarillo release];
            break;
        }

    }
}

-(IBAction)borrar
{
    UIActionSheet *mensaje = [[UIActionSheet alloc] initWithTitle:@"¿Volver a empezar?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"NOOOOOOOO!" otherButtonTitles:@"Si, estoy seguro", nil];
    
    [mensaje showInView:[self view]];
    [mensaje setActionSheetStyle:UIActionSheetStyleAutomatic];
     
    [mensaje release];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    
    switch (buttonIndex) {
        case 1:
        {
            [image setBackgroundColor:[UIColor whiteColor]];
            UIImage *blanco = [[UIImage alloc] init];
            [image  setImage:blanco];
            [blanco release];
            break;
        }
        default:
            break;
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
