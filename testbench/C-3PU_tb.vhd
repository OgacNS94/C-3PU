--
-- Copyright 2016 Ognjen Glamocanin
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY C_3PU_tb IS
END C_3PU_tb;
 
ARCHITECTURE behavior OF C_3PU_tb IS 
 
    COMPONENT C_3PU
    port(
        clk:    in  std_logic;
        reset:  in std_logic;

        --OUT SIGNALS FOR TESTBENCH

        pc_out:   out std_logic_vector(31 downto 0);
        ir_out:   out std_logic_vector(31 downto 0);        
        opcode:     out  std_logic_vector(4 downto 0);
        A1_in:    out std_logic_vector(3 downto 0);
        A2_in:    out std_logic_vector(3 downto 0);
        A3_in:    out std_logic_vector(3 downto 0);
        Di3_in:   out std_logic_vector(31 downto 0);
        exp_in_1: out std_logic_vector(18 downto 0);
        exp_in_2:   out std_logic_vector(26 downto 0);
        exp_out:  out std_logic_vector(31 downto 0);
        xreg0_out:  out std_logic_vector(31 downto 0);
        xreg1_out:  out std_logic_vector(31 downto 0);
        alu1_in:  out std_logic_vector(31 downto 0);
        alu0_in:  out std_logic_vector(31 downto 0);
        alu_out:  out std_logic_vector(31 downto 0);
        sr_in:    out std_logic_vector(1 downto 0);
        r_in:   out std_logic_vector(31 downto 0);
        Di_in:    out std_logic_vector(31 downto 0);
        Do_out:   out std_logic_vector(31 downto 0);
        status_register_out: out std_logic_vector (1 downto 0);
        control_signals: out std_logic_vector(21 downto 0)

      );
    END COMPONENT;
    

   --Inputs
   signal clk_s : std_logic;
   signal reset_s : std_logic;

   --Outputs
   signal pc_out_s:  std_logic_vector(31 downto 0);
   signal ir_out_s:  std_logic_vector(31 downto 0);
   signal opcode_s:  std_logic_vector(4 downto 0);
   signal A1_in_s:   std_logic_vector(3 downto 0);
   signal A2_in_s:   std_logic_vector(3 downto 0);
   signal A3_in_s:   std_logic_vector(3 downto 0);
   signal Di3_in_s:  std_logic_vector(31 downto 0);
   signal exp_in_1_s: std_logic_vector(18 downto 0);
   signal exp_in_2_s: std_logic_vector(26 downto 0);
   signal exp_out_s:  std_logic_vector(31 downto 0);
   signal xreg0_out_s: std_logic_vector(31 downto 0);
   signal xreg1_out_s: std_logic_vector(31 downto 0);
   signal alu1_in_s: std_logic_vector(31 downto 0);
   signal alu0_in_s:  std_logic_vector(31 downto 0);
   signal alu_out_s:  std_logic_vector(31 downto 0);
   signal sr_in_s:    std_logic_vector(1 downto 0);
   signal r_in_s:    std_logic_vector(31 downto 0);
   signal Di_in_s:  std_logic_vector(31 downto 0);
   signal Do_out_s: std_logic_vector(31 downto 0);
   signal status_register_out_s: std_logic_vector (1 downto 0);
   signal control_signals_s: std_logic_vector(21 downto 0);
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: C_3PU PORT MAP (
        clk => clk_s,
        reset => reset_s,
        pc_out => pc_out_s,
        ir_out => ir_out_s,        
        opcode => opcode_s,
        A1_in => A1_in_s,
        A2_in => A2_in_s,
        A3_in => A3_in_s,
        Di3_in => Di3_in_s,
        exp_in_1 => exp_in_1_s,
        exp_in_2 => exp_in_2_s,
        exp_out => exp_out_s,
        xreg0_out => xreg0_out_s,
        xreg1_out => xreg1_out_s,
        alu1_in => alu1_in_s,
        alu0_in => alu0_in_s,
        alu_out => alu_out_s,
        sr_in => sr_in_s,
        r_in => r_in_s,
        Di_in => Di_in_s,
        Do_out => Do_out_s,
        status_register_out => status_register_out_s,
        control_signals => control_signals_s
        ); 

   -- CLK PROCESS
   process is
   begin

      clk_s <= '0', '1' after 100 ns;
      wait for 200 ns;

   end process;

   -- Stimulus process
   stim_proc: process
   begin        
      
      reset_s <= '1', '0' after 300 ns;
        
      wait;
   end process;

END;