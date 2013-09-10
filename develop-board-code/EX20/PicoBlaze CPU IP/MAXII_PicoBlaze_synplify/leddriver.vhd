--////////////////////////////////////////////////////////////////////////////////
--//  Company: 成都锐创智能科技 Ruichuang Smart Technology                      //
--//           http://ruicstech.taobao.com                                      // 
--//  Engineer:      Youzhiyu                                                   //
--//  QQ      :      4016682                                                    //
--//  Target Device: MAXII240T100C5N                                            //
--//  Tool versions: Quartus II 7.2                                             //
--//  Create Date:   2007-09-06 10:09                                           //
--//  Description:                                                              //
--//                                                                            //
--////////////////////////////////////////////////////////////////////////////////
--// 	   Copyright (C) 2011-2012  Youzhiyu   All rights reserved              //
--//----------------------------------------------------------------------------//
--////////////////////////////////////////////////////////////////////////////////
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;

entity leddriver is
	port( 
	      datain    : in std_logic_vector(7 downto 0);
		  reset_n   : in std_logic;
		  clkin     : in std_logic;
		  en        : in std_logic;
		  led       : out std_logic_vector(7 downto 0)
		);
end leddriver;

Architecture fun of leddriver is
Begin
  led_driver:Process(clkin,reset_n,en)
	Begin
		if reset_n='0' then
			led<=(others=>'1');
		elsif clkin'event and clkin='1' then
			if en='1' then
				led<= datain;
			end if;
		end if;
	end process led_driver;
end fun; 