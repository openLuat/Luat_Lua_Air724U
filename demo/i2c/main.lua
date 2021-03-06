--必须在这个位置定义PROJECT和VERSION变量
--PROJECT：ascii string类型，可以随便定义，只要不使用,就行
--VERSION：ascii string类型，如果使用Luat物联云平台固件升级的功能，必须按照"X.X.X"定义，X表示1位数字；否则可随便定义
PROJECT = "I2C"
VERSION = "2.0.0"
PRODUCT_KEY = "v32xEAKsGTIEQxtqgwCldp5aPlcnPs3K"
-- 日志级别
require "log"
LOG_LEVEL = log.LOGLEVEL_TRACE
require "sys"
require "utils"
require "patch"
require "pins"
-- 加载GSM
require "net"
--8秒后查询第一次csq
net.startQueryAll(8 * 1000, 600 * 1000)
-- 控制台
require "console"
console.setup(2, 115200)

--加载网络指示灯和LTE指示灯功能模块
--根据自己的项目需求和硬件配置决定：1、是否加载此功能模块；2、配置指示灯引脚
--合宙官方出售的Air720U开发板上的网络指示灯引脚为pio.P0_1，LTE指示灯引脚为pio.P0_4
require "netLed"
pmd.ldoset(2,pmd.LDO_VLCD)
netLed.setup(true,pio.P0_1,pio.P0_4)
--网络指示灯功能模块中，默认配置了各种工作状态下指示灯的闪烁规律，参考netLed.lua中ledBlinkTime配置的默认值
--如果默认值满足不了需求，此处调用netLed.updateBlinkTime去配置闪烁时长
--LTE指示灯功能模块中，配置的是注册上4G网络，灯就常亮，其余任何状态灯都会熄灭

-- 系统工具
require "misc"
require "errDump"

-- 系統指示灯
--require "i2c_ssd1306_lcd"
--require "mpu6xxx"
require"AHT10"
require "ntp"
ntp.timeSync(1, function()log.info("----------------> AutoTimeSync is Done ! <----------------") end)
-- 启动系统框架
sys.init(0, 0)
sys.run()
