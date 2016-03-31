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

entity expand_block is
	port(
			in0: 			in  std_logic_vector (18 downto 0);
			in1: 			in  std_logic_vector (26 downto 0);
			exp_control:	in  std_logic;

			exp_out: 		out std_logic_vector (31 downto 0)

		);
end entity expand_block;

architecture behavioral of expand_block is
	
	begin

		process (in0, in1, exp_control) is
		
		begin

			case exp_control is

				when '0' => 	exp_out <= "0000000000000"&in0;
				when others =>  exp_out <= "00000"&in1;

			end case;

		end process;

end architecture behavioral;