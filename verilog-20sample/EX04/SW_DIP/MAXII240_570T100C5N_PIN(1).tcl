#Setup.tcl
#////////////////////////////////////////////////////////////////////////////////
#//  Company:                                                                  //
#//  Company bbs:                                                              //
#//  Engineer:      Youzhiyu                                                   //
#//                                                                            //
#//  Target Device: MAXII240T100C5N                                            //
#//  Tool versions: Quartus II 7.2                                             //
#//  Create Date:   2011-09-06 9:09                                            //
#//  Description:                                                              //
#//                                                                            //
#////////////////////////////////////////////////////////////////////////////////
#// 	   Copyright (C) 2011-2012  Youzhiyu   All rights reserved              //
#//----------------------------------------------------------------------------//
#////////////////////////////////////////////////////////////////////////////////
# Setup pin setting
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "As input tri-stated"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

# led Interface
set_location_assignment PIN_53  -to led[7]
set_location_assignment PIN_52  -to led[6]
set_location_assignment PIN_51  -to led[5]
set_location_assignment PIN_50  -to led[4]
set_location_assignment PIN_49  -to led[3]
set_location_assignment PIN_48  -to led[2]
set_location_assignment PIN_47  -to led[1]
set_location_assignment PIN_44  -to led[0]

# Button Interface
set_location_assignment PIN_84  -to BNT[1]
set_location_assignment PIN_85  -to BNT[0]

# Reset button Interface
set_location_assignment PIN_83  -to rst_n

# KEY Interface
set_location_assignment PIN_5  -to KEY_H[4]
set_location_assignment PIN_6  -to KEY_H[3]
set_location_assignment PIN_7  -to KEY_H[2]
set_location_assignment PIN_8  -to KEY_H[1]

set_location_assignment PIN_1  -to KEY_V[4]
set_location_assignment PIN_2  -to KEY_V[3]
set_location_assignment PIN_3  -to KEY_V[2]
set_location_assignment PIN_4  -to KEY_V[1]

# SW DIP-8 Interface
set_location_assignment PIN_82  -to SW[7]
set_location_assignment PIN_81  -to SW[6]
set_location_assignment PIN_78  -to SW[5]
set_location_assignment PIN_77  -to SW[4]
set_location_assignment PIN_76  -to SW[3]
set_location_assignment PIN_75  -to SW[2]
set_location_assignment PIN_74  -to SW[1]
set_location_assignment PIN_73  -to SW[0]

# clk Interface
set_location_assignment PIN_62 -to GCLK2
set_location_assignment PIN_64 -to GCLK3
set_location_assignment PIN_61 -to clk

# Buzzer Interface
set_location_assignment PIN_21 -to Buzzer

# 7-SEG Interface
set_location_assignment PIN_26  -to HC_SI
set_location_assignment PIN_27  -to HC_CP

# LCD Interface
set_location_assignment PIN_28  -to lcd_ret
set_location_assignment PIN_29  -to lcd_psb

set_location_assignment PIN_42   -to lcd_data[7]
set_location_assignment PIN_41   -to lcd_data[6]
set_location_assignment PIN_40   -to lcd_data[5]
set_location_assignment PIN_99   -to lcd_data[4]
set_location_assignment PIN_38   -to lcd_data[3]
set_location_assignment PIN_100  -to lcd_data[2]
set_location_assignment PIN_36   -to lcd_data[1]
set_location_assignment PIN_35   -to lcd_data[0]
set_location_assignment PIN_34  -to lcd_en
set_location_assignment PIN_33  -to lcd_rw
set_location_assignment PIN_30  -to lcd_rs

# UART Interface
set_location_assignment PIN_20  -to Uart2_R
set_location_assignment PIN_19  -to Uart2_T
set_location_assignment PIN_18  -to Uart1_T
set_location_assignment PIN_17  -to Uart1_R

# IrDA Interface
set_location_assignment PIN_16  -to IrDA_Tx
set_location_assignment PIN_15  -to IrDA_Rx

# RELAY-DPST Interface
set_location_assignment PIN_43  -to RELAY

# VGA Interface
set_location_assignment PIN_56  -to VGA_VSYNC
set_location_assignment PIN_57  -to VGA_HSYNC
set_location_assignment PIN_67  -to VGA_R
set_location_assignment PIN_66  -to VGA_G
set_location_assignment PIN_58  -to VGA_B

# AT24C02 Interface
set_location_assignment PIN_71  -to SCL
set_location_assignment PIN_72  -to SDA

# RTC Interface
set_location_assignment PIN_69  -to RTC_SCL
set_location_assignment PIN_70  -to RTC_SDA

# PS2 Interface
set_location_assignment PIN_55  -to PS2_DAT2
set_location_assignment PIN_54  -to PS2_CLK2

# DS18B20 Interface
set_location_assignment PIN_68  -to DS18B20_DAT

#JP2 Interface

set_location_assignment PIN_1  -to JP2[3]
set_location_assignment PIN_2  -to JP2[4]
set_location_assignment PIN_3  -to JP2[5]
set_location_assignment PIN_4  -to JP2[6]
set_location_assignment PIN_5  -to JP2[7]
set_location_assignment PIN_6  -to JP2[8]
set_location_assignment PIN_7  -to JP2[9]
set_location_assignment PIN_8  -to JP2[10]

set_location_assignment PIN_12  -to JP2[11]
set_location_assignment PIN_14  -to JP2[12]
set_location_assignment PIN_15  -to JP2[13]
set_location_assignment PIN_16  -to JP2[14]
set_location_assignment PIN_17  -to JP2[15]
set_location_assignment PIN_18  -to JP2[16]
set_location_assignment PIN_19  -to JP2[17]
set_location_assignment PIN_20  -to JP2[18]
set_location_assignment PIN_21  -to JP2[19]
set_location_assignment PIN_26  -to JP2[20]

set_location_assignment PIN_27  -to JP2[21]
set_location_assignment PIN_28  -to JP2[22]
set_location_assignment PIN_29  -to JP2[23]
set_location_assignment PIN_30  -to JP2[24]
set_location_assignment PIN_33  -to JP2[25]
set_location_assignment PIN_34  -to JP2[26]
set_location_assignment PIN_35  -to JP2[27]
set_location_assignment PIN_36  -to JP2[28]
set_location_assignment PIN_38  -to JP2[29]
set_location_assignment PIN_40  -to JP2[30]

set_location_assignment PIN_41   -to JP2[31]
set_location_assignment PIN_42   -to JP2[32]
set_location_assignment PIN_43   -to JP2[33]
set_location_assignment PIN_44   -to JP2[34]
set_location_assignment PIN_47   -to JP2[35]
set_location_assignment PIN_48   -to JP2[36]
set_location_assignment PIN_49   -to JP2[37]
set_location_assignment PIN_50   -to JP2[38]
set_location_assignment PIN_51   -to JP2[39]
set_location_assignment PIN_52   -to JP2[40]

#JP3 Interface
set_location_assignment PIN_53  -to JP3[1]
set_location_assignment PIN_54  -to JP3[2]
set_location_assignment PIN_55  -to JP3[3]
set_location_assignment PIN_56  -to JP3[4]
set_location_assignment PIN_57  -to JP3[5]
set_location_assignment PIN_58  -to JP3[6]
set_location_assignment PIN_61  -to JP3[7]
set_location_assignment PIN_62  -to JP3[8]
set_location_assignment PIN_66  -to JP3[9]
set_location_assignment PIN_64  -to JP3[10]

set_location_assignment PIN_67  -to JP3[11]
set_location_assignment PIN_68  -to JP3[12]
set_location_assignment PIN_69  -to JP3[13]
set_location_assignment PIN_70  -to JP3[14]
set_location_assignment PIN_71  -to JP3[15]
set_location_assignment PIN_72  -to JP3[16]
set_location_assignment PIN_73  -to JP3[17]
set_location_assignment PIN_74  -to JP3[18]
set_location_assignment PIN_75  -to JP3[19]
set_location_assignment PIN_76  -to JP3[20]

set_location_assignment PIN_78  -to JP3[21]
set_location_assignment PIN_77  -to JP3[22]
set_location_assignment PIN_81  -to JP3[23]
set_location_assignment PIN_82  -to JP3[24]
set_location_assignment PIN_83  -to JP3[25]
set_location_assignment PIN_84  -to JP3[26]
set_location_assignment PIN_85  -to JP3[27]
set_location_assignment PIN_86  -to JP3[28]
set_location_assignment PIN_87  -to JP3[29]
set_location_assignment PIN_89  -to JP3[30]

set_location_assignment PIN_91    -to JP3[31]
set_location_assignment PIN_92    -to JP3[32]
set_location_assignment PIN_95    -to JP3[33]
set_location_assignment PIN_96    -to JP3[34]
set_location_assignment PIN_97    -to JP3[35]
set_location_assignment PIN_98    -to JP3[36]
set_location_assignment PIN_99    -to JP3[37]
set_location_assignment PIN_100   -to JP3[38]

