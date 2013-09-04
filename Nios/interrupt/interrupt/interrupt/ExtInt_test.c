/********************************************************************
* 文 件 名：ExtInt_test.c
* 功    能：使用外部按键中断进行LED的控制，每当有一次按键中断时，即取反所有的LED，注意把无关紧要的事情放在中断服务程序外处理，不要调用C库函数（如Printf()，这时因为引起阻塞且运行的时间无法预知）。不要进行浮点操作。在调试时，由于无法预知中断发生时间，可以在中断服务程序中设置断点，然后单步调试。
*           
* 说    明：按下KEY观察相应的LED的状态，要去四个按键全部按下！！！
********************************************************************/
#include <stdio.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include "sys/alt_irq.h"
#include "priv/alt_busy_sleep.h"

#define   LEDCON   0xff          // 
#define   KEYCON   0xff          //

/******************************************************************
*      与硬件相关的宏定义，用户根据实际情况修改
******************************************************************/
// 用户添加并命名的外设基地址,在SYSTEM中定义,用户需要根据不同的命名来修改此处
#ifndef KEY_PIO_BASE             //这是KEY_PIO核的基地址
#define KEY_PIO_BASE 0xffffffff //user's definition here
#endif

#if KEY_PIO_BASE == 0xffffffff
#error "No definition of KEY_PIO core.\n"
#endif

#ifndef KEY_PIO_IRQ             //这是KEY_PIO核的中断号
#define KEY_PIO_IRQ 0xffff //user's definition here
#endif

#if KEY_PIO_IRQ == 0xffff
#error "No definition of KEY_PIO_IRQ.\n"
#endif

#ifndef LED_PIO_BASE             //这是LED_PIO核的基地址
#define LED_PIO_BASE 0xfffffffe //user's definition here
#endif

#if LED_PIO_BASE == 0xfffffffe
#error "No definition of LED_PIO core.\n"
#endif

volatile alt_u32 done = 0;                   // 信号量：通知外部中断事件发生

/********************************************************************
* 名    称：KeyDown_interrupts()
* 功    能：键按下事件中断服务子程序，当键按下时，通过done标志
*           告知外界
* 入口参数：context，一般用于传递中断状态寄存器的值，这里未使用 
*           id，中断号，这里未使用
* 出口参数：无
********************************************************************/
static void KeyDown_interrupts(void* context , alt_u32 id)
{ 
   /* 清中断捕获寄存器 */
   IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_PIO_BASE, 0);
   /* 通知外部有中断事件发生 */
   done++;
}
/********************************************************************
* 名    称：InitPIO()
* 功    能：初始化LED_PIO为输出，KEY为输入，开中断，清边沿捕获寄存器
* 入口参数：无
* 出口参数：无
********************************************************************/
void InitPIO(void)
{ 
/* 初始化LED_PIO为输出，KEY为输入 */
IOWR_ALTERA_AVALON_PIO_DIRECTION(LED_PIO_BASE, LEDCON);
IOWR_ALTERA_AVALON_PIO_DIRECTION(KEY_PIO_BASE, 0x00);
/* 开KEY的中断 */
IOWR_ALTERA_AVALON_PIO_IRQ_MASK(KEY_PIO_BASE, KEYCON);
/* 清边沿捕获寄存器 */ 
IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_PIO_BASE, 0x00);
/* 注册中断服务子程序 */
alt_irq_register(KEY_PIO_IRQ, NULL, KeyDown_interrupts); 
}

/********************************************************************
* 名    称：main()
* 功    能：等待按键中断，并输出控制相应的LED。
********************************************************************/
int main(void)
{      
    volatile alt_u32 key_state,old_state,new_state;
    old_state = 0x00;
    IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE, old_state);//初始化LED全灭
    InitPIO();
    while(1) 
    { 
       if(0 != done)
       {
          /* 中断事件数量减1 */
          done--;
          alt_busy_sleep(5000); //延时5ms
          key_state = IORD_ALTERA_AVALON_PIO_DATA(KEY_PIO_BASE)&KEYCON;
          if(key_state == 0xff)   //如果是由短暂脉冲引起的中断则忽略
             continue;
        
          new_state = ~(old_state ^ key_state); // 四个按键全部按下时LED取反
          old_state = new_state;                // 保存LED的状态
          IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE, new_state);
       }
    }
    return(0);
}


