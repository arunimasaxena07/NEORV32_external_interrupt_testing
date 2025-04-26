library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library neorv32;
use neorv32.neorv32_types.all;

entity tb_neorv32_xirq is
end tb_neorv32_xirq;

architecture behavior of tb_neorv32_xirq is

  -- Constants
  constant clk_period : time := 10 ns;
  constant XIRQ_NUM_CH : natural := 32;

  -- Signals for the UUT
  signal clk_i     : std_ulogic := '0';
  signal rstn_i    : std_ulogic := '0';
  signal bus_req_i : bus_req_t;
  signal bus_rsp_o : bus_rsp_t;
  signal xirq_i    : std_ulogic_vector(31 downto 0) := (others => '0');
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
    rstn_i <= '0';
    wait for 20 ns;
    rstn_i <= '1';
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
    
    -- Wait for reset
    wait for 30 ns;
    
    -- Enable interrupt channel 0
    bus_req_i.stb <= '1';
    bus_req_i.rw <= '1';
    bus_req_i.addr <= "00000"; -- Channel enable address
    bus_req_i.data(XIRQ_NUM_CH-1 downto 0) <= "00000000000000000000000000000001"; -- Enable channel 0
    wait for clk_period;
    bus_req_i.stb <= '0';
    wait for clk_period;
    
    -- Generate external interrupt on channel 0
    xirq_i(0) <= '1';
    wait for clk_period;
    xirq_i(0) <= '0';
    
    -- Wait for some time to observe the interrupt
    wait for 100 ns;
    
    -- Finish simulation
    wait;
  end process;

end behavior;

