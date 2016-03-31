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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_memory is
	port(
			clk:		in  std_logic;

			--A1, read chanell 1
			address:	in  std_logic_vector(31 downto 0);
			rdata:		out std_logic_vector(31 downto 0);
			wdata:		in std_logic_vector(31 downto 0);
			write1:		in std_logic

		);
end entity data_memory;

--RAM WITH ASYNCHRONOUS READING

architecture behavioral of data_memory is

	--2^19x32 = 2^20x2x8 = 2MB RAM
	type ram_type is array (0 to 524287) of std_logic_vector(31 downto 0);
	signal ram_s: ram_type := (others => X"00000000");

	begin

	--process modelling writing:
	write_ram: process (clk) is
	begin

		if(clk'event and clk='1') then

			if(write1 = '1') then

				ram_s(conv_integer(address)) <= wdata;

			end if;

		end if;

	end process;

	--asynchronous reading:
	rdata <= ram_s(conv_integer(address));

end architecture behavioral;