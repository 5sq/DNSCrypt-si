cls&@echo off&color 2f
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
CD /D %~DP0

Set Prog=瓦斯曲 DNSCrypt安装-卸载工具
Set L1=　　　　　　　　　　╭───────────────╮
Set L2=　　　　　　         %Prog% 
Set L3=　　　　　　│　　　╰───────────────╯　　  │
Set L4=　　　　　　│==============================================│
Set L5=　　　　　　│注：运行后请重新启动计算机，保证配置生效！    │
Set L7=　　　　　　╰───────────────────────╯

:主菜单
cls&@echo off&color 2f
Title %Prog%_主菜单
Echo.
Echo %L2%
Echo %L4%
Echo             │                                              │
Echo 　　　　　　│　(1) 查看DNS配置  (看是否已安装、正确配置)   │
Echo             │                                              │
Echo 　　　　　　│　(2) 安装DNSCrypt服务                        │
Echo             │                                              │
Echo 　　　　　　│　(3) 卸载DNSCrypt服务　　　　　　　　　　　　│
Echo             │                                              │
Echo             │  (4) DNSCrypt说明                            │
Echo             │                                              │
Echo %L4%
Echo %L5%
Echo %L4%

echo.
SET /P psn=                请输入 ( ) 中的数字键并按回车:
if /I "%psn%"=="1" Call :状态 &echo.现在按任意键返回主菜单。&pause >nul&goto 主菜单
if /I "%psn%"=="2" net stop dnscrypt-proxy&Call :安装 &Call :状态 &echo.安装完成！按任意键退出。 &pause >nul &exit
if /I "%psn%"=="3" net stop dnscrypt-proxy&Call :卸载 &Call :状态 &echo.dnscrypt-proxy服务卸载完成！请按任意键退出。 &pause >nul &exit 
if /I "%psn%"=="4" cls&more +92 %~0 &pause&goto :主菜单

:返回
goto 主菜单


:状态
cls
color 0f
Title 当前DNS配置状态
echo =============================================
echo dnscrypt-proxy服务状态
echo =============================================
sc query dnscrypt-proxy
echo --------------------------------------------
pause
echo ipv4 show dnsservers
echo --------------------------------------------
netsh interface ipv4 show dnsservers
echo =============================================
goto :eof

:安装
cls
color 0b
Title %Prog%_安装dnscrypt-proxy服务
echo.正在安装dnscrypt-proxy服务...
dnscrypt-proxy.exe --install
echo.设置本地连接 DNS……
>xx.vbs echo strWinMgmt="winmgmts:{impersonationLevel=impersonate}":Set NICS = GetObject( strWinMgmt ).InstancesOf("Win32_NetworkAdapterConfiguration"):For Each NIC In NICS:If NIC.IPEnabled Then:NIC.SetDNSServerSearchOrder Array("127.0.0.1","114.114.114.114"):End If:Next
xx.vbs&&del /q xx.vbs
echo.刷新 DNS配置……
ipconfig /flushdns
Echo.
echo 请按任意键查看当前DNS配置状态 
pause >nul
goto :eof

:卸载
cls
color 0d
Title %Prog%_卸载dnscrypt-proxy服务...
echo.
echo.正在卸载dnscrypt-proxy服务...
dnscrypt-proxy.exe --uninstall
echo.设置本地连接 DNS……
>xx.vbs echo strWinMgmt="winmgmts:{impersonationLevel=impersonate}":Set NICS = GetObject( strWinMgmt ).InstancesOf("Win32_NetworkAdapterConfiguration"):For Each NIC In NICS:If NIC.IPEnabled Then:NIC.SetDNSServerSearchOrder Array("114.114.114.114","223.5.5.5"):End If:Next
xx.vbs&&del /q xx.vbs
echo.刷新 DNS配置……
ipconfig /flushdns
Echo.
echo 请按任意键查看当前DNS配置状态 
pause >nul
goto :eof


                 <空格键> 显示下一页   <回车键> 显示下一行
===============================================================================
  DNSCrypt是一个确保客户与DNS服务器之间传输安全的工具，基于DNSCurve修改而来
===============================================================================

官方地址：http://dnscrypt.org/

项目维护jedisct1托管在GitHub上页-主题由mattgraham

    由于Domain Nam System(DNS)设计上的缺陷，用户在浏览器里输入一些被封的网址以后，如果遭遇MITM或者DNS污染，浏览器可能接收到错误的IP，而 存在安全问题。为了解决一些这样安全上的问题，IETF在十几年前便开始制定DNS的安全扩展（DNSSEC）。利用公开键机密技术，通过对DNS数据进 行电子签名，DNSSEC能够验证DNS数据来源和验证在传输过程中DNS是否被篡改。

    但是DNSSEC不保证DNS数据的机密性，DNS数据本身并没有被加密，加之DNS的 阶层式模式，这便为一些机构提供监视，控制网络的手段。典型的例子就是不能访问一些海外的网站。DNSSEC也不提供免于DOS(Deny of Service)攻击的办法，由于电子签名和签名验证需要格外的数据运算，DNSSEC反而更容易受到DOS攻击。

    DNSCurve相对于DNSSEC的好处是，DNSCurve使用了更有效率的椭圆曲线加密算法而可以负担的起每条查询都单独加密，从而更加安全。

    DNSCrypt协议是非常类似DNSCurve的，作为一个DNS代理运行，侧重于客户端和第一级DNS服务器之间的通信安全，能够缓存DNS解析。

    首先下载对应平台的dnscrypt client然后运行，接着修改本地或者router的dns server为127.0.0.1. 然后你的所有dns请求都会加密进行从而绕过GFW的dns污染顺利解析到正确IP。

下载：
DNSCrypt可以在这里下载：http://dnscrypt.org/dnscrypt-proxy/downloads/

解压缩后，运行dnscrypt-proxy.exe，不要退出程序，将本机DNS指向127.0.0.1即可使用

如果想让它作为一个系统服务，在Windows平台中安装为一个系统服务的方法：

复制dnscrypt-proxy.exe,以及相关的libsodium-4.dll文件到本机，打开终端或者系统自带命令行，键入命令（需要完整的路径，这里仅供参考，也可以尝试用修改快捷方式的方法附带参数）：

dnscrypt-proxy.exe --install

这样系统中就增加了一项名为dnscrypt-proxy的服务；

服务卸载方法（需要完整的路径，这里仅供参考，也可以尝试用修改快捷方式的方法附带参数）：

dnscrypt-proxy.exe --uninstall

更多详细说明，请拜读位于github的项目主页

DNSCrypt-proxy 是一个对 DNSCurve 的轻微修改版，DNSCurve 站点：http://www.dnscurve.org/

