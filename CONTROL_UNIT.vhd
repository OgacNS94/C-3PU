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

entity CONTROL_UNIT is
  port(
        clk:                    in std_logic;
        reset:					in std_logic;
        opcode:                 in std_logic_vector (4 downto 0);        
        status_register_in:     in std_logic_vector (1 downto 0);
        control_signals_out:    out std_logic_vector (21 downto 0)        

      );
end CONTROL_UNIT;

architecture behavioral of CONTROL_UNIT is

type state_type is (A0, A1, A2, A3, A4, A5, A11, A12, A13, A14, A15, A16, A17, A18, A19, A21, A22, A23, A31, A32, A33, A34, A35, A36, A37, A38, B1, B2, B3);
signal state: state_type;

begin

	process (clk, reset) is
	begin

		if(reset= '1') then

			state <= A0;

		elsif (clk'event and clk='1') then
			
			case state is

				when A0 => 

					case opcode is

						when "11110" => state <= A0;
						when "11011" => 
							if(status_register_in="00" or status_register_in="10") then
								state <= A0;
							else
								state <= A4;
							end if;
						when "11100" =>	
							if(status_register_in="00" or status_register_in="01") then
								state <= A0;
							else
								state <= A4;
							end if;
						when "11010" => state <= A4;
						when "11101" => state <= A5;
						when "00000" => state <= A1;
						when "00001" => state <= A1;
						when "00010" => state <= A1;
						when "00110" => state <= A1;
						when "00111" => state <= A1;
						when "01000" => state <= A1;
						when "01100" => state <= A1;
						when "01101" => state <= A1;
						when "10100" => state <= A1;
						when "10101" => state <= A1;
						when "11001" => state <= A1;
						when "10011" => state <= A1;
						when "10000" => state <= A2;
						when "10001" => state <= A2;
						when "10010" => state <= A2;
						when "00011" => state <= A3;
						when "00100" => state <= A3;
						when "00101" => state <= A3;
						when "01001" => state <= A3;
						when "01010" => state <= A3;
						when "01011" => state <= A3;
						when "01110" => state <= A3;
						when "01111" => state <= A3;
						when "10110" => state <= A3;
						when "10111" => state <= A3;
						when "11000" => state <= A3;
						when others  => null;					

					end case;

				when A1 =>

					case opcode is

						when "11001" => state <= A11;
						when "01000" => state <= A12;
						when "00010" => state <= A12;
						when "00001" => state <= A13;
						when "00111" => state <= A13;
						when "00000" => state <= A14;
						when "00110" => state <= A14;					
						when "01100" => state <= A15;
						when "01101" => state <= A16;
						when "10011" => state <= A17;
						when "10100" => state <= A18;
						when "10101" => state <= A19;
						when others  => null;

					end case;

				when A2 =>

					case opcode is

						when "10000" => state <= A21;
						when "10001" => state <= A22;
						when "10010" => state <= A23;
						when others  => null;

					end case;

				when A3 =>

					case opcode is

						when "11000" => state <= A31;
						when "10111" => state <= A32;
						when "10110" => state <= A33;
						when "01111" => state <= A34;
						when "01110" => state <= A35;
						when "00011" => state <= A36;
						when "01001" => state <= A36;
						when "00100" => state <= A37;
						when "01010" => state <= A37;
						when "00101" => state <= A38;				
						when "01011" => state <= A38;
						when others  => null;		

					end case;

				when A4 to A11 =>

					state <= A0;

				when A12 =>

					if(opcode="00010") then

						state <= B1;

					elsif(opcode="01000") then

						state <= B3;

					end if;

				when A13 =>

					if(opcode="00001") then

						state <= B1;

					elsif(opcode="00111") then

						state <= B3;

					end if;

				when A14 => 

					if(opcode="00000") then

						state <= B1;

					elsif(opcode="00110") then

						state <= B3;

					end if;

				when A15 to A35 =>

					state <= B2;

				when A36 =>

					if(opcode="00011") then

						state <= B1;

					elsif(opcode="01001") then

						state <= B3;

					end if;

				when A37 => 

					if(opcode="00100") then

						state <= B1;

					elsif(opcode="01010") then

						state <= B3;

					end if;

				when A38 =>

					if(opcode="00101") then

						state <= B1;

					elsif(opcode="01011") then

						state <= B3;

					end if;

				when B1 to B3 =>

					state <= A0;

			end case;

		end if;

	end process;

	process (state) is
	begin

		case state is

			when A0  => control_signals_out <= "10"&X"20000";
			when A1  => control_signals_out <= "00"&X"80580";
			when A2  => control_signals_out <= "00"&X"90380";
			when A3  => control_signals_out <= "00"&X"80780";
			when A4  => control_signals_out <= "00"&X"C0800";
			when A5  => control_signals_out <= "00"&X"80180";
			when A11 => control_signals_out <= "00"&X"07004";
			when A12 => control_signals_out <= "00"&X"0B046";
			when A13 => control_signals_out <= "00"&X"0B042";
			when A14 => control_signals_out <= "00"&X"00042";
			when A15 => control_signals_out <= "01"&X"00042";
			when A16 => control_signals_out <= "01"&X"0004A";
			when A17 => control_signals_out <= "01"&X"00052";
			when A18 => control_signals_out <= "01"&X"0005A";
			when A19 => control_signals_out <= "01"&X"00062";
			when A21 => control_signals_out <= "01"&X"0002A";
			when A22 => control_signals_out <= "01"&X"00032";
			when A23 => control_signals_out <= "01"&X"0003A";
			when A31 => control_signals_out <= "01"&X"00022";
			when A32 => control_signals_out <= "01"&X"0001A";
			when A33 => control_signals_out <= "01"&X"00012";
			when A34 => control_signals_out <= "01"&X"0000A";
			when A35 => control_signals_out <= "01"&X"00002";
			when A36 => control_signals_out <= "00"&X"00002";
			when A37 => control_signals_out <= "00"&X"0B002";
			when A38 => control_signals_out <= "00"&X"0B006";
			when B1  => control_signals_out <= "00"&X"01000";
			when B2  => control_signals_out <= "00"&X"05000";
			when B3  => control_signals_out <= "00"&X"10001";

		end case;

	end process;

end architecture behavioral; 