# Copyright (c) 2018-2019 The Ion developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

# replace Ion chainparamsseeds.h
# Requirements:
#  - 1. RUN THIS SCRIPT FROM ION (Coins) ROOT FOLDER
#  - 2. File contrib/seeds/generate-seeds.py MUST BE PRESENT
#       Check requirements for usage of generate-seeds.py
#       for your operating system.

wget -O contrib/seeds/nodes_main.json https://chainz.cryptoid.info/ion/api.dws?q=nodes
awk -F ':[ \t]*' '/^.*"nodes"/ {print $5 $9 $13 $17 $21 $25 $29 $33 $37 $41}' contrib/seeds/nodes_main.json > contrib/seeds/nodes_main.txt
rm -f contrib/seeds/nodes_main.json
sed -i 's/,{\"subver\"/\\\n/g' contrib/seeds/nodes_main.txt
sed -i 's/\[\"//g' contrib/seeds/nodes_main.txt
sed -i 's/\",\"/:12700\\\n/g' contrib/seeds/nodes_main.txt
sed -i 's/\"]}]//g' contrib/seeds/nodes_main.txt
sed -i 's/\"]}/:12700/g' contrib/seeds/nodes_main.txt
sed -i 's/\\//g' contrib/seeds/nodes_main.txt
touch ./contrib/seeds/nodes_test.txt
tee ./contrib/seeds/nodes_test.txt <<EOF
45.76.251.109:27170
149.28.13.221:27170
95.216.169.139:27170
76.20.70.162:27170
35.227.124.168:27170
50.254.113.130:60040
99.76.20.33:3460
13.211.229.87:50862
99.76.20.33:2511
99.76.20.33:9660
35.237.23.28:37548
99.76.20.33:40526
67.215.244.186:49856
34.73.86.245:27170
199.247.15.235:27170
149.248.59.142:27170
140.82.26.131:27170
45.63.89.41:27170
202.182.121.198:27170
149.28.13.221:27170
185.107.224.197:39020
45.77.215.23:27170
51.15.95.171:27170
104.238.167.129:27170
108.61.132.189:27170
73.115.9.124:35142
149.28.101.87:37834
EOF

cd contrib/seeds
python3 generate-seeds.py . > ../../src/chainparamsseeds.h
rm -f ./nodes_main.txt
rm -f ./nodes_test.txt
cd ../..
cat < ./src/chainparamsseeds.h

