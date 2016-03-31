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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	port(
			in0: 		in  std_logic_vector (31 downto 0);
			in1: 		in  std_logic_vector (31 downto 0);
			control:	in  std_logic_vector (2 downto 0);

			alu_out: 	out std_logic_vector (31 downto 0);
			carry:		out std_logic;
			zero:		out std_logic

		);
end entity ALU;

architecture behavioral of ALU is

	signal alu_out_s: std_logic_vector (32 downto 0);

	begin

		process (control, in0, in1) is

		begin

			case control is

				when "000" => 
					alu_out_s <= conv_std_logic_vector(conv_integer(in0), 33) + conv_std_logic_vector(conv_integer(in1), 33);
					--carry <= conv_std_logic_vector(conv_integer(in0+in1), 33)(0);

				when "001" => 
					alu_out_s <= conv_std_logic_vector(conv_integer(in0), 33) - conv_std_logic_vector(conv_integer(in1), 33);
					--carry <= conv_std_logic_vector(conv_integer(in0-in1), 33)(0);

				when "010" => 
					alu_out_s <= '0'&(in0 or in1);
					--carry <= '0';

				when "011" => 
					alu_out_s <= '0'&(in0 and in1);
					--carry <= '0';

				when "100" => 
					alu_out_s <= '0'&(in0 xor in1);
					--carry <= '0';

				when "101" => 
					alu_out_s <= '0'&(not in0);
					--carry <= '0';

				when "110" => 
					alu_out_s <= in0(0)&'0'&in0(31 downto 1); --SHIFT LOGICAL RIGHT, in0(0) goes to 33 bit because of carry
					--carry <= in0(0);

				when others => 
					alu_out_s <= in0(31 downto 0)&'0'; --SHIFT LOGICAL LEFT
					--carry <= in0(31);
				
			end case;

		end process;

		process (alu_out_s) is

			begin

			if (alu_out_s(31 downto 0) = X"00000000") then

				zero <= '1';

			else
				
				zero <= '0';

			end if;

		end process;

		alu_out <= alu_out_s(31 downto 0);
		carry <= alu_out_s(32);

end architecture behavioral;