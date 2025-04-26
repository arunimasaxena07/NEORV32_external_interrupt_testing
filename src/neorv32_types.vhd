library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package neorv32_types is

  -- Define the bus request type
  type bus_req_t is record
    stb   : std_ulogic;                -- strobe signal
    rw    : std_ulogic;                -- read/write signal
    addr  : std_ulogic_vector(4 downto 0); -- address signal
    data  : std_ulogic_vector(31 downto 0); -- data signal
  end record;

  -- Define the bus response type
  type bus_rsp_t is record
    ack   : std_ulogic;                -- acknowledge signal
    err   : std_ulogic;                -- error signal
    data  : std_ulogic_vector(31 downto 0); -- data signal
  end record;

end package neorv32_types;

