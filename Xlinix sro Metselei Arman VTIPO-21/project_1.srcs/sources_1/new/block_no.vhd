----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2026 08:52:23 AM
-- Design Name: 
-- Module Name: block_no - Behavioral
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

entity block_no is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           Y : out STD_LOGIC);
end block_no;

architecture Structural of block_no is
component gate_not
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component gate_and
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component gate_or
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
signal w_or1_out : STD_LOGIC;
signal w_or2_out : STD_LOGIC;
begin
    U_OR1 : gate_or port map (A => A, B => B, Y => w_or1_out);
    U_OR2 : gate_or port map (A => w_or1_out, B => C, Y => w_or2_out);
    
    U_NOT : gate_not port map (A => w_or2_out, Y => Y);

end Structural;
