
#!/bin/sh

#取wan口IP前三位

#做50次拨号循环，50次如果都没拨上也停止
for i in `seq 5000`;
do 
IP=$(ifconfig pppoe-wan 2> /dev/null | grep 'inet addr' | awk '{print $2}' | cut -d: -f2)
#获取wan口ip
IPP=${IP:0:7}
echo $IP
if [ "$IPP" != "221.205" ]; then
#如果IP开头是100的话，重拨
  ifdown wan | sleep 9s|ifup wan 
else 
  echo $IP
  break
#否则保留IP，跳出循环
fi

done