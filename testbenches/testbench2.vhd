library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library neorv32;
use neorv32.neorv32_types.all;

entity tb1_neorv32_xirq is
end tb1_neorv32_xirq;

architecture behavior of tb1_neorv32_xirq is

  -- Constants
  constant clk_period : time := 10 ns;
  constant XIRQ_NUM_CH : natural := 32;

  -- Signals for the UUT
  signal clk_i     : std_ulogic := '0';
  signal rstn_i    : std_ulogic := '0'; -- Active-low reset signal
  signal bus_req_i : bus_req_t;
  signal bus_rsp_o : bus_rsp_t;
  signal xirq_i    : std_ulogic_vector(31 downto 0) := (others => '0'); -- External IRQ channels
  signal cpu_irq_o : std_ulogic;

  -- Component declaration
  component neorv32_xirq is
    generic (
      XIRQ_NUM_CH : natural range 0 to 32
    );
    port (
      clk_i     : in  std_ulogic;
      rstn_i    : in  std_ulogic;
      bus_req_i : in  bus_req_t;
      bus_rsp_o : out bus_rsp_t;
      xirq_i    : in  std_ulogic_vector(31 downto 0);
      cpu_irq_o : out std_ulogic
    );
  end component;

begin

  -- Clock generation
  clk_process : process
  begin
    while true loop
      clk_i <= '0';
      wait for clk_period / 2;
      clk_i <= '1';
      wait for clk_period / 2;
    end loop;
  end process;

  -- Reset generation
  reset_process : process
  begin
    rstn_i <= '0'; -- Assert reset (active-low)
    wait for 20 ns;
    rstn_i <= '1'; -- Deassert reset (normal operation)
    wait;
  end process;

  -- Instantiate the UUT
  uut: neorv32_xirq
    generic map (
      XIRQ_NUM_CH => XIRQ_NUM_CH
    )
    port map (
      clk_i     => clk_i,
      rstn_i    => rstn_i,
      bus_req_i => bus_req_i,
      bus_rsp_o => bus_rsp_o,
      xirq_i    => xirq_i,
      cpu_irq_o => cpu_irq_o
    );

  -- Stimulus process
  stimulus_process: process
  begin
    -- Initialize signals
    bus_req_i.stb <= '0';
    bus_req_i.rw <= '0';
    bus_req_i.addr <= (others => '0');
    bus_req_i.data <= (others => '0');
    
    -- Wait for reset to complete
    wait for 30 ns;
    
    -- -- Test case 1: Enable and trigger interrupt on channel 0
    -- -- Enable interrupt channel 0
    -- bus_req_i.stb <= '1';
    -- bus_req_i.rw <= '1';
    -- bus_req_i.addr <= "00000"; -- Channel enable address
    -- bus_req_i.data(XIRQ_NUM_CH-1 downto 0) <= "00000000000000000000000000000001"; -- Enable channel 0
    -- wait for clk_period;
    -- bus_req_i.stb <= '0';
    -- wait for clk_period;
    
    -- -- Generate external interrupt on channel 0
    -- xirq_i(0) <= '1';
    -- wait for clk_period;
    -- xirq_i(0) <= '0';
    
    -- -- Wait for some time to observe the interrupt
    -- wait for 100 ns;
    
    -- -- Check for interrupt
    -- assert cpu_irq_o = '1' report "Interrupt on channel 0 not detected" severity error;

    -- -- Clear pending interrupts
    -- bus_req_i.stb <= '1';
    -- bus_req_i.rw <= '1';
    -- bus_req_i.addr <= "00011"; -- Clear pending interrupts address
    -- bus_req_i.data(XIRQ_NUM_CH-1 downto 0) <= (others => '1'); -- Clear all pending interrupts
    -- wait for clk_period;
    -- bus_req_i.stb <= '0';
    -- wait for clk_period;

    -- -- Test case 2: Enable and trigger interrupts on channels 1 and 2
    -- -- Enable interrupt channels 1 and 2
    -- bus_req_i.stb <= '1';
    -- bus_req_i.rw <= '1';
    -- bus_req_i.addr <= "00000"; -- Channel enable address
    -- bus_req_i.data(XIRQ_NUM_CH-1 downto 0) <= "00000000000000000000000000000110"; -- Enable channel 1 and 2
    -- wait for clk_period;
    -- bus_req_i.stb <= '0';
    -- wait for clk_period;
    
    -- -- Generate external interrupt on channel 1
    -- xirq_i(1) <= '1';
    -- wait for clk_period;
    -- xirq_i(1) <= '0';
    
    -- -- Wait for some time to observe the interrupt
    -- wait for 100 ns;
    
    -- -- Check for interrupt
    -- assert cpu_irq_o = '1' report "Interrupt on channel 1 not detected" severity error;

    -- -- Clear pending interrupts
    -- bus_req_i.stb <= '1';
    -- bus_req_i.rw <= '1';
    -- bus_req_i.addr <= "00001"; -- Clear pending interrupts address
    -- bus_req_i.data(XIRQ_NUM_CH-1 downto 0) <= (others => '1'); -- Clear all pending interrupts
    -- wait for clk_period;
    -- bus_req_i.stb <= '0';
    -- wait for clk_period;
    
    -- -- Generate external interrupt on channel 2
    -- xirq_i(2) <= '1';
    -- wait for clk_period;
    -- xirq_i(2) <= '0';
    
    -- -- Wait for some time to observe the interrupt
    -- wait for 100 ns;
    
    -- -- Check for interrupt
    -- assert cpu_irq_o = '1' report "Interrupt on channel 2 not detected" severity error;

    -- Test case 3: Edge-triggered interrupt
    -- Configure channel 3 for rising-edge trigger
    bus_req_i.stb <= '1';
    bus_req_i.rw <= '1';
    bus_req_i.addr <= "01111"; -- Trigger type address
    bus_req_i.data(XIRQ_NUM_CH-1 downto 0) <= "00000000000000000000000000001000"; -- Set channel 3 to edge-triggered
    wait for clk_period;
    bus_req_i.stb <= '0';
    wait for clk_period;

    -- Enable interrupt channel 3
    bus_req_i.stb <= '1';
    bus_req_i.rw <= '1';
    bus_req_i.addr <= "00000"; -- Channel enable address
    bus_req_i.data(XIRQ_NUM_CH-1 downto 0) <= "00000000000000000000000000001000"; -- Enable channel 3
    wait for clk_period;
    bus_req_i.stb <= '0';
    wait for clk_period;

    -- Generate rising-edge interrupt on channel 3
    xirq_i(3) <= '0';
    wait for clk_period;
    xirq_i(3) <= '1'; -- Trigger interrupt
    wait for clk_period;
    xirq_i(3) <= '0'; -- Clear interrupt
    
    -- Wait for some time to observe the interrupt
    wait for 100 ns;

    -- Check for interrupt
    assert cpu_irq_o = '1' report "Edge-triggered interrupt on channel 3 not detected" severity error;

    -- Finish simulation
    wait;
  end process;
  
end behavior;
