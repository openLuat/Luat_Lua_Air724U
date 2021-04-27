## 一、介绍
CORE固件是C语言编写的Lua虚拟机运行环境，基于官方的Lua5.1版本，增加了大量符合蜂窝通信模组的新特性。CORE固件可以有如下两种获取方式：
## 二、如何获取CORE固件
CORE固件通过合宙官方发布，官方会不定期维护更新。
### 2.1，使用官方发布的固件
* release版本
    - [参考Luat版本发布说明](https://doc.openluat.com/article/1334)

* beta版本
    - [Luat_V3032_RDA8910_TTS_NOVOLTE_FLOAT](http://openluat-erp.oss-cn-hangzhou.aliyuncs.com/erp_site_file/product_file/[%E9%9D%9E%E9%87%8F%E4%BA%A7%E7%89%88%E6%9C%AC]sw_file_20210426213144_Luat_V3032_RDA8910_TTS_NOVOLTE_FLOAT.zip)
    - [Luat_V3032_RDA8910_TTS_NOLVGL_FLOAT](http://openluat-erp.oss-cn-hangzhou.aliyuncs.com/erp_site_file/product_file/[%E9%9D%9E%E9%87%8F%E4%BA%A7%E7%89%88%E6%9C%AC]sw_file_20210426213048_Luat_V3032_RDA8910_TTS_NOLVGL_FLOAT.zip)
    - 修改说明:
        * add feature #4760 【问题描述】:流播放接口audiocore.streamplay添加对端播放的功能
        * Fix Bug #4686 【问题描述】:解决rtmp服务器主动断开，无消息上报
        * Fix Bug #4677 【问题描述】:解决摄像头拍照导致lua看门狗重启问题
        * Fix Bug #4509 【问题描述】:解决POC项目， 途聆平台 凯利项目 cp死机的问题
        * Fix Bug #4393 【问题描述】:解决微信通反馈掉线问题 openatSocketEvtInd err 13 socket 0 send evt= 4,len=0错误的问题
        * Fix Bug #0  【问题描述】:解决SIM1 无法休眠的问题
        * Fix Bug #0  【问题描述】:解决校准 出现 2G ILOSS的问题


### 2.2，根据功能要求，在线定制固件
在线定制固件是根据`CORE`已经支持的功能列表，按照客户产品功能需求进行在线固件定制，在线定制最大限度的保持了lua运行的空间，理论上和官方发布的固件一样稳定，而且和官方固件一样支持更新和FOTA升级，具体介绍和使用参考[可选编译使用说明。](https://doc.openluat.com/article/2728)

## 三、下载固件
下载固件通过Luatools工具，选择不同途径获取的文件，解压后选择`.pac`文件，再选择对应的lua脚本进行下载。[具体步骤，参考Luatools使用手册](https://doc.openluat.com/wiki/3?wiki_page_id=701)