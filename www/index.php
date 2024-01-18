<?php
echo '<h2>Folders</h2>';
$scan = scandir('/var/www/html');

echo '<ul>';
foreach($scan as $file) {
   if (!is_dir("/".$file) && $file != "index.php") {
      echo '<li><a href="'.$file.'">'.$file.'</a></li>';
   }
}
echo '</ul>';
