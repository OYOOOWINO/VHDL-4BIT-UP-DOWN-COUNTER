LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS

   -- Component Declaration for the Unit Under Test (UUT)
   COMPONENT counter_4bit
      PORT (
         clk: IN STD_LOGIC;
         rst: IN STD_LOGIC;
         u_d: IN STD_LOGIC;
         ld: IN STD_LOGIC;
         q_out: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
         data_in: IN STD_LOGIC_VECTOR (3 DOWNTO 0)
      );
   END COMPONENT;
   --Inputs
   SIGNAL clk: STD_LOGIC := '0';
   SIGNAL rst: STD_LOGIC := '0';
   SIGNAL u_d: STD_LOGIC := '0';
   SIGNAL ld: STD_LOGIC := '0';
   SIGNAL data_in : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

   --Outputs
   SIGNAL q_out: STD_LOGIC_VECTOR (3 DOWNTO 0);

   -- Clock period definitions
   CONSTANT clk_period : TIME := 10 ns;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut : counter_4bit PORT MAP(
      clk => clk,
      rst => rst,
      u_d => u_d,
      ld => ld,
      q_out => q_out,
      data_in => data_in
   );

   -- Clock process definitions
   clk_process : PROCESS
   BEGIN
      clk <= '0';
      WAIT FOR clk_period/2;
      clk <= '1';
      WAIT FOR clk_period/2;
   END PROCESS;
   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      -- hold reset state for 100 ns to clear count values.
      rst <= '0';
      WAIT FOR 100 ns;

      -- stimulus
      rst <= '1';
      ld <= '1';
      data_in <= "1001";
      WAIT FOR 100 ns;
      rst <= '1';
      ld <= '0';
      data_in <= "0000";
      WAIT FOR clk_period * 10;
      WAIT;
   END PROCESS;

END;
