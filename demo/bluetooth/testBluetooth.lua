--- 模块功能：蓝牙功能测试
-- @author openLuat
-- @module bluetooth.testBluetooth
-- @license MIT
-- @copyright openLuat
-- @release 2020.09.27
-- @注意 需要使用core(Luat_VXXXX_RDA8910_BT_FLOAT)版本
module(...,package.seeall)

local bt_test = {}

local function init()
	log.info("bt", "init")
	rtos.on(rtos.MSG_BLUETOOTH,function(msg)
		if msg.event == btcore.MSG_OPEN_CNF then
			sys.publish("BT_OPEN", msg.result)
		elseif msg.event == btcore.MSG_BLE_CONNECT_CNF then
			log.info("bluetooth.msg",msg.info)
		elseif msg.event == btcore.MSG_BLE_CONNECT_IND then
			sys.publish("BT_CONNECT_IND", msg.result)
		elseif msg.event == btcore.MSG_BLE_DATA_IND then 
			sys.publish("BT_DATA_IND", msg.data)
		elseif msg.event == btcore.MSG_BLE_SCAN_CNF then
			sys.publish("BT_SCAN_CNF", msg.result)
		elseif msg.event == btcore.MSG_BLE_SCAN_IND  then
			sys.publish("BT_SCAN_IND", {["name"]=msg.name, ["addr_type"]=msg.addr_type, ["addr"]=msg.addr})
		end
	end)
end
local function poweron()
	log.log.info("bt",  "poweron")
	btcore.open()
	_, result = sys.waitUntil("BT_OPEN", 5000)
end
local function scan()
	log.info("bt", "scan")
	btcore.scan(1)
	sys.timerStart(
		function ()
			sys.publish("BT_SCAN_IND", nil)
		end, 
		10000)
		_, result = sys.waitUntil("BT_SCAN_CNF", 50000)
		if result ~= 0 then
			return false
		end
	while true do
		_, bt_device = sys.waitUntil("BT_SCAN_IND")
		if not bt_device then
			-- 超时结束
			btcore.scan(0)
			return false
		else
			log.info("bt", "scan result")
			log.info("bt.scan",bt_device.name)
			log.info("bt.scan",bt_device.addr_type)
			log.info("bt.scan",bt_device.addr)
		end
	end
	return true
end

local function advertising()
	log.info("bt","advertising")
	btcore.setname("Luat_Air724UG")				-- 设置广播名称
	btcore.setadvdata("04ff010203")  -- 设置广播数据04 代表 这个字段的长度，ff 代表厂商信息标志，010203 厂商信息
	btcore.advertising(1)				-- 打开广播
end

local function data_trans()
	log.info("bt","data transparent")
	advertising()
	_, result = sys.waitUntil("BT_CONNECT_IND")
	if result ~= 0 then
		return false
	end

	--链接成功
	sys.wait(1000)
	log.info("bt.send", "Hello I'm Luat BLE")
	btcore.send("Hello I'm Luat BLE")
	while true do
		_, data = sys.waitUntil("BT_DATA_IND")
		log.info("bt.recv", data)
		btcore.send(data)
	end
end

ble_test = {init, poweron, scan, data_trans}

sys.taskInit(function()
	for _,f in ipairs(ble_test) do
		f()
	end
end)

