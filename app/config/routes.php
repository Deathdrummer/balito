<? defined('BASEPATH') OR exit('Доступ к скрипту запрещен');

$controller = reset($this->uri->segments);

//$noRoutes = array_unique(array_merge(['favicon.ico', 'log', 'admin', 'accounts', 'filemanager', 'formorder'], (config_item('noroutes_controllers') ?: [])));
$noRoutes = array_unique(array_merge(['log', 'admin', 'filemanager', 'cron'], (config_item('noroutes_controllers') ?: [])));


$route['default_controller'] = 'site/render';
$route['404_override'] = 'site/error';
$route['translate_uri_dashes'] = false;

if (!in_array($controller, $noRoutes)) $route['([a-z 0-9~%.:_\-\/]+)'] = 'site/render/'.implode('/', $this->uri->segments);