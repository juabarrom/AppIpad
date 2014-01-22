//
//  JDBRParejasViewController.m
//  MultiJuegos
//
//  Created by Juan Diego Barrera Román on 01/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JDBRParejasViewController.h"
#include <stdlib.h>

@interface JDBRParejasViewController ()

@end

@implementation JDBRParejasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSString *tituloTabBar = @"PAREJAS";
        self.title = tituloTabBar;
        
        //self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //CARGA IMAGEN DORSO DE LA CARTA
    NSString *pathReversoCarta = [[NSBundle mainBundle] pathForResource:@"reverso_carta.png" ofType:nil];
    imagenReversoCarta = [[UIImage alloc] initWithContentsOfFile:pathReversoCarta];
    
    //CARGA IMAGENES
    NSString *pathEstrella = [[NSBundle mainBundle] pathForResource:@"estrella.png" ofType:nil];
    imagenEstrella = [[UIImage alloc] initWithContentsOfFile:pathEstrella];
    
    NSString *pathLuna = [[NSBundle mainBundle] pathForResource:@"luna.png" ofType:nil];
    imagenLuna = [[UIImage alloc] initWithContentsOfFile:pathLuna];
    
    NSString *pathNube = [[NSBundle mainBundle] pathForResource:@"nube.png" ofType:nil];
    imagenNube = [[UIImage alloc] initWithContentsOfFile:pathNube];
    
    NSString *pathParaguas = [[NSBundle mainBundle] pathForResource:@"paraguas.png" ofType:nil];
    imagenParaguas = [[UIImage alloc] initWithContentsOfFile:pathParaguas];
    
    NSString *pathRayo = [[NSBundle mainBundle] pathForResource:@"rayo.png" ofType:nil];
    imagenRayo= [[UIImage alloc] initWithContentsOfFile:pathRayo];
    
    
    //CARGAR SONIDOS
    NSString *stringSonidoToque = [[NSBundle mainBundle]pathForResource:@"toque1.wav" ofType:nil];
	NSString *stringSonidoAcierto = [[NSBundle mainBundle]pathForResource:@"acierto.wav" ofType:nil];	
	NSString *stringSonidoFallo = [[NSBundle mainBundle]pathForResource:@"fallo.wav" ofType:nil];
	NSString *stringSonidoFinal = [[NSBundle mainBundle]pathForResource:@"final.mp3" ofType:nil];
	
	NSURL *urlSonidoToque = [NSURL fileURLWithPath: stringSonidoToque];
	NSURL *urlSonidoAcierto = [NSURL fileURLWithPath: stringSonidoAcierto];
    NSURL *urlSonidoFallo = [NSURL fileURLWithPath: stringSonidoFallo];
    NSURL *urlSonidoFinal = [NSURL fileURLWithPath:stringSonidoFinal];
	
    reproductorToque = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSonidoToque error:nil];
	reproductorAcierto = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSonidoAcierto error:nil];
	reproductorFallo = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSonidoFallo error:nil];    
    reproductorFinal = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSonidoFinal error:nil];
    
    //CARGAR CON IMAGENES EL NSARRAY IMAGENES
    imagenes = [[NSArray alloc] initWithObjects:imagenEstrella , imagenLuna , imagenNube , imagenParaguas , imagenRayo, nil];
    
    [imagenEstrella release];
    [imagenLuna release];
    [imagenNube release];
    [imagenParaguas release];
    [imagenRayo release];
    
    //RESERVA MEMORIA ARRAYPOSICION DE IMAGEN QUE MAS TARDE INICIALIZAREMOS CON VALORES
    arrayPosicionImagen =[[NSMutableArray alloc]init];
    
    //RESERVA DE MEMORIA DEL ARRAY PAREJAS CONFIRMADAS
    parejasConfirmadas =[[NSMutableArray alloc]initWithCapacity:4];
    
    [self prepararJuego];
    
    }


-(void) prepararJuego
{
    //CARGAR LOS VISORES CON LA IMAGEN DEL REVERSO DE LA CARTA
    [visorImagen0 setImage:imagenReversoCarta];
    [visorImagen1 setImage:imagenReversoCarta];
    [visorImagen2 setImage:imagenReversoCarta];
    [visorImagen3 setImage:imagenReversoCarta];
    [visorImagen4 setImage:imagenReversoCarta];
    [visorImagen5 setImage:imagenReversoCarta];
    [visorImagen6 setImage:imagenReversoCarta];
    [visorImagen7 setImage:imagenReversoCarta];
    [visorImagen8 setImage:imagenReversoCarta];
    [visorImagen9 setImage:imagenReversoCarta];
    
    //BORRO EL CONTENIDO DEL ARRAY DONDE SE ENCUENTRAN LOS "PUNTEROS" A LAS IMAGENES
    [arrayPosicionImagen removeAllObjects];
    [parejasConfirmadas removeAllObjects];

    //CARGO UN ARRAY DE TAMAÑO 9 CON ENTEROS DE [0-4] PARA INTERACTUAR CON EL ARRAY IMAGENES
    //DEBE REPETIR LOS VALORES DEL RANGO 2 VECES PARA ESO UTILIZO EL DICCIONARIO
    //EJMPLO-->[0,0,1,1,2,2,3,3,4,4,5,5]
    NSMutableArray *numAleatorios = [[NSMutableArray alloc] init];
    NSMutableDictionary *cantValorSel = [[NSMutableDictionary alloc] init];
    
	for (int i=0; i<10; i++) {
        //MIENTRAS NO ENCUENTRES UN VALOR ADECUADO PARA INSERTARLO EN EL ARRAY
        bool encontrado =YES;
        while (encontrado) {
            //GENERAR UN VALOR [0-4]
            int nR = arc4random() % 5;
            NSNumber *numRandom=[[NSNumber alloc] initWithInt:nR];
            
			//VARIABLES CLAVE, VALOR ARRAY ,INDICE DEL ARRAY
			NSString *clave = [[NSString alloc] initWithFormat:@"%d",nR];
			NSNumber *valorArray = [[NSNumber alloc] initWithInt:nR]; 
            
			int indiceArray = i;
            
			//SI EXISTE LA CLAVE y VALOR IGUAL A 0
            if ([cantValorSel objectForKey:clave]!=nil){
                if([cantValorSel objectForKey:clave]==[NSNumber numberWithInt:0]){
                    
					//MODIFICAR VALOR DE LA KEY PARA QUE NO ENTRE AQUI DE NUEVO, BASTA CON PONER UN VALOR MAYOR QUE 0
                    NSNumber *valorDiez = [[NSNumber alloc] initWithInt:10];
                    [cantValorSel setValue:valorDiez forKey:clave];
                    [valorDiez release];
                    
					//AÑADO EL VALOR A LA LISTA CON EL INDICE DEL FOR VALOR VALOR ALEATORIO
					[numAleatorios insertObject: valorArray atIndex:indiceArray];

                    encontrado=NO;
                }
				//SI NO EXISTE
            }else if ([cantValorSel objectForKey:numRandom]==nil){
				//AÑADO EL VALOR AL MAPA CLAVE->NUMERO RANDOM VALOR->0
                [cantValorSel setObject:[NSNumber numberWithInt:0] forKey:clave];
				//AÑADO EL VALOR A LA LISTA CON EL INDICE DEL FOR VALOR VALOR ALEATORIO
                [numAleatorios insertObject: valorArray atIndex:indiceArray];
                
                encontrado=NO;
            }
            
			[clave release];
			[valorArray release];
            [numRandom release];
        }
        
    }

    [cantValorSel release];
    
    //CARGADO EL ARRAY POSICION IMAGEN CON NUMEROS DE 0 A 4 REPETIDOS 2 VECES CADA UNO DE ELLOS
    [arrayPosicionImagen addObjectsFromArray:numAleatorios];
    [numAleatorios release];
    /*
    for (int i=0; i<[arrayPosicionImagen count]; i++) {
        NSNumber *n = [[NSNumber alloc]init];
        n=[arrayPosicionImagen objectAtIndex:i];
        NSLog(@"Pos %d valor %d",i,[n intValue]);
    }
    */
    
    //VALORES POR DEFECTO DE LOS BOOL
    esPrimeraEleccion = YES;
    esSegundaEleccion = NO;
    
    //VALOR POR DEFECTO DEL CONTADOR FIN DE JUEGO
    contadorFinJuego =0;
    
    //VALOR POR DEFECTO DEL TIMER
    
    //RESUELVE EL FALLO DEL TIMER AL DARLE AL BOTON EMPEZAR
    //DABA UN TIMER POCO EXACTO
    if (temporizador) {
        [temporizador invalidate];
    }
    
    timer=0;
    temporizador = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
    //PONER LAS PAREJAS A CERO
	for (int i =0; i<5; i++) {
		NSNumber *n=[[NSNumber alloc] initWithInt:0];
        [parejasConfirmadas addObject:n];
        [n release];
    }
        
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *toque = [touches anyObject];
    CGPoint puntero = [toque locationInView:nil];
    int puntoX = puntero.x;
    int puntoY = puntero.y;
    
    if ([orientacionPantalla isEqualToString:@"LANDSCAPERIGHT"]) {
        if(720>puntoX && puntoX>550 && 10<puntoY &&puntoY<135){
            [self sonParejasONO:0];
        }
        
        if(720>puntoX && puntoX>550 && 260<puntoY &&puntoY<480){
            [self sonParejasONO:1];
        }

        if(720>puntoX && puntoX>550 && 650<puntoY &&puntoY<745){
            [self sonParejasONO:2];
        }
        
        if(720>puntoX && puntoX>550 && 870<puntoY &&puntoY<990){
            [self sonParejasONO:3];
        }
        
        if(475>puntoX && puntoX>320 && 150<puntoY &&puntoY<270){
            [self sonParejasONO:4];
            
        }
        
        if(475>puntoX && puntoX>320 && 750<puntoY &&puntoY<875){
            [self sonParejasONO:5];
            
        }
        
        if(235>puntoX && puntoX>65 && 10<puntoY &&puntoY<135){
            [self sonParejasONO:6];
            
        }
        
        if(235>puntoX && puntoX>65 && 260<puntoY &&puntoY<480){
            [self sonParejasONO:7];
        }
        
        if(235>puntoX && puntoX>65 && 650<puntoY &&puntoY<745){
            [self sonParejasONO:8];
        }
        
        if(235>puntoX && puntoX>65 && 870<puntoY &&puntoY<990){
            [self sonParejasONO:9];
        }
    }
    
    if ([orientacionPantalla isEqualToString:@"LANDSCAPELEFT"]) {
        if(200>puntoX && puntoX>50 && 880<puntoY &&puntoY<1000){
            [self sonParejasONO:0];
        }
        
        if(200>puntoX && puntoX>50 && 625<puntoY &&puntoY<740){
            [self sonParejasONO:1];
        }
        
        if(200>puntoX && puntoX>50 && 280<puntoY &&puntoY<400){
            [self sonParejasONO:2];
        }
        
        if(200>puntoX && puntoX>50 && 25<puntoY &&puntoY<140){
            [self sonParejasONO:3];
        }
        
        if(445>puntoX && puntoX>295 && 775<puntoY &&puntoY<870){
            [self sonParejasONO:4];

        }
        
        if(445>puntoX && puntoX>295 && 150<puntoY &&puntoY<270){
            [self sonParejasONO:5];

        }
        
        if(700>puntoX && puntoX>540 && 880<puntoY &&puntoY<1000){
            [self sonParejasONO:6];
        }
        
        if(700>puntoX && puntoX>540 && 625<puntoY &&puntoY<740){
            [self sonParejasONO:7];
        }
        
        if(700>puntoX && puntoX>540 && 280<puntoY &&puntoY<400){
            [self sonParejasONO:8];
        }
        
        if(700>puntoX && puntoX>540 && 25<puntoY &&puntoY<140){
            [self sonParejasONO:9];
        }

        
    
    }
    
} 

-(void) sonParejasONO:(int)numVisor
{
    //ESTE INDICE SE REFIERE AL VALOR DEL ARRAY POS IMAGENES[0|0|1|1|2|2|3|3|4|4] QUE REPRESENTA A UNA DE LAS IMAGENES
    NSNumber *indice = [[NSNumber alloc]init];
    indice =[arrayPosicionImagen objectAtIndex:numVisor];
    
    //IMAGEN UTILIZANDO EL VALOR DEL INDICE Y EL ARRAY IMAGENES
    UIImage *imagenSel = [[UIImage alloc] init];
    imagenSel = [imagenes objectAtIndex:[indice intValue]];
    
    switch (numVisor) {
        case 0:{
            [self animacionCartas:visorImagen0 sobreImagen:imagenSel indiceImage:indice numVisorSel:0];
            break;
        }
        case 1:{
            [self animacionCartas:visorImagen1 sobreImagen:imagenSel indiceImage:indice numVisorSel:1];
            break;
        }
        case 2:{
            [self animacionCartas:visorImagen2 sobreImagen:imagenSel indiceImage:indice numVisorSel:2];
            break;
        }
        case 3:{
            [self animacionCartas:visorImagen3 sobreImagen:imagenSel indiceImage:indice numVisorSel:3];
            break;
        }
        case 4:{
            [self animacionCartas:visorImagen4 sobreImagen:imagenSel indiceImage:indice numVisorSel:4];
            break;
        }
        case 5:{
            [self animacionCartas:visorImagen5 sobreImagen:imagenSel indiceImage:indice numVisorSel:5];
            break;
        }
        case 6:{
            [self animacionCartas:visorImagen6 sobreImagen:imagenSel indiceImage:indice numVisorSel:6];
            break;
        }
        case 7:{
            [self animacionCartas:visorImagen7 sobreImagen:imagenSel indiceImage:indice numVisorSel:7];
            break;
        }
        case 8:{
            [self animacionCartas:visorImagen8 sobreImagen:imagenSel indiceImage:indice numVisorSel:8];
            break;
        }
        case 9:{
            [self animacionCartas:visorImagen9 sobreImagen:imagenSel indiceImage:indice numVisorSel:9];
            break;
        }
    }

}


-(void) animacionCartas:(UIImageView *)visorImagenN  sobreImagen:(UIImage *) imagenSeleccionada indiceImage:(NSNumber *)indice numVisorSel:(int) numVisor
{
    if(esPrimeraEleccion){
        //INDICE IMAGEN SELECCIONADO SOBRE EL ARRAY IMAGENES
        indiceImagenSeleccionadaAnterior = [indice intValue];
        
        //INDICE DEL VISOR ELEGIDO POR PRIMERA VEZ
        numVisorSeleccionadoAnterior=numVisor;
        
        esPrimeraEleccion = NO;
        esSegundaEleccion = YES;
        
        VisorImagenSeleccionadaAnterior =[[UIImageView alloc] init];
        VisorImagenSeleccionadaAnterior = visorImagenN;
        
        //BLOQUE ANIMACION
        [UIView beginAnimations:@"AnimacionImagen" context:nil];
        [visorImagenN setImage:imagenSeleccionada];
        //[UIView setAnimationDelay:3];
        //[visorImagenN setAlpha:1.0f];
        [UIView commitAnimations];
        
        //SONIDO
        [reproductorToque play];
        
    }else if(esSegundaEleccion){
        
        indiceImagenSeleccionadaActual=[indice intValue];
        //EVITAMOS QUE AL PULSAR DOS VECES SOBRE LA MISMA IMAGEN CUENTE COMO PAREJA
        //Y COLOCAMOS LOS BOOL PARA QUE SEA LA SEGUNDA ELECCION
        if (numVisorSeleccionadoAnterior == numVisor) {
            esPrimeraEleccion = NO;
            esSegundaEleccion = YES;            
            //SONIDO
            [reproductorToque play];
            
        //SI LAS CARTAS SON IGUALES Y NO SE REPITEN LAS PAREJAS YA ACERTADAS
        }else if(indiceImagenSeleccionadaAnterior == indiceImagenSeleccionadaActual && [[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaAnterior] intValue]==0){
            

            NSNumber *n=[[NSNumber alloc] initWithInt:1];
            [parejasConfirmadas replaceObjectAtIndex:indiceImagenSeleccionadaAnterior withObject:n];
            [n release];

            
            esPrimeraEleccion = YES;
            esSegundaEleccion = NO;
            
            //BLOQUE ANIMACION
            [UIView beginAnimations:@"AnimacionImagen" context:nil];
            [visorImagenN setImage:imagenSeleccionada];
            [UIView commitAnimations];
            
            //SONIDO
            [reproductorAcierto play];
            
            contadorFinJuego++;
            NSLog(@"%d",contadorFinJuego);
            
            //FIN DE JUEGO Y LANZO ALERTAS
            if (contadorFinJuego==5) {

                //SONIDO
                [reproductorFinal play];
                NSString *mensaje = [[NSString alloc] initWithFormat:@"LO LOGRASTE CON UN TIEMPO DE %@",[labelTimer text]];
                UIAlertView *alertaFinJuego = [[UIAlertView alloc] initWithTitle:@"FINAL DEL JUEGO" 
                                                                         message:mensaje
                                                                    delegate:self 
                                                               cancelButtonTitle:@"SUPERATE!" 
                                                               otherButtonTitles: nil];
                [alertaFinJuego show];
                [mensaje release];
                [alertaFinJuego release];
                
            }
        //SI LAS PAREJAS YA HAN SIDO ELEGIDAS Y CONFIRMADAS
        //EVITAMOS QUE UNA IMAGEN DE UNA PAREJA SELECCIONADA ENTRE EL JUEGO PUDIENDOSE TAPAR COMO SI NO ESTUVIERA ELEGIDA
        }else if([[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaAnterior] intValue]==1 || [[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaActual] intValue]==1){
            
            [reproductorToque play];

            if ([[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaActual] intValue]==0 && [[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaAnterior] intValue]==1){
                esPrimeraEleccion = NO;
                esSegundaEleccion = YES;
                
                //INDICE IMAGEN SELECCIONADO SOBRE EL ARRAY IMAGENES
                indiceImagenSeleccionadaAnterior = [indice intValue];
                
                //INDICE DEL VISOR ELEGIDO POR PRIMERA VEZ
                numVisorSeleccionadoAnterior=numVisor;
                
                VisorImagenSeleccionadaAnterior =[[UIImageView alloc] init];
                VisorImagenSeleccionadaAnterior = visorImagenN;
                
                //BLOQUE ANIMACION
                [UIView beginAnimations:@"AnimacionImagen" context:nil];
                [visorImagenN setImage:imagenSeleccionada];
                [UIView commitAnimations];
                
                
            }
            
            if ([[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaActual] intValue]==1 && [[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaAnterior] intValue]==0){
                esPrimeraEleccion = NO;
                esSegundaEleccion = YES;
            }
            
            if ([[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaActual] intValue]==1 && [[parejasConfirmadas objectAtIndex:indiceImagenSeleccionadaAnterior] intValue]==1){
                esPrimeraEleccion = YES;
                esSegundaEleccion = NO;
            }
            
        //SI LAS CARTAS SON DIFERENTES
        }else {
            esPrimeraEleccion = YES;
            esSegundaEleccion = NO;
            
            //SONIDO
            [reproductorFallo play];
            
            //BLOQUE ANIMACION
            [UIView beginAnimations:@"AnimacionImagen" context:nil];
            [visorImagenN setImage:imagenSeleccionada];
            
            
            [visorImagenN setImage:imagenReversoCarta];
            [VisorImagenSeleccionadaAnterior setImage:imagenReversoCarta];
            [UIView commitAnimations];
            
        }
    }


}

//DELEGADO DEL UIALERTVIEW
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self prepararJuego];
    [UIView beginAnimations:@"AnimacionImagen" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[self view] cache:YES ];
    [UIView commitAnimations];

}


//SELECTOR DEL TIMER
//LO UTILIZO PARA EL MARCADOR DE TIEMPO
-(void) timer
{
	timer++;
	
	int minutero = timer / 60;
	int secundero = timer % 60;
	
	//TE MOSTRARA COMO MINIMO DOS CIFRAS EMPEZANDO POR 2 CEROS %02d
	NSString *cadena = [[NSString alloc] initWithFormat:@"%02d:%02d",minutero,secundero];
	[labelTimer setText:cadena];
    
	[cadena release];
    
    
	
}


-(IBAction)empezar
{
    [self prepararJuego];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    //CAPANDO EL USO PORTRAIT DE LA APP
    if(	interfaceOrientation==UIInterfaceOrientationPortrait || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown){
        	return NO;
    }else {
        //COMPROBANDO LA ORIENTACION DE LA PANTALLA
        if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
            orientacionPantalla = @"LANDSCAPERIGHT";
        }else {
            orientacionPantalla = @"LANDSCAPELEFT";
        }
        return YES;
    }
    
    
}

@end
