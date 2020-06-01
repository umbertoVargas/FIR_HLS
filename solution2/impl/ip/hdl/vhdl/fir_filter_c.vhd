-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity fir_filter_c_rom is 
    generic(
             DWIDTH     : integer := 16; 
             AWIDTH     : integer := 6; 
             MEM_SIZE    : integer := 59
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of fir_filter_c_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 => "1111111010000110", 1 => "1111111110110111", 2 => "0000000000011011", 
    3 => "0000000010101010", 4 => "0000000100101010", 5 => "0000000101100000", 
    6 => "0000000100101110", 7 => "0000000010101000", 8 => "0000000000001110", 
    9 => "1111111110110000", 10 => "1111111111000000", 11 => "0000000000110101", 
    12 => "0000000010111010", 13 => "0000000011011000", 14 => "0000000000101000", 
    15 => "1111111010011100", 16 => "1111110010011101", 17 => "1111101011111101", 
    18 => "1111101010101010", 19 => "1111110001000110", 20 => "1111111111001101", 
    21 => "0000010001101100", 22 => "0000100010110011", 23 => "0000101100001101", 
    24 => "0000101001010111", 25 => "0000011001100001", 26 => "0000000000011001", 
    27 => "1111100101010000", 28 => "1111010000011110", 29 => "0111001000101101", 
    30 => "1111010000011110", 31 => "1111100101010000", 32 => "0000000000011001", 
    33 => "0000011001100001", 34 => "0000101001010111", 35 => "0000101100001101", 
    36 => "0000100010110011", 37 => "0000010001101100", 38 => "1111111111001101", 
    39 => "1111110001000110", 40 => "1111101010101010", 41 => "1111101011111101", 
    42 => "1111110010011101", 43 => "1111111010011100", 44 => "0000000000101000", 
    45 => "0000000011011000", 46 => "0000000010111010", 47 => "0000000000110101", 
    48 => "1111111111000000", 49 => "1111111110110000", 50 => "0000000000001110", 
    51 => "0000000010101000", 52 => "0000000100101110", 53 => "0000000101100000", 
    54 => "0000000100101010", 55 => "0000000010101010", 56 => "0000000000011011", 
    57 => "1111111110110111", 58 => "1111111010000110" );

attribute syn_rom_style : string;
attribute syn_rom_style of mem : signal is "select_rom";
attribute ROM_STYLE : string;
attribute ROM_STYLE of mem : signal is "distributed";

begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity fir_filter_c is
    generic (
        DataWidth : INTEGER := 16;
        AddressRange : INTEGER := 59;
        AddressWidth : INTEGER := 6);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of fir_filter_c is
    component fir_filter_c_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    fir_filter_c_rom_U :  component fir_filter_c_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


