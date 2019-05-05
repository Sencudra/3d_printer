
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module printer(

	//////////// ADC //////////
	output		          		ADC_CONVST,
	output		          		ADC_SCK,
	output		          		ADC_SDI,
	input 		          		ADC_SDO,

	//////////// ARDUINO //////////
	inout 		    [15:0]		ARDUINO_IO,
	inout 		          		ARDUINO_RESET_N,

	//////////// CLOCK //////////
	input 		          		FPGA_CLK1_50,
	input 		          		FPGA_CLK2_50,
	input 		          		FPGA_CLK3_50,

	//////////// HDMI //////////
	inout 		          		HDMI_I2C_SCL,
	inout 		          		HDMI_I2C_SDA,
	inout 		          		HDMI_I2S,
	inout 		          		HDMI_LRCLK,
	inout 		          		HDMI_MCLK,
	inout 		          		HDMI_SCLK,
	output		          		HDMI_TX_CLK,
	output		          		HDMI_TX_DE,
	output		    [23:0]		HDMI_TX_D,
	output		          		HDMI_TX_HS,
	input 		          		HDMI_TX_INT,
	output		          		HDMI_TX_VS,

	//////////// HPS //////////
	inout 		          		HPS_CONV_USB_N,
	output		    [14:0]		HPS_DDR3_ADDR,
	output		     [2:0]		HPS_DDR3_BA,
	output		          		HPS_DDR3_CAS_N,
	output		          		HPS_DDR3_CKE,
	output		          		HPS_DDR3_CK_N,
	output		          		HPS_DDR3_CK_P,
	output		          		HPS_DDR3_CS_N,
	output		     [3:0]		HPS_DDR3_DM,
	inout 		    [31:0]		HPS_DDR3_DQ,
	inout 		     [3:0]		HPS_DDR3_DQS_N,
	inout 		     [3:0]		HPS_DDR3_DQS_P,
	output		          		HPS_DDR3_ODT,
	output		          		HPS_DDR3_RAS_N,
	output		          		HPS_DDR3_RESET_N,
	input 		          		HPS_DDR3_RZQ,
	output		          		HPS_DDR3_WE_N,
	output		          		HPS_ENET_GTX_CLK,
	inout 		          		HPS_ENET_INT_N,
	output		          		HPS_ENET_MDC,
	inout 		          		HPS_ENET_MDIO,
	input 		          		HPS_ENET_RX_CLK,
	input 		     [3:0]		HPS_ENET_RX_DATA,
	input 		          		HPS_ENET_RX_DV,
	output		     [3:0]		HPS_ENET_TX_DATA,
	output		          		HPS_ENET_TX_EN,
	inout 		          		HPS_GSENSOR_INT,
	inout 		          		HPS_I2C0_SCLK,
	inout 		          		HPS_I2C0_SDAT,
	inout 		          		HPS_I2C1_SCLK,
	inout 		          		HPS_I2C1_SDAT,
	inout 		          		HPS_KEY,
	inout 		          		HPS_LED,
	inout 		          		HPS_LTC_GPIO,
	output		          		HPS_SD_CLK,
	inout 		          		HPS_SD_CMD,
	inout 		     [3:0]		HPS_SD_DATA,
	output		          		HPS_SPIM_CLK,
	input 		          		HPS_SPIM_MISO,
	output		          		HPS_SPIM_MOSI,
	inout 		          		HPS_SPIM_SS,
	input 		          		HPS_UART_RX,
	output		          		HPS_UART_TX,
	input 		          		HPS_USB_CLKOUT,
	inout 		     [7:0]		HPS_USB_DATA,
	input 		          		HPS_USB_DIR,
	input 		          		HPS_USB_NXT,
	output		          		HPS_USB_STP,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [7:0]		LED,

	//////////// SW //////////
	input 		     [3:0]		SW,

	//////////// GPIO_0, GPIO connect to GPIO Default //////////
	output 		    [35:0]		gpio0GPIO, //переделать на in или Out

	//////////// GPIO_1, GPIO connect to GPIO Default //////////
	input 		    [35:0]		gpio1GPIO
);


//=======================================================
//  REG/WIRE declarations
//=======================================================

wire hps_fpga_reset_n;
wire     [1: 0]     fpga_debounced_buttons;
wire     [6: 0]     fpga_led_internal;
wire     [2: 0]     hps_reset_req;
wire                hps_cold_reset;
wire                hps_warm_reset;
wire                hps_debug_reset;
wire     [27: 0]    stm_hw_events;
wire                fpga_clk_50;
// connection of internal logics
//assign LED[7: 6] = fpga_led_internal;
assign fpga_clk_50 = FPGA_CLK1_50;
assign stm_hw_events = {{15{1'b0}}, SW, fpga_led_internal, fpga_debounced_buttons};


//=======================================================
//  MAIN WIRES
//=======================================================

//Clocks
wire CLK_100;
wire CLK_10;
wire CLK_5;
wire CLK_1;


//ADC
wire [11:0] analog [7:0];

//Flags
//=======================================================
// Описание битов флагов
// flags_out[0]:  вкл/выкл stepper (0 - двигатель выключен, 1 - двигатель включен)
// flags_out[1]:  выполнить движение corexy, оси z и экструдера (0 - игнорировать количество шагов, 1 - выполнить движение по количеству шагов)
// flags_out[2]:  команда HOME по оси x
// flags_out[3]:  команда HOME по оси y
// flags_out[4]:  команда HOME по оси z
// flags_out[5]:  выполнить команду HOME (0 - игнорировать количество шагов, 1 - выполнить команду HOME)

// flags_out[6]:	нагреть стол до указанной температуры
// flags_out[7]:	нагреть стол до указанной температуры и ее удержание
//
// flags_out[8]:	нагреть экструдер до указанной температуры
// flags_out[9]:	нагреть экструдер до указанной температуры и ее удержание
// -------------
// flags_in[0]:   выполняется движение по осям или экструдеру (0 - двигатель стоит, 1 - выполняется повор)
// flags_in[1]:	происходит нагрев стола
// flags_in[2]:	происходит нагрев экструдера
//=======================================================
wire	[31:0]	flags_in;
wire	[31:0]	flags_out; //flags_read


reg 	[31:0] 	flags_read;

//Steppers
wire	[0:2]	stepper1; //{enable, step, dir}
wire	[0:2]	stepper2; //{enable, step, dir}
wire	[0:2]	stepper3; //{enable, step, dir}
wire	[0:2]	stepper4; //{enable, step, dir}

wire 	[4:0] step_signal;


wire 	[31:0] 	stepper_1_speed;
wire 	[31:0] 	stepper_2_speed;
wire 	[31:0] 	stepper_3_speed;
wire 	[31:0] 	stepper_4_speed;


wire 	[31:0] 	stepper_1_step_in;
wire 	[31:0] 	stepper_1_step_out;
wire 	[31:0] 	stepper_2_step_in;
wire 	[31:0] 	stepper_2_step_out;
wire 	[31:0] 	stepper_3_step_in;
wire 	[31:0] 	stepper_3_step_out;
wire 	[31:0] 	stepper_4_step_in;
wire 	[31:0] 	stepper_4_step_out;
wire	[30:0]	stepper_remainder [3:0];

reg 	[31:0] 	stepper_step_in [3:0];
reg 	[31:0] 	stepper_step_out [3:0];

//configuration_1
//=======================================================
//	[0]:  инверсия концевика xmin (0 - нет инверсии, 1 - есть инверсия)
//	[1]:  инверсия концевика xmax (0 - нет инверсии, 1 - есть инверсия)
//	[2]:  инверсия концевика ymin (0 - нет инверсии, 1 - есть инверсия)
//	[3]:  инверсия концевика ymax (0 - нет инверсии, 1 - есть инверсия)
//	[4]:  инверсия концевика zmin (0 - нет инверсии, 1 - есть инверсия)
//	[5]:  инверсия концевика zmax (0 - нет инверсии, 1 - есть инверсия)
//
//	[6]:	инверсия двигателя 1 (corexy)
//	[7]:	инверсия двигателя 2 (corexy)
//	[8]:	инверсия двигателя оси z
//	[9]:	инверсия двигателя экструдера
//=======================================================
wire 	[31:0] 	configuration_1; // Начальные данные


assign LED[1] = stepper1[1];
assign LED[2] = stepper2[1];
assign LED[3] = stepper3[1];
assign LED[4] = stepper4[1];
assign LED[5] = heater_bed;
assign LED[6] = heater_e1;

assign {gpio0GPIO[0], gpio0GPIO[2], gpio0GPIO[4]} 	= stepper1; //{enable, step, dir}
assign {gpio0GPIO[1], gpio0GPIO[3], gpio0GPIO[5]} 	= stepper2; //{enable, step, dir}
assign {gpio0GPIO[34], gpio0GPIO[32], gpio0GPIO[30]} 	= stepper3; //{enable, step, dir}
assign {gpio0GPIO[35], gpio0GPIO[33], gpio0GPIO[31]} 	= stepper4; //{enable, step, dir}


//Temperature sensors
wire	[11:0]	temp1;
wire	[11:0]	temp2;
wire	[11:0]	temp_bed;

wire 	[11:0]	temp_bed_bottom;
wire 	[11:0]	temp_bed_upper;
wire 	[11:0]	temp_e1_bottom;
wire 	[11:0]	temp_e1_upper;


assign temp1 		= analog[0];
assign temp2 		= analog[2];
assign temp_bed 	= analog[4];


//Heaters
wire			heater_bed;
wire			heater_e1;

assign gpio0GPIO[6] = heater_bed; //bed
assign gpio0GPIO[7] = heater_e1; //extruder

assign flags_in[1] = heater_bed;
assign flags_in[2] = heater_e1;


//Fans
wire 	[1:0]	fans;

assign gpio0GPIO[8] = fans[0];
assign gpio0GPIO[9] = fans[1];


//End stops
wire	[0:5] end_stop; //Сигнал с концевиков (0 - xmin, 1 - xmax, 2 - ymin, 3 - ymax, 4 - zmin, 5 - zmax)

assign end_stop[0] = gpio1GPIO[0] ^ configuration_1[0];
assign end_stop[1] = gpio1GPIO[1] ^ configuration_1[1];
assign end_stop[2] = gpio1GPIO[2] ^ configuration_1[2];
assign end_stop[3] = gpio1GPIO[3] ^ configuration_1[3];
assign end_stop[4] = gpio1GPIO[4] ^ configuration_1[4];
assign end_stop[5] = gpio1GPIO[5] ^ configuration_1[5];

//=======================================================
//  Structural coding
//=======================================================


 adc_control adc0(
		.CLOCK		(CLK_10),    //                clk.clk
		.ADC_SCLK	(ADC_SCK), // external_interface.SCLK
		.ADC_CS_N	(ADC_CONVST), //                   .CS_N
		.ADC_DOUT	(ADC_SDO), //                   .DOUT
		.ADC_DIN		(ADC_SDI),  //                   .DIN
		.CH0			(analog[0]),      //           readings.CH0
		.CH1			(analog[1]),      //                   .CH1
		.CH2			(analog[2]),      //                   .CH2
		.CH3			(analog[3]),      //                   .CH3
		.CH4			(analog[4]),      //                   .CH4
		.CH5			(analog[5]),      //                   .CH5
		.CH6			(analog[6]),      //                   .CH6
		.CH7			(analog[7]),      //                   .CH7
		.RESET		(!KEY[0])     //              reset.reset
	);


 soc_system u0 (
	//Clock&Reset
	.clk_clk(FPGA_CLK1_50),                                      //                            clk.clk
	
	.pll_sys_outclk100mhz_clk                     (CLK_100),                     //                pll_sys_outclk100mhz.clk
	.pll_sys_outclk10mhz_clk                      (CLK_10),                      //                 pll_sys_outclk10mhz.clk
	.pll_sys_outclk5mhz_clk                       (CLK_5),                       //                  pll_sys_outclk5mhz.clk
	.pll_sys_outclk1mhz_clk                       (CLK_1),                       
	
	.reset_reset_n(hps_fpga_reset_n),

	.hps_0_h2f_reset_reset_n(hps_fpga_reset_n),                  //                hps_0_h2f_reset.reset_n
	.hps_0_f2h_cold_reset_req_reset_n(~hps_cold_reset),          //       hps_0_f2h_cold_reset_req.reset_n
	.hps_0_f2h_debug_reset_req_reset_n(~hps_debug_reset),        //      hps_0_f2h_debug_reset_req.reset_n
	.hps_0_f2h_stm_hw_events_stm_hwevents(stm_hw_events),        //        hps_0_f2h_stm_hw_events.stm_hwevents
	.hps_0_f2h_warm_reset_req_reset_n(~hps_warm_reset),          //       hps_0_f2h_warm_reset_req.reset_n

	//HPS ethernet
	.hps_0_hps_io_hps_io_emac1_inst_TX_CLK(HPS_ENET_GTX_CLK),    //                   hps_0_hps_io.hps_io_emac1_inst_TX_CLK
	.hps_0_hps_io_hps_io_emac1_inst_TXD0(HPS_ENET_TX_DATA[0]),   //                               .hps_io_emac1_inst_TXD0
	.hps_0_hps_io_hps_io_emac1_inst_TXD1(HPS_ENET_TX_DATA[1]),   //                               .hps_io_emac1_inst_TXD1
	.hps_0_hps_io_hps_io_emac1_inst_TXD2(HPS_ENET_TX_DATA[2]),   //                               .hps_io_emac1_inst_TXD2
	.hps_0_hps_io_hps_io_emac1_inst_TXD3(HPS_ENET_TX_DATA[3]),   //                               .hps_io_emac1_inst_TXD3
	.hps_0_hps_io_hps_io_emac1_inst_RXD0(HPS_ENET_RX_DATA[0]),   //                               .hps_io_emac1_inst_RXD0
	.hps_0_hps_io_hps_io_emac1_inst_MDIO(HPS_ENET_MDIO),         //                               .hps_io_emac1_inst_MDIO
	.hps_0_hps_io_hps_io_emac1_inst_MDC(HPS_ENET_MDC),           //                               .hps_io_emac1_inst_MDC
	.hps_0_hps_io_hps_io_emac1_inst_RX_CTL(HPS_ENET_RX_DV),      //                               .hps_io_emac1_inst_RX_CTL
	.hps_0_hps_io_hps_io_emac1_inst_TX_CTL(HPS_ENET_TX_EN),      //                               .hps_io_emac1_inst_TX_CTL
	.hps_0_hps_io_hps_io_emac1_inst_RX_CLK(HPS_ENET_RX_CLK),     //                               .hps_io_emac1_inst_RX_CLK
	.hps_0_hps_io_hps_io_emac1_inst_RXD1(HPS_ENET_RX_DATA[1]),   //                               .hps_io_emac1_inst_RXD1
	.hps_0_hps_io_hps_io_emac1_inst_RXD2(HPS_ENET_RX_DATA[2]),   //                               .hps_io_emac1_inst_RXD2
	.hps_0_hps_io_hps_io_emac1_inst_RXD3(HPS_ENET_RX_DATA[3]),   //                               .hps_io_emac1_inst_RXD3

	//HPS SD card
	.hps_0_hps_io_hps_io_sdio_inst_CMD(HPS_SD_CMD),              //                               .hps_io_sdio_inst_CMD
	.hps_0_hps_io_hps_io_sdio_inst_D0(HPS_SD_DATA[0]),           //                               .hps_io_sdio_inst_D0
	.hps_0_hps_io_hps_io_sdio_inst_D1(HPS_SD_DATA[1]),           //                               .hps_io_sdio_inst_D1
	.hps_0_hps_io_hps_io_sdio_inst_CLK(HPS_SD_CLK),              //                               .hps_io_sdio_inst_CLK
	.hps_0_hps_io_hps_io_sdio_inst_D2(HPS_SD_DATA[2]),           //                               .hps_io_sdio_inst_D2
	.hps_0_hps_io_hps_io_sdio_inst_D3(HPS_SD_DATA[3]),           //                               .hps_io_sdio_inst_D3

	//HPS USB
	.hps_0_hps_io_hps_io_usb1_inst_D0(HPS_USB_DATA[0]),          //                               .hps_io_usb1_inst_D0
	.hps_0_hps_io_hps_io_usb1_inst_D1(HPS_USB_DATA[1]),          //                               .hps_io_usb1_inst_D1
	.hps_0_hps_io_hps_io_usb1_inst_D2(HPS_USB_DATA[2]),          //                               .hps_io_usb1_inst_D2
	.hps_0_hps_io_hps_io_usb1_inst_D3(HPS_USB_DATA[3]),          //                               .hps_io_usb1_inst_D3
	.hps_0_hps_io_hps_io_usb1_inst_D4(HPS_USB_DATA[4]),          //                               .hps_io_usb1_inst_D4
	.hps_0_hps_io_hps_io_usb1_inst_D5(HPS_USB_DATA[5]),          //                               .hps_io_usb1_inst_D5
	.hps_0_hps_io_hps_io_usb1_inst_D6(HPS_USB_DATA[6]),          //                               .hps_io_usb1_inst_D6
	.hps_0_hps_io_hps_io_usb1_inst_D7(HPS_USB_DATA[7]),          //                               .hps_io_usb1_inst_D7
	.hps_0_hps_io_hps_io_usb1_inst_CLK(HPS_USB_CLKOUT),          //                               .hps_io_usb1_inst_CLK
	.hps_0_hps_io_hps_io_usb1_inst_STP(HPS_USB_STP),             //                               .hps_io_usb1_inst_STP
	.hps_0_hps_io_hps_io_usb1_inst_DIR(HPS_USB_DIR),             //                               .hps_io_usb1_inst_DIR
	.hps_0_hps_io_hps_io_usb1_inst_NXT(HPS_USB_NXT),             //                               .hps_io_usb1_inst_NXT

	//HPS SPI
	.hps_0_hps_io_hps_io_spim1_inst_CLK(HPS_SPIM_CLK),           //                               .hps_io_spim1_inst_CLK
	.hps_0_hps_io_hps_io_spim1_inst_MOSI(HPS_SPIM_MOSI),         //                               .hps_io_spim1_inst_MOSI
	.hps_0_hps_io_hps_io_spim1_inst_MISO(HPS_SPIM_MISO),         //                               .hps_io_spim1_inst_MISO
	.hps_0_hps_io_hps_io_spim1_inst_SS0(HPS_SPIM_SS),            //                               .hps_io_spim1_inst_SS0

	//HPS UART
	.hps_0_hps_io_hps_io_uart0_inst_RX(HPS_UART_RX),             //                               .hps_io_uart0_inst_RX
	.hps_0_hps_io_hps_io_uart0_inst_TX(HPS_UART_TX),             //                               .hps_io_uart0_inst_TX

	//HPS I2C1
	.hps_0_hps_io_hps_io_i2c0_inst_SDA(HPS_I2C0_SDAT),           //                               .hps_io_i2c0_inst_SDA
	.hps_0_hps_io_hps_io_i2c0_inst_SCL(HPS_I2C0_SCLK),           //                               .hps_io_i2c0_inst_SCL

	//HPS I2C2
	.hps_0_hps_io_hps_io_i2c1_inst_SDA(HPS_I2C1_SDAT),           //                               .hps_io_i2c1_inst_SDA
	.hps_0_hps_io_hps_io_i2c1_inst_SCL(HPS_I2C1_SCLK),           //                               .hps_io_i2c1_inst_SCL

	//GPIO
	.hps_0_hps_io_hps_io_gpio_inst_GPIO09(HPS_CONV_USB_N),       //                               .hps_io_gpio_inst_GPIO09
	.hps_0_hps_io_hps_io_gpio_inst_GPIO35(HPS_ENET_INT_N),       //                               .hps_io_gpio_inst_GPIO35
	.hps_0_hps_io_hps_io_gpio_inst_GPIO40(HPS_LTC_GPIO),         //                               .hps_io_gpio_inst_GPIO40
	.hps_0_hps_io_hps_io_gpio_inst_GPIO53(HPS_LED),              //                               .hps_io_gpio_inst_GPIO53
	.hps_0_hps_io_hps_io_gpio_inst_GPIO54(HPS_KEY),              //                               .hps_io_gpio_inst_GPIO54
	.hps_0_hps_io_hps_io_gpio_inst_GPIO61(HPS_GSENSOR_INT),      //                               .hps_io_gpio_inst_GPIO61

	//HPS ddr3
	.memory_mem_a(HPS_DDR3_ADDR),                                //                         memory.mem_a
	.memory_mem_ba(HPS_DDR3_BA),                                 //                               .mem_ba
	.memory_mem_ck(HPS_DDR3_CK_P),                               //                               .mem_ck
	.memory_mem_ck_n(HPS_DDR3_CK_N),                             //                               .mem_ck_n
	.memory_mem_cke(HPS_DDR3_CKE),                               //                               .mem_cke
	.memory_mem_cs_n(HPS_DDR3_CS_N),                             //                               .mem_cs_n
	.memory_mem_ras_n(HPS_DDR3_RAS_N),                           //                               .mem_ras_n
	.memory_mem_cas_n(HPS_DDR3_CAS_N),                           //                               .mem_cas_n
	.memory_mem_we_n(HPS_DDR3_WE_N),                             //                               .mem_we_n
	.memory_mem_reset_n(HPS_DDR3_RESET_N),                       //                               .mem_reset_n
	.memory_mem_dq(HPS_DDR3_DQ),                                 //                               .mem_dq
	.memory_mem_dqs(HPS_DDR3_DQS_P),                             //                               .mem_dqs
	.memory_mem_dqs_n(HPS_DDR3_DQS_N),                           //                               .mem_dqs_n
	.memory_mem_odt(HPS_DDR3_ODT),                               //                               .mem_odt
	.memory_mem_dm(HPS_DDR3_DM),                                 //                               .mem_dm
	.memory_oct_rzqin(HPS_DDR3_RZQ),                             //                               .oct_rzqin

	//FPGA Partion
	.led_pio_external_connection_export(fpga_led_internal),      //    led_pio_external_connection.export
	.dipsw_pio_external_connection_export(SW),                   //  dipsw_pio_external_connection.export
	.button_pio_external_connection_export(fpga_debounced_buttons),

	.temp0_external_connection_export      (temp1),         //         temp0_external_connection.export
	.temp1_external_connection_export      (temp2),         //         temp1_external_connection.export
	.temp_bed_external_connection_export   (temp_bed),      //      temp_bed_external_connection.export

	.endstops_external_connection_export   (end_stop),   //   endstops_external_connection.export
	.fans_external_connection_export       (fans),       //       fans_external_connection.export

	.stepper_4_speed_external_connection_export 			 (stepper_4_speed),  // stepper_4_speed_external_connection
	.stepper_3_speed_external_connection_export 			 (stepper_3_speed),  // stepper_3_speed_external_connection
	.stepper_2_speed_external_connection_export			 (stepper_2_speed),  // stepper_2_speed_external_connection	
	.stepper_1_speed_external_connection_export 			 (stepper_1_speed),  // stepper_1_speed_external_connection	
	
	.stepper_4_steps_out_external_connection_export (stepper_4_step_out), // stepper_4_steps_out_external_connection.export
	.stepper_3_steps_out_external_connection_export (stepper_3_step_out), // stepper_3_steps_out_external_connection.export
	.stepper_2_steps_out_external_connection_export (stepper_2_step_out), // stepper_2_steps_out_external_connection.export
	.stepper_1_steps_out_external_connection_export (stepper_1_step_out), // stepper_1_steps_out_external_connection.export
	
	.stepper_1_steps_in_external_connection_export  (stepper_1_step_in),  //  stepper_1_steps_in_external_connection.export
	.stepper_2_steps_in_external_connection_export  (stepper_2_step_in),  //  stepper_2_steps_in_external_connection.export
	.stepper_3_steps_in_external_connection_export  (stepper_3_step_in),  //  stepper_3_steps_in_external_connection.export
	.stepper_4_steps_in_external_connection_export  (stepper_4_step_in),   //  stepper_4_steps_in_external_connection.export
	
	.flags_out_external_connection_export           (flags_out),           //           flags_out_external_connection.export
   .flags_in_external_connection_export            (flags_in),            //            flags_in_external_connection.export
	
	.configuration_1_external_connection_export		(configuration_1),
	
	.temp_bed_bottom_external_connection_export     (temp_bed_bottom),     //     temp_bed_bottom_external_connection.export
   .temp_bed_upper_external_connection_export      (temp_bed_upper),      //      temp_bed_upper_external_connection.export
   .temp_e1_bottom_external_connection_export      (temp_e1_bottom),      //      temp_e1_bottom_external_connection.export
   .temp_e1_upper_external_connection_export       (temp_e1_upper)        //       temp_e1_upper_external_connection.export
);

//=======================================================  
stepper_controller stepper_controller1(
														.clk(CLK_1), 
														.stepper_step_in_1(((-1)*configuration_1[6])*stepper_1_step_out + (1 - configuration_1[6])*stepper_1_step_out),						
														.stepper_speed_1(stepper_1_speed),
														.stepper_step_in_2(((-1)*configuration_1[7])*stepper_2_step_out + (1 - configuration_1[7])*stepper_2_step_out),						
														.stepper_speed_2(stepper_2_speed),
														.stepper_step_in_3(((-1)*configuration_1[8])*stepper_3_step_out + (1 - configuration_1[8])*stepper_3_step_out),						
														.stepper_speed_3(stepper_3_speed),
														.stepper_step_in_4(((-1)*configuration_1[9])*stepper_4_step_out + (1 - configuration_1[9])*stepper_4_step_out),						
														.stepper_speed_4(stepper_4_speed),
														.stepper_enable(flags_read[0]),
														.xmin(end_stop[0]),
														.xmax(end_stop[1]),
														.ymin(end_stop[2]),
														.ymax(end_stop[3]),
														.zmin(end_stop[4]),
														.zmax(end_stop[5]),
														.homex(flags_read[2]),
														.homey(flags_read[3]),
														.homez(flags_read[4]),
														.start_driving(flags_read[1]),
														.start_homing(flags_read[5]),
														
														
														.step_signal_1(stepper1[1]),
														.enable_1(stepper1[0]),
														.dir_1(stepper1[2]),
														
														.step_signal_2(stepper2[1]),
														.enable_2(stepper2[0]),
														.dir_2(stepper2[2]),
														
														.step_signal_3(stepper3[1]),
														.enable_3(stepper3[0]),
														.dir_3(stepper3[2]),
														
														.step_signal_4(stepper4[1]),
														.enable_4(stepper4[0]),
														.dir_4(stepper4[2]),
														
														.steppers_driving(flags_in[0]),
														
														.stepper_step_out_1(stepper_1_step_in),
														.stepper_step_out_2(stepper_2_step_in),
														.stepper_step_out_3(stepper_3_step_in),
														.stepper_step_out_4(stepper_4_step_in));
						
						

heater_control heater_bed_control(  .clk(CLK_1),
												.temp(temp_bed),
												.temp_bottom(temp_bed_bottom),
												.temp_upper(temp_bed_upper),
												.control(flags_read[7:6]),
												.enable_heater(heater_bed));
												
heater_control heater_e1_control(  .clk(CLK_1),
												.temp(temp1),
												.temp_bottom(temp_e1_bottom),
												.temp_upper(temp_e1_upper),
												.control(flags_read[9:8]),
												.enable_heater(heater_e1));
						
always @(posedge FPGA_CLK1_50)
begin
	flags_read = flags_out;
end

// Debounce logic to clean out glitches within 1ms
debounce debounce_inst(
             .clk(fpga_clk_50),
             .reset_n(hps_fpga_reset_n),
             .data_in(KEY),
             .data_out(fpga_debounced_buttons)
         );
defparam debounce_inst.WIDTH = 2;
defparam debounce_inst.POLARITY = "LOW";
defparam debounce_inst.TIMEOUT = 50000;               // at 50Mhz this is a debounce time of 1ms
defparam debounce_inst.TIMEOUT_WIDTH = 16;            // ceil(log2(TIMEOUT))

// Source/Probe megawizard instance
hps_reset hps_reset_inst(
              .source_clk(fpga_clk_50),
              .source(hps_reset_req)
          );

altera_edge_detector pulse_cold_reset(
                         .clk(fpga_clk_50),
                         .rst_n(hps_fpga_reset_n),
                         .signal_in(hps_reset_req[0]),
                         .pulse_out(hps_cold_reset)
                     );
defparam pulse_cold_reset.PULSE_EXT = 6;
defparam pulse_cold_reset.EDGE_TYPE = 1;
defparam pulse_cold_reset.IGNORE_RST_WHILE_BUSY = 1;

altera_edge_detector pulse_warm_reset(
                         .clk(fpga_clk_50),
                         .rst_n(hps_fpga_reset_n),
                         .signal_in(hps_reset_req[1]),
                         .pulse_out(hps_warm_reset)
                     );
defparam pulse_warm_reset.PULSE_EXT = 2;
defparam pulse_warm_reset.EDGE_TYPE = 1;
defparam pulse_warm_reset.IGNORE_RST_WHILE_BUSY = 1;

altera_edge_detector pulse_debug_reset(
                         .clk(fpga_clk_50),
                         .rst_n(hps_fpga_reset_n),
                         .signal_in(hps_reset_req[2]),
                         .pulse_out(hps_debug_reset)
                     );
defparam pulse_debug_reset.PULSE_EXT = 32;
defparam pulse_debug_reset.EDGE_TYPE = 1;
defparam pulse_debug_reset.IGNORE_RST_WHILE_BUSY = 1;

reg [25: 0] counter;
reg led_level;
always @(posedge fpga_clk_50 or negedge hps_fpga_reset_n) begin
    if (~hps_fpga_reset_n) begin
        counter <= 0;
        led_level <= 0;
    end

    else if (counter == 24999999) begin
        counter <= 0;
        led_level <= ~led_level;
    end
    else
        counter <= counter + 1'b1;
end

assign LED[0] = led_level;


endmodule
