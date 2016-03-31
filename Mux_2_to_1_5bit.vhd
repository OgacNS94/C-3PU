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

entity mux_2_to_1_5bit is
	port(
			x1: 	in std_logic_vector (4 downto 0);
			x2: 	in std_logic_vector (4 downto 0);
			sel: 	in std_logic;
			
			y: 		out std_logic_vector (4 downto 0)

		);
end entity mux_2_to_1_5bit;

architecture behavioral of mux_2_to_1_5bit is

	begin

		mux: process (x1, x2, sel) is

		begin

			case sel is

				when '0' => y <= x1;
				when others => y <= x2;

			end case;

		end process;

end architecture behavioral;