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

entity instruction_memory is
	port(
			--A, read chanell 1
			raddress:	in  std_logic_vector (31 downto 0);
			rdata:		out std_logic_vector (31 downto 0)

		);
end entity instruction_memory;

--ROM WITH ASYNCHRONOUS READING

architecture behavioral of instruction_memory is
	
	--ROM SIZE 2^27x32 (MAX) 
	type rom_type is array (0 to 524287) of std_logic_vector(31 downto 0);
	signal rom_s: rom_type := (others => X"00000000");

	begin

	--asynchronous reading:
	rdata <= rom_s(conv_integer(raddress));

end architecture behavioral;