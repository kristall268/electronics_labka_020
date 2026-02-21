----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2026 08:52:23 AM
-- Design Name: 
-- Module Name: block_nex - Behavioral
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

entity block_nex is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end block_nex;

architecture structural of block_nex is

component gate_not
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component gate_and
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component gate_or
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
signal not_a_wire : STD_LOGIC;
signal not_b_wire : STD_LOGIC;
signal and1_wire  : STD_LOGIC;
signal and2_wire  : STD_LOGIC;

begin
    U_NOT1: gate_not port map (A => A, Y => not_a_wire);
    U_NOT2: gate_not port map (A => B, Y => not_b_wire);

    U_AND1: gate_and port map (A => A, B => B, Y => and1_wire);

    U_AND2: gate_and port map (A => not_a_wire, B => not_b_wire, Y => and2_wire);

    U_OR: gate_or port map (A => and1_wire, B => and2_wire, Y => Y);

end structural;
