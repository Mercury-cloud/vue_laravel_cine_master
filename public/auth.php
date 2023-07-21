<?PHP
header('Content-Length: video/mp4');
header('Content-Type: video/mp4');
header('Content-Disposition: filename="S01E01.mp4"');
$url = 'https://drive.google.com/file/d/1-0Em3B8C-kzurzg7inbNIm_3Yizo4aTA/view';
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,$url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER,false);
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
$result = curl_exec($ch);
curl_close($ch);  
?>
