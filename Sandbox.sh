

# http://goldpricez.com api key
# 92736b6161440a1ecc886a4f42634f1892736b61

golprizes=$(curl -s http://goldpricez.com/api/rates/currency/usd/measure/ounce "X-API-KEY: 92736b6161440a1ecc886a4f42634f1892736b61")
echo $goldpricez
