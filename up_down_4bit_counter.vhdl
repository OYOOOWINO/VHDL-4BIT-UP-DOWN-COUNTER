LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- counter entity definition
ENTITY counter_4bit IS
    -- input and output logic declarations
    PORT (
        clk, rst, u_d, ld : IN STD_LOGIC;
        q_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END counter_4bit;

--architecture definition
ARCHITECTURE counter_behaviour OF counter_4bit IS
    SIGNAL temp: STD_LOGIC_VECTOR (3 DOWNTO 0); -- temporary vector to hold user unput
    SIGNAL rst_n: STD_LOGIC; -- signal to hold inverted rst
BEGIN
    PROCESS (clk, rst)
    BEGIN
        rst_n <= NOT rst; --invert rst input signal
        IF (rst_n = '1') THEN
            temp <= "0000";
        ELSIF (clk'event AND rising_edge(clk)) THEN
            IF (ld = '1') THEN
                temp <= data_in; -- load input parallel data
            ELSE
                IF (u_d = '1') THEN
                    temp <= STD_LOGIC_VECTOR (unsigned(temp) + 1); -- increment count
                ELSE
                    temp <= STD_LOGIC_VECTOR (unsigned(temp) - 1); -- decrement count
                END IF;
            END IF;
        END IF;
    END PROCESS;
    q_out <= temp; -- change output to current temp signal value
END counter_behaviour;	
