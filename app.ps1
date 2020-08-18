$result=az ad app create --display-name 'test2'
$new =(echo $result | jq .appId -r)
$result2=az ad app credential reset --id $new --append
$appid=(echo $result2 | jq .appId -r)
$apppass=(echo $result2 | jq .password -r)
echo $appid
