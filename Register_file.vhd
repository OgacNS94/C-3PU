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

entity register_file is
	port(
			clk:		in  std_logic;

			--A1, read chanell 1
			raddress1:	in  std_logic_vector(3 downto 0);
			rdata1:		out std_logic_vector(31 downto 0);

			--A2, read chanell 2
			raddress2:	in  std_logic_vector(3 downto 0);
			rdata2:		out std_logic_vector(31 downto 0);

			--A3, write chanell 1
			waddress1:	in  std_logic_vector(3 downto 0);
			wdata1:		in std_logic_vector(31 downto 0);
			write1:		in std_logic

		);
end entity register_file;

--REGISTER FILE WITH ASYNCHRONOUS READING

architecture behavioral of register_file is

	--R15 IS A ZERO_REGISTER	
	type reg_file_type is array (0 to 15) of std_logic_vector(31 downto 0);
	signal reg_file_s: reg_file_type := (15 => X"00000000", others => X"00000000");

	begin

	--process modelling writing:
	write_reg_file: process (clk) is
	begin

		if(clk'event and clk='1') then

			if(write1 = '1') then

				if(conv_integer(waddress1)=15) then

					null;			
				
				else

					reg_file_s(conv_integer(waddress1)) <= wdata1;

				end if; 

			end if;

		end if;

	end process;

	--asynchronous reading:
	rdata1 <= reg_file_s(conv_integer(raddress1));
	rdata2 <= reg_file_s(conv_integer(raddress2));

end architecture behavioral;
