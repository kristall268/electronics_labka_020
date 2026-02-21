----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2026 08:31:42 AM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
    Port ( x1 : in STD_LOGIC;
           x2 : in STD_LOGIC;
           x4 : in STD_LOGIC;
           x3 : in STD_LOGIC;
           y1 : out STD_LOGIC;
           y2 : out STD_LOGIC;
           y3 : out STD_LOGIC;
           y4 : out STD_LOGIC;
           y5 : out STD_LOGIC);
end main;

architecture Structural of main is

component gate_not
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component block_nex
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component block_noa
        Port (A, B, C : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component block_nmx
        Port (A, B, V : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component block_nao
        Port (A, B, C, D : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component block_naoa
            Port ( A, B, C, D : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component block_noaE
        Port ( A, B, C, D : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component block_no
        Port ( A, B, C : in STD_LOGIC; Y : out STD_LOGIC);
    end component;
component block_gnd
        Port ( Y : out STD_LOGIC);
    end component;

-- ===================== Column 1 signals =====================
    signal w_fc_not_fr   : STD_LOGIC;  -- NOT(x2)
    signal w_fc_nex_sr   : STD_LOGIC;  -- NXOR(x4, x3)
    signal w_fc_not_tr   : STD_LOGIC;  -- NOT(x3)
-- ===================== Column 2 signals =====================
    signal w_sc_noa2_fr  : STD_LOGIC;  -- NOA(x1, x2, x3)
    signal w_sc_nmx2_sr  : STD_LOGIC;  -- NMX(x4, not_x3, x2)
    signal w_sc_no3_tr   : STD_LOGIC;  -- NO3(nex, x1, not_x2)
-- ===================== Column 3 signals =====================
    signal w_tc_naoa2_fr : STD_LOGIC;  -- NAOA(x4, noa2_top, x1, x3)  -> NAO3 top
    signal w_tc_noa2_sc  : STD_LOGIC;  -- NOA(no3, x1, nmx)           -> NAO3 bot
    signal w_tc_naoa2_tr : STD_LOGIC;  -- NAOA(not_x2, noaE, not_x3, feedback) -> NOT -> y2
-- ===================== Column 4 signals =====================
    signal w_foc_noaE_fr : STD_LOGIC;  -- NOAE(not_x3, x4, not_x2, x1) -> y4
-- ===================== Feedback signals =====================
    signal w_y2_internal : STD_LOGIC;  -- NOT(naoa2_bot) = y2
    signal w_sc_not_for  : STD_LOGIC;  -- NOT(y2) = feedback into naoa2_bot

begin

 -- ########################################################## Column 1 ##############################################################
    FC_NOT_FR : gate_not port map (
        A => x2,
        Y => w_fc_not_fr
    );
    FC_NEX_SR : block_nex port map (
        A => x4,
        B => x3,
        Y => w_fc_nex_sr
    );
    FC_NOT_TR : gate_not port map (
        A => x3,
        Y => w_fc_not_tr
    );

 -- ########################################################## Column 2 ##############################################################
    SC_NOA2_FR : block_noa port map (
        A => x1,
        B => x2,
        C => x3,
        Y => w_sc_noa2_fr
    );
    SC_NMX2_SR : block_nmx port map (
        A => x4,
        B => w_fc_not_tr,
        V => x2,
        Y => w_sc_nmx2_sr
    );
    SC_NO3_TR : block_no port map (
        A => w_fc_nex_sr,
        B => x1,
        C => w_fc_not_fr,
        Y => w_sc_no3_tr
    );

 -- ########################################################## Column 3 ##############################################################
    TC_NAOA2_FR : block_naoa port map (
        A => x4,
        B => w_sc_noa2_fr,
        C => x1,
        D => x3,
        Y => w_tc_naoa2_fr
    );
    TC_NOA2_SR : block_noa port map (
        A => w_sc_no3_tr,
        B => x1,
        C => w_sc_nmx2_sr,
        Y => w_tc_noa2_sc
    );
    TC_NAOA2_TR : block_naoa port map (
        A => w_fc_not_fr,
        B => w_foc_noaE_fr,
        C => w_fc_not_tr,
        D => w_sc_not_for,
        Y => w_tc_naoa2_tr
    );

 -- ########################################################## Column 4 ##############################################################
    FC_NAO3_FR : block_nao port map (
        A => w_tc_naoa2_tr,
        B => x4,
        C => x3,
        D => x1,
        Y => y1
    );
    FC_NOT_SR : gate_not port map (
        A => w_tc_naoa2_fr,
        Y => w_y2_internal
    );
    y2 <= w_y2_internal;

    SC_NOT_FR : gate_not port map (
        A => w_y2_internal,
        Y => w_sc_not_for
    );
    FC_NAO3_TR : block_nao port map (
        A => w_tc_noa2_sc,
        B => x2,
        C => x4,
        D => x1,
        Y => y5
    );
    FC_NOAE_FOR : block_noaE port map (
        A => w_fc_not_tr,
        B => x4,
        C => w_fc_not_fr,
        D => x1,
        Y => w_foc_noaE_fr
    );
    y4 <= w_foc_noaE_fr;

    FC_GND_FIR : block_gnd port map (
        Y => y3
    );

end Structural;