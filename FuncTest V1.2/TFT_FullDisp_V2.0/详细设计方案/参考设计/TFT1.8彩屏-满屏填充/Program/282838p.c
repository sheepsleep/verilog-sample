
//     
/***************************************************/

#include<reg52.h>
#include<absacc.h>
#include<intrins.h>
#include<string.h>
#define uchar unsigned char
#define uint unsigned int


sbit LCD_RST       =	P0^3;
sbit LCD_RS        =	P0^4;
sbit LCD_SDA       =	P0^5;
sbit LCD_SCL       =	P0^6;
sbit LCD_CS        =	P0^7;




uchar bdata bitdata;
sbit bit7=bitdata^7;
sbit bit6=bitdata^6;
sbit bit5=bitdata^5;
sbit bit4=bitdata^4;
sbit bit3=bitdata^3;
sbit bit2=bitdata^2;
sbit bit1=bitdata^1;
sbit bit0=bitdata^0;



void delay(uint time)
{
 uint i,j;
  for(i=0;i<time;i++)
   for(j=0;j<250;j++);
}

/**********************************************************/
void delayms(uchar x)    //x*0.14MS
{
 uchar i;
  while(x--)
 {
  for (i = 0; i<10; i++) {}
 }
}

/**********************************************************/


void LCD_CtrlWrite_IC(uchar c)
{
bitdata=c;
LCD_CS=0;
LCD_RS=0;
LCD_SDA=bit7;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit6;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit5;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit4;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit3;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit2;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit1;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit0;LCD_SCL=0;LCD_SCL=1;
LCD_CS=1;


}
void  LCD_DataWrite_IC(uchar d)  
{

bitdata=d;
LCD_CS=0;
LCD_RS=1;
LCD_SDA=bit7;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit6;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit5;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit4;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit3;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit2;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit1;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit0;LCD_SCL=0;LCD_SCL=1;
LCD_CS=1;
}

void LCD_DataWrite(uint LCD_Data)
{
LCD_DataWrite_IC(LCD_Data>>8);
LCD_DataWrite_IC(LCD_Data);
}


void Write_COM(uchar c)
{
bitdata=c;
LCD_CS=0;
LCD_RS=0;
LCD_SDA=bit7;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit6;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit5;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit4;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit3;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit2;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit1;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit0;LCD_SCL=0;LCD_SCL=1;
LCD_CS=1;      
}

void Write_DATA(uchar d)
{
bitdata=d;
LCD_CS=0;
LCD_RS=1;
LCD_SDA=bit7;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit6;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit5;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit4;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit3;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit2;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit1;LCD_SCL=0;LCD_SCL=1;
LCD_SDA=bit0;LCD_SCL=0;LCD_SCL=1;
LCD_CS=1;
}


void reset()
{
	LCD_RST=1;
    delay(100);
    LCD_RST=0;
    delay(100);
    LCD_RST=1;
    delay(100);
}
//////////////////////////////////////////////////////////////////////////////////////////////

void lcd_initial()
{
  reset();
//--------------------------------End ST7735R LCD_RST Sequence --------------------------------------//
Write_COM(0x11); //Sleep out
delayms (120); //Delay 120ms
//------------------------------------ST7735R Frame Rate-----------------------------------------//
Write_COM(0xB1);
Write_DATA(0x01);  //01
Write_DATA(0x2C);
Write_DATA(0x2D);
Write_COM(0xB2);
Write_DATA(0x01);  //01
Write_DATA(0x2C);
Write_DATA(0x2D);
Write_COM(0xB3);
Write_DATA(0x01);   //01
Write_DATA(0x2C);
Write_DATA(0x2D);
Write_DATA(0x01);
Write_DATA(0x2C);
Write_DATA(0x2D);
//------------------------------------End ST7735R Frame Rate-----------------------------------------//
Write_COM(0xB4); //Column inveLCD_RSion
Write_DATA(0x03);  //0x07



Write_COM(0xB6);   //
Write_DATA(0xB4); //
Write_DATA(0xF0); //

//------------------------------------ST7735R Power Sequence-----------------------------------------//
Write_COM(0xC0);
Write_DATA(0xA2);
Write_DATA(0x02);
Write_DATA(0x84);
Write_COM(0xC1);
Write_DATA(0xC5);
Write_COM(0xC2);
Write_DATA(0x0A);
Write_DATA(0x00);
Write_COM(0xC3);
Write_DATA(0x8A);
Write_DATA(0x2A);
Write_COM(0xC4);
Write_DATA(0x8A);
Write_DATA(0xEE);
//---------------------------------End ST7735R Power Sequence-------------------------------------//


Write_COM(0xC5); //VCOM
Write_DATA(0x0A);   //0x0E

Write_COM(0x36); //MX, MY, RGB mode
Write_DATA(0xC8);   //0x68
//------------------------------------ST7735R Gamma Sequence-----------------------------------------//
Write_COM(0xe0);
Write_DATA(0x02);
Write_DATA(0x1c);
Write_DATA(0x07);
Write_DATA(0x12);
Write_DATA(0x37);
Write_DATA(0x32);
Write_DATA(0x29);
Write_DATA(0x2d);
Write_DATA(0x29);
Write_DATA(0x25);
Write_DATA(0x2b);
Write_DATA(0x39);
Write_DATA(0x00);
Write_DATA(0x01);
Write_DATA(0x03);
Write_DATA(0x10);

Write_COM(0xe1);
Write_DATA(0x03);
Write_DATA(0x1d);
Write_DATA(0x07);
Write_DATA(0x06);
Write_DATA(0x2e);
Write_DATA(0x2c);
Write_DATA(0x29);
Write_DATA(0x2d);
Write_DATA(0x2e);
Write_DATA(0x2e);
Write_DATA(0x37);
Write_DATA(0x3f);
Write_DATA(0x00);
Write_DATA(0x00);
Write_DATA(0x02);
Write_DATA(0x10);
//------------------------------------End ST7735R Gamma Sequence-----------------------------------------//

 Write_COM(0x2a);
 Write_DATA(0x00);
 Write_DATA(0x00);
 Write_DATA(0x00);
 Write_DATA(0x7f);
  
   Write_COM(0x2b);
   Write_DATA(0x00);
   Write_DATA(0x00);
   Write_DATA(0x00);
   Write_DATA(0x9f);






Write_COM(0xF0); //Enable test command
Write_DATA(0x01);
Write_COM(0xF6); //Disable ram power save mode
Write_DATA(0x00);

Write_COM(0x3A); //65k mode
Write_DATA(0x05);

Write_COM(0x29); //Display on


    delay(120);
}




void dsp_single_colour(uint DHL)
{
 uchar i,j;
 //RamAdressSet();
 for (i=0;i<160;i++)
    for (j=0;j<128;j++)
        LCD_DataWrite(DHL);
}



main()
{
 lcd_initial();

      while(1)
  {
 Write_COM(0x2C);
  //  Disp_gradscal(); //灰阶
   // delay(500); 
      

    dsp_single_colour(0xffff);//白色
    delay(500);	
    	
    dsp_single_colour(0x0000);//黑色
    delay(500);	
    	
    dsp_single_colour(0xf800);//红色
    delay(500);	
    	
    dsp_single_colour(0x07e0);//绿色
    delay(500);	
    	
    dsp_single_colour(0x001f);//蓝色
    delay(500);	

    }

 }



