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
use ieee.std_logic_1164.ALL;

entity C_3PU is
  port(
        clk:    in  std_logic;
        reset:	in std_logic;

        --OUT SIGNALS FOR TESTBENCH

        pc_out:		out std_logic_vector(31 downto 0);
        ir_out:		out std_logic_vector(31 downto 0);        
        opcode:     out  std_logic_vector(4 downto 0);
        A1_in:		out std_logic_vector(3 downto 0);
        A2_in:		out std_logic_vector(3 downto 0);
        A3_in:		out std_logic_vector(3 downto 0);
        Di3_in:		out std_logic_vector(31 downto 0);
        exp_in_1:	out std_logic_vector(18 downto 0);
        exp_in_2:  	out std_logic_vector(26 downto 0);
        exp_out:	out std_logic_vector(31 downto 0);
        xreg0_out:	out std_logic_vector(31 downto 0);
        xreg1_out: 	out std_logic_vector(31 downto 0);
        alu1_in:	out std_logic_vector(31 downto 0);
        alu0_in:	out std_logic_vector(31 downto 0);
        alu_out:	out std_logic_vector(31 downto 0);
        sr_in:		out std_logic_vector(1 downto 0);
        r_in:		out std_logic_vector(31 downto 0);
        Di_in:		out std_logic_vector(31 downto 0);
        Do_out:		out std_logic_vector(31 downto 0);
        status_register_out: out std_logic_vector (1 downto 0);
        control_signals: out std_logic_vector(21 downto 0)

      );
end C_3PU;

architecture structural of C_3PU is
 
    COMPONENT DATAPATH
    PORT(
        clk:                    in  std_logic;
        reset:                  in  std_logic;
        control_signals_in:     in  std_logic_vector (21 downto 0);
        opcode:                 out std_logic_vector (4 downto 0);        
        status_register_out:    out std_logic_vector (1 downto 0);

        --OUT SIGNALS FOR TESTBENCH

        pc_out:		out std_logic_vector(31 downto 0);
        ir_out:		out std_logic_vector(31 downto 0);
        A1_in:		out std_logic_vector(3 downto 0);
        A2_in:		out std_logic_vector(3 downto 0);
        A3_in:		out std_logic_vector(3 downto 0);
        Di3_in:		out std_logic_vector(31 downto 0);
        exp_in_1:	out std_logic_vector(18 downto 0);
        exp_in_2:  	out std_logic_vector(26 downto 0);
        exp_out:	out std_logic_vector(31 downto 0);
        xreg0_out:	out std_logic_vector(31 downto 0);
        xreg1_out: 	out std_logic_vector(31 downto 0);
        alu1_in:	out std_logic_vector(31 downto 0);
        alu0_in:	out std_logic_vector(31 downto 0);
        alu_out:	out std_logic_vector(31 downto 0);
        sr_in:		out std_logic_vector(1 downto 0);
        r_in:		out std_logic_vector(31 downto 0);
        Di_in:		out std_logic_vector(31 downto 0);
        Do_out:		out std_logic_vector(31 downto 0)

        );
    END COMPONENT;

    COMPONENT CONTROL_UNIT
    PORT(
        clk:                    in std_logic;
        reset:					in std_logic;
        opcode:                 in std_logic_vector (4 downto 0);        
        status_register_in:     in std_logic_vector (1 downto 0);
        control_signals_out:    out std_logic_vector (21 downto 0)

        );
    END COMPONENT;

    signal opcode_s: std_logic_vector(4 downto 0);
    signal control_signals_s: std_logic_vector(21 downto 0);
    signal status_register_s: std_logic_vector(1 downto 0);

   	begin

   	DATA_PATH: DATAPATH PORT MAP (
	    clk => clk,
        reset => reset,
	    control_signals_in => control_signals_s,
	    opcode => opcode_s,
	    status_register_out => status_register_s,

	    pc_out => pc_out,
	    ir_out => ir_out,
	    A1_in => A1_in,
	    A2_in => A2_in,
	    A3_in => A3_in,
	    Di3_in => Di3_in,
	    exp_in_1 => exp_in_1,
	    exp_in_2 => exp_in_2,
	    exp_out => exp_out,
	    xreg0_out => xreg0_out,
	    xreg1_out => xreg1_out,
	    alu1_in => alu1_in,
	    alu0_in => alu0_in,
	    alu_out => alu_out,
	    sr_in => sr_in,
	    r_in => r_in,
	    Di_in => Di_in,
	    Do_out => Do_out
        );

   	CONT_UNIT: CONTROL_UNIT PORT MAP (
	    clk => clk,
	    reset => reset,
	    control_signals_out => control_signals_s,
	    opcode => opcode_s,
	    status_register_in => status_register_s

        );

   	opcode <= opcode_s;
   	status_register_out <= status_register_s;
   	control_signals <= control_signals_s;

end architecture structural;