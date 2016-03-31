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
use ieee.std_logic_arith.ALL;

entity DATAPATH is
  port(
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
end DATAPATH;
 
architecture structural of DATAPATH is
 
    COMPONENT ALU
    PORT(
        in0:         in  std_logic_vector (31 downto 0);
        in1:         in  std_logic_vector (31 downto 0);
        control:     in  std_logic_vector (2 downto 0);

        alu_out:     out std_logic_vector (31 downto 0);
        carry:       out std_logic;
        zero:        out std_logic

        );
    END COMPONENT;

    COMPONENT register_file
    PORT(
        clk:   in  std_logic;

        --A1, read chanell 1
        raddress1:  in  std_logic_vector(3 downto 0);
        rdata1:   out std_logic_vector(31 downto 0);

        --A2, read chanell 2
        raddress2:  in  std_logic_vector(3 downto 0);
        rdata2:   out std_logic_vector(31 downto 0);

        --A3, write chanell 1
        waddress1:  in  std_logic_vector(3 downto 0);
        wdata1:   in std_logic_vector(31 downto 0);
        write1:   in std_logic

        );
    END COMPONENT;

    COMPONENT data_memory
    PORT(
        clk:    in  std_logic;

        --A1, read chanell 1
        address:  in  std_logic_vector(31 downto 0);
        rdata:    out std_logic_vector(31 downto 0);
        wdata:    in std_logic_vector(31 downto 0);
        write1:   in std_logic
        
        );
    END COMPONENT;

    COMPONENT instruction_memory
    PORT(
        --A, read chanell 1
        raddress: in  std_logic_vector (31 downto 0);
        rdata:    out std_logic_vector (31 downto 0)
        
        );
    END COMPONENT;

    COMPONENT expand_block
    PORT(
        in0:          in  std_logic_vector (18 downto 0);
        in1:          in  std_logic_vector (26 downto 0);
        exp_control:  in  std_logic;

        exp_out:      out std_logic_vector (31 downto 0)

        );
    END COMPONENT;

    COMPONENT mux_2_to_1_32bit
    PORT(
        x1:   in std_logic_vector (31 downto 0);
        x2:   in std_logic_vector (31 downto 0);
        sel:  in std_logic;
        
        y:    out std_logic_vector (31 downto 0)
        
        );
    END COMPONENT;

    COMPONENT mux_2_to_1_5bit
    PORT(
        x1:   in std_logic_vector (4 downto 0);
        x2:   in std_logic_vector (4 downto 0);
        sel:  in std_logic;
        
        y:    out std_logic_vector (4 downto 0)
        
        );
    END COMPONENT;

    COMPONENT mux_2_to_1_4bit
    PORT(
        x1:   in std_logic_vector (3 downto 0);
        x2:   in std_logic_vector (3 downto 0);
        sel:  in std_logic;
        
        y:    out std_logic_vector (3 downto 0)
        
        );
    END COMPONENT;

    COMPONENT mux_4_to_1
    PORT(
        x1:   in std_logic_vector (31 downto 0);
        x2:   in std_logic_vector (31 downto 0);
        x3:   in std_logic_vector (31 downto 0);
        x4:   in std_logic_vector (31 downto 0);
        sel:  in std_logic_vector (1 downto 0);

        y:    out std_logic_vector (31 downto 0)
        
        );
    END COMPONENT;

    COMPONENT reg_2_bit
    PORT(
        clk:    in std_logic;
        clk_en: in std_logic;
        reset:  in std_logic;
        in1:    in std_logic_vector (1 downto 0);

        out1:   out std_logic_vector (1 downto 0)
        
        );
    END COMPONENT;

    COMPONENT reg_32_bit
    PORT(
        clk_en:   in std_logic;
        clk:      in std_logic;
        reset:    in std_logic;
        in1:      in std_logic_vector (31 downto 0);

        out1:     out std_logic_vector (31 downto 0)
        
        );
    END COMPONENT;

    signal s0, s1, s2, s4, s5, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17: std_logic_vector (31 downto 0);
    signal s6, s7: std_logic_vector (3 downto 0);
    signal s3: std_logic_vector (31 downto 0);
    signal s18: std_logic_vector (1 downto 0);

begin

    A_L_U: ALU PORT MAP (
        in0 => s11,
        in1 => s10,
        control => control_signals_in(5 downto 3), 
        alu_out => s12,
        carry => s18(1),
        zero => s18(0)
        );

    REG_FILE: register_file PORT MAP (
        clk => clk,
        raddress1 => s3(22 downto 19),
        rdata1 => s5,
        raddress2 => s6,
        rdata2 => s8,
        waddress1 => s7,
        wdata1 => s4,
        write1 => control_signals_in(12)
        );

    DAT_MEM: data_memory PORT MAP (
        clk => clk,
        address => s16,
        rdata => s17,
        wdata => s8,
        write1 => control_signals_in(0)
        );

    INST_MEM: instruction_memory PORT MAP (
        raddress => s1,
        rdata => s2
        );

    EXP_BLOCK: expand_block PORT MAP (
        in0 => s3(18 downto 0),
        in1 => s3(26 downto 0),
        exp_control => control_signals_in(11),
        exp_out => s14
        );

    MPC: mux_2_to_1_32bit PORT MAP (
        x1 => s12,
        x2 => s14,
        sel => control_signals_in(18),
        y => s0
        );

    MOP: mux_2_to_1_5bit PORT MAP (
        x1 => s3(31 downto 27),
        x2 => s2(31 downto 27),
        sel => control_signals_in(21),
        y => opcode
        );

    MRF1: mux_2_to_1_4bit PORT MAP (
        x1 => s3(18 downto 15),
        x2 => s3(26 downto 23),
        sel => control_signals_in(16),
        y => s6
        );

    MRF2: mux_2_to_1_4bit PORT MAP (
        x1 => s3(26 downto 23),
        x2 => s3(22 downto 19),
        sel => control_signals_in(15),
        y => s7
        );

    MRF3: mux_4_to_1 PORT MAP (
        x1 => s17,
        x2 => s12,
        x3 => s16,
        x4 => s15,
        sel => control_signals_in(14 downto 13),
        y => s4
        );

    MA1: mux_2_to_1_32bit PORT MAP (
            x1 => s9,
            x2 => s1,
            sel => control_signals_in(8),
            y => s10
            );

    MA2: mux_4_to_1 PORT MAP (
        x1 => s13,
        x2 => s14,
        x3 => X"00000001",
        x4 => X"00000000",
        sel => control_signals_in(7 downto 6),
        y => s11
        );

    MR: mux_2_to_1_32bit PORT MAP (
        x1 => s12,
        x2 => s9,
        sel => control_signals_in(2),
        y => s15
        );

    SR: reg_2_bit PORT MAP (
        clk => clk,
        reset => reset,
        clk_en => control_signals_in(20),
        in1 => s18,
        out1 => status_register_out
        );

    PC: reg_32_bit PORT MAP (
        clk_en => control_signals_in(19),
        clk => clk,
        reset => reset,
        in1 => s0,
        out1 => s1
        );

    IR: reg_32_bit PORT MAP (
        clk_en => control_signals_in(17),
        clk => clk,
        reset => reset,
        in1 => s2,
        out1 => s3
        );

    XREG0: reg_32_bit PORT MAP (
        clk_en => control_signals_in(10),
        clk => clk,
        reset => reset,
        in1 => s5,
        out1 => s9
        );

    XREG1: reg_32_bit PORT MAP (
        clk_en => control_signals_in(9),
        clk => clk,
        reset => reset,
        in1 => s8,
        out1 => s13
        );

    R: reg_32_bit PORT MAP (
        clk_en => control_signals_in(1),
        clk => clk,
        reset => reset,
        in1 => s15,
        out1 => s16
        );

    pc_out <= s1;
    ir_out <= s3;
    A1_in <= s3(22 downto 19);
    A2_in <= s6;
    A3_in <= s7;
    Di3_in <= s4;
    exp_in_1 <= s3(18 downto 0);
    exp_in_2 <= s3(26 downto 0);
    exp_out <= s14;
    xreg0_out <= s9;
    xreg1_out <= s13;
    alu1_in <= s10;
    alu0_in <= s11;
    alu_out <= s12;
    sr_in <= s18;
    r_in <= s15;
    Di_in <= s8;
    Do_out <= s17;

end architecture structural;
