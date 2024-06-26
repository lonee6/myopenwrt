#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (Aftefeeds/packages/net/mosdns/Makefiler Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate
#git reset --hard e0b8803b714dc1a50334332ee7cc4c5aeda028a5
#sed -i 's/luci-lib-ipkg/luci-base/g' package/feeds/helloworld/luci-app-ssr-plus/Makefile
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
#sed -i 's/CGO_ENABLED=0/CGO_ENABLED=1/g' feeds/packages/net/mosdns/Makefile
