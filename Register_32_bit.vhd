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

entity reg_32_bit is
	port(
			clk_en: 	in std_logic;
			clk: 		in std_logic;
			reset:		in std_logic;
			in1: 		in std_logic_vector (31 downto 0);

			out1: 			out std_logic_vector (31 downto 0)

		);
end entity reg_32_bit;

architecture behavioral of reg_32_bit is

	begin

		process (clk) is

		begin

			if(reset='0') then 

				if(clk'event and clk='1') then

					if(clk_en='1') then

						out1 <= in1;

					end if;

				end if;

			elsif (reset='1') then

				out1 <= X"00000000";

			end if;  

		end process;

end architecture behavioral;