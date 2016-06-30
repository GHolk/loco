<?php
header("content-Type: text/html; charset=utf-8"); //語言強制
$query_string=$_SERVER['QUERY_STRING'];
$phpself=basename($_SERVER["SCRIPT_FILENAME"]);//被執行的文件檔名
$phphost=$_SERVER["SERVER_NAME"];
date_default_timezone_set("Asia/Taipei");//時區設定 Etc/GMT+8
$time = time();
//$tim = $time.substr(microtime(),2,3);
$tim = microtime(true);

$url="./";
$handle=opendir($url); 
$cc = 0;

while(($file = readdir($handle))!==false) { 
	if(1) { 
		$tmp[0][$cc] = $file; 
		//$tmp[1][$cc] = filectime($file);
		if($file=="."||$file == ".."){
			$tmp[2][$cc] = "y";//系統功能的資料夾
		}else{
			if(is_dir($file)){$tmp[2][$cc] = "y";}else{$tmp[2][$cc] = "n";}
		}
		//$tmp[$cc] = substr($file,0,strpos($file,"."));
	} 
	$cc = $cc + 1;
} 
closedir($handle); 

//rsort($tmp);
array_multisort($tmp[0],$tmp[2],SORT_ASC, SORT_REGULAR);
$line = count($tmp[0]);


$httphead = <<<EOT
<html><head>
<title>$phphost</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Robots" content="noindex,follow">
<STYLE TYPE="text/css"><!--
body { font-family:"細明體",'MingLiU'; }
--></STYLE>
</head>
<body bgcolor="#FFFFEE" text="#800000" link="#0000EE" vlink="#0000EE">
EOT;

$httpend = "
</body></html>\n";


$u = "http://".$_SERVER["SERVER_NAME"]."".$_SERVER["PHP_SELF"]."";
//echo $u."<br>";
//$url2=substr($u,0,strrpos($u,"/")+1).$url;
//echo $url2."<br>";

$httpbody="";//echo
$date_now=date("y/m/d H:i:s", $time);
$httpbody.= "\n<dl><dd>".$date_now."</dd></dl>\n" ;

if($line>=1000){$line=1000;}else{$line=$line;}
$d='';
for($i = 0; $i < $line; $i++){//從頭
	$d='';
	if($tmp[2][$i]=="y"){
		$httpbody.= "<a href='./".$tmp[0][$i]."/'>".$tmp[0][$i]."</a>◆<br>\n";
	}else{
		$httpbody.= "<a href='./".$tmp[0][$i]."'>".$tmp[0][$i]."</a><br>\n";
	}
}//

$httpbody.= "\n<dl><dd>".$tim."</dd></dl>\n" ;

echo $httphead."\n" ;
echo $httpbody."\n" ;
echo $httpend."\n" ;



?>