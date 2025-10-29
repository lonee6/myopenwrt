#!/bin/sh

# 目标接口（通常是 wan）
IFACE="wan"
# 记录上次 IP 的文件
IPFILE="/tmp/last_wan_ip"

# 获取当前 IP
get_ip() {
    ubus call network.interface.$IFACE status | jsonfilter -e '@["ipv4-address"][0].address'
}

# 强制重连
reconnect() {
    echo "正在重连 PPPoE..."
    ifdown $IFACE
    sleep 3
    ifup $IFACE
    sleep 8  # 等待拨号完成
}

# 读取旧 IP（如果有）
[ -f "$IPFILE" ] && OLDIP=$(cat "$IPFILE") || OLDIP=""

while true; do
    NEWIP=$(get_ip)

    if [ -z "$NEWIP" ]; then
        echo "未获取到 IP，重试..."
        reconnect
        continue
    fi

    # 如果还没有旧 IP（第一次运行），就强制要求再拨一次
    if [ -z "$OLDIP" ]; then
        echo "首次运行，已获取 IP: $NEWIP，尝试换新 IP..."
        OLDIP="$NEWIP"
        reconnect
        continue
    fi

    if [ "$NEWIP" != "$OLDIP" ]; then
        echo "获取到新 IP: $NEWIP"
        echo "$NEWIP" > "$IPFILE"
        exit 0
    fi

    echo "IP 相同 ($NEWIP)，重新拨号..."
    reconnect
done
