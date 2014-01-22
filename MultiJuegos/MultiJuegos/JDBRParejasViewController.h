//
//  JDBRParejasViewController.h
//  MultiJuegos
//
//  Created by Juan Diego Barrera Román on 01/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface JDBRParejasViewController : UIViewController
{
    IBOutlet UIImageView *visorImagen0;    
    IBOutlet UIImageView *visorImagen1;
    IBOutlet UIImageView *visorImagen2;
    IBOutlet UIImageView *visorImagen3;
    IBOutlet UIImageView *visorImagen4;
    IBOutlet UIImageView *visorImagen5;
    IBOutlet UIImageView *visorImagen6;
    IBOutlet UIImageView *visorImagen7;
    IBOutlet UIImageView *visorImagen8;
    IBOutlet UIImageView *visorImagen9;

    UIImage *imagenReversoCarta;
    UIImage *imagenEstrella;
    UIImage *imagenLuna;
    UIImage *imagenNube;
    UIImage *imagenParaguas;
    UIImage *imagenRayo;
    
    NSString *orientacionPantalla;

    //UTIL EN LA DINAMICA DE JUEGO
    NSArray *imagenes;
    int contadorFinJuego;
    NSMutableArray *arrayPosicionImagen;
    int indiceImagenSeleccionadaAnterior;
    int indiceImagenSeleccionadaActual;
    bool esPrimeraEleccion;
    bool esSegundaEleccion;
    
    UIImageView *VisorImagenSeleccionadaAnterior;
    
    
    //TIMER
    int timer;
    IBOutlet UILabel *labelTimer;
    NSTimer *temporizador;
    
    //PARA NO REPETIR MISMA PAREJA O PARA NO HACER PAREJA CON EL MISMO
    NSMutableArray *parejasConfirmadas;
    int numVisorSeleccionadoAnterior;
    
    //RELACIONADO CON SONIDO
    AVAudioPlayer *reproductorToque;
	AVAudioPlayer *reproductorAcierto;
    AVAudioPlayer *reproductorFallo;
    AVAudioPlayer *reproductorFinal;
}


-(void) prepararJuego;
-(void) sonParejasONO:(int)numVisor;
-(void) animacionCartas:(UIImageView *)visorImagenN  sobreImagen:(UIImage *) imagenSeleccionada indiceImage:(NSNumber *)indice numVisorSel:(int) numVisor;

-(IBAction)empezar;

@end
