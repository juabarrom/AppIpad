//
//  JDBRDibujarViewController.h
//  MultiJuegos
//
//  Created by Juan Diego Barrera Román on 08/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface JDBRDibujarViewController : UIViewController <UIActionSheetDelegate>{
    float rojo;
    float verde;
    float azul;
    float pincel;
    
    CGPoint currentPoint;
    CGPoint previousPoint1;
    
    
    //SLIDER PARA CAMBIAR EL TAMAÑO DEL PINCEL
    IBOutlet UISlider *slider;
    IBOutlet UILabel *etiquetaSlider;
    
    IBOutlet UILabel *etiquetaColor;
    
}
@property (retain, nonatomic) IBOutlet UIImageView *image;

//ACCION QUE CONTROLA EL MOVIMIENTO DEL SLIDER
-(IBAction)sliderSeMueve:(id)sender;

//CONTROLA LOS BOTONES DE LOS COLORES
-(IBAction)cambioDeColor:(id)sender;

//BOTON BORRAR
-(IBAction)borrar;

@end
