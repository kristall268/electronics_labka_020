----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2026 08:52:23 AM
-- Design Name: 
-- Module Name: block_nmx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity block_nmx is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           V : in STD_LOGIC;
           Y : out STD_LOGIC);
end block_nmx;

architecture Structural of block_nmx is

component gate_not
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component gate_and
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component gate_or
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
signal w_not_v : STD_LOGIC;
signal w_and_a : STD_LOGIC;
signal w_and_b : STD_LOGIC;
signal w_or : STD_LOGIC;
begin
    U_NOT_V : gate_not port map (A => V, Y => w_not_v);
    U_AND_A : gate_and port map (A => A, B => w_not_v, Y => w_and_a);
    U_AND_B : gate_and port map (A => B, B => V, Y => w_and_b);
    U_OR : gate_or port map (A => w_and_a, B => w_and_b, Y => w_or);
    U_NOT_OR : gate_not port map (A => w_or, Y => Y);
    
end Structural;