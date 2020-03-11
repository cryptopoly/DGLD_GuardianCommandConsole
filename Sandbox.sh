
# Output json from URL Edited
curl -s https://s3.eu-west-1.amazonaws.com/gtsa-mapping/map.json |\
	jq '.'


# Output full json
jq '.' ./map.json


# Output 1st Level
jq '.n' /map.json
#2


# Output 1st Level Values
jq '.n,.m,.height' /map.json
#2
#3
#3303


# Output just data under assets
jq '.assets' /map.json


# Output just data under assets excluding bar number
jq '.[] | .' /map.json




# Example json
{
  "n": 2,
  "m": 3,
  "assets": {
    "1": {
      "ref": "031037-2019-PAMP",
      "mass": 389.142,
      "tokenid": "322b36709d8c74c3225e943faa14c6abda1e6d8dc479a46cd8e24c1409eba3eb"
    },
    "2": {
      "ref": "030727-2019-PAMP",
      "mass": 405.92,
      "tokenid": "50e4a961ace0d39646801b299ae37da9d1538529252edad38c4da77cd826cc6f"
    },
    "3": {
      "ref": "035696-2019-PAMP",
      "mass": 401.337,
      "tokenid": "60a62454afc1e2a68c242b0d4cfe4b57ad2c6bd68c57016fa9f3b1579c520351"
    },
    "4": {
      "ref": "035697-2019-PAMP",
      "mass": 409.359,
      "tokenid": "fcb3c3e863190fc982f6b74f89cedf089d9df32a8f8962e3314f506858e15fad"
    }
  },
  "sigs": {
    "2": "HIQ/SqrSd0EcWz8HzYOYuDdqMGM54JcUYgEQqVhhYoInSUpTNtvIik1FUHZjG8EecXp0pX5zpMFL4rg8lz675Yc=",
    "1": "G1yyYlKOZKeqgGv/jaKbjFIJbBYcA/jdMsJzOlWpGj0RCtU0+3s1i8jsgVO3lQFbQtm/uAKY4mvoG87tD0BH1LA="
  },
  "time": 1568906123.897163,
  "height": 3303
}

