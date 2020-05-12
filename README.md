  DNSCrypt安装-卸载工具
  ===================
  
  DNSCrypt是一个确保客户与DNS服务器之间传输安全的工具，基于DNSCurve修改而来

官方地址：http://dnscrypt.org/

项目维护jedisct1托管在GitHub上页-主题由mattgraham

    由于Domain Nam System(DNS)设计上的缺陷，用户在浏览器里输入一些被封的网址以后，如果遭遇MITM或者DNS污染，浏览器可能接收到错误的IP，
    
    而 存在安全问题。为了解决一些这样安全上的问题，IETF在十几年前便开始制定DNS的安全扩展（DNSSEC）。利用公开键机密技术，通过对DNS数据进 
    
    行电子签名，DNSSEC能够验证DNS数据来源和验证在传输过程中DNS是否被篡改。

    但是DNSSEC不保证DNS数据的机密性，DNS数据本身并没有被加密，加之DNS的 阶层式模式，这便为一些机构提供监视，控制网络的手段。
    
    典型的例子就是不能访问一些海外的网站。DNSSEC也不提供免于DOS(Deny of Service)攻击的办法，由于电子签名和签名验证需要格外的数据运算，
    
    DNSSEC反而更容易受到DOS攻击。

    DNSCurve相对于DNSSEC的好处是，DNSCurve使用了更有效率的椭圆曲线加密算法而可以负担的起每条查询都单独加密，从而更加安全。

    DNSCrypt协议是非常类似DNSCurve的，作为一个DNS代理运行，侧重于客户端和第一级DNS服务器之间的通信安全，能够缓存DNS解析。

    首先下载对应平台的dnscrypt client然后运行，接着修改本地或者router的dns server为127.0.0.1. 然后你的所有dns请求都会加密进行从而绕过
    
    GFW的dns污染顺利解析到正确IP。

下载：
DNSCrypt可以在这里下载：http://dnscrypt.org/dnscrypt-proxy/downloads/

解压缩后，运行dnscrypt-proxy.exe，不要退出程序，将本机DNS指向127.0.0.1即可使用

如果想让它作为一个系统服务，在Windows平台中安装为一个系统服务的方法：

复制dnscrypt-proxy.exe,以及相关的libsodium-4.dll文件到本机，打开终端或者系统自带命令行，键入命令（需要完整的路径，这里仅供参考，

也可以尝试用修改快捷方式的方法附带参数）：

dnscrypt-proxy.exe --install

这样系统中就增加了一项名为dnscrypt-proxy的服务；

服务卸载方法（需要完整的路径，这里仅供参考，也可以尝试用修改快捷方式的方法附带参数）：

dnscrypt-proxy.exe --uninstall

更多详细说明，请拜读位于github的项目主页

DNSCrypt-proxy 是一个对 DNSCurve 的轻微修改版，DNSCurve 站点：http://www.dnscurve.org/
