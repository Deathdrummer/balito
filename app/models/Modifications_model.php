<? defined('BASEPATH') OR exit('Доступ к скрипту запрещен');

class Modifications_model extends MY_model {
	
	private $modificationsFile;
	
	public function __construct() {
		parent::__construct();
		$this->modificationsFile = $this->config->item('modifications_file');
	}
	
	
	/**
	 * @param 
	 * @return 
	 */
	public function getModifications($id = false) {
		$data = $this->_readFile();
		if ($id === false) return $data;
		return $data[$id] ?: false;
	}
	
	
	
	
	/**
	 * @param 
	 * @return 
	 */
	public function getModificationsNames($id = false) {
		$fileData = $this->_readFile();
		if ($id !== false && isset($fileData[$id])) unset($fileData[$id]);
		
		if (!$fileData) return false;
		$data = [];
		foreach ($fileData as $item) {
			$data[$item['db_name']] = $item['title'];
		}
		return $data ?: false;
	}
	
	
	
	
	
	/**
	 * @param 
	 * @return 
	 */
	public function getModificationsLabels() {
		$fileData = $this->_readFile();
		if (!$fileData) return false;
		$currentMod = $this->input->cookie('site_modification');
		$data = [];
		foreach ($fileData as $item) {
			$data[] = [
				'modification' 	=> $item['db_name'],
				'label' 		=> $item['label'],
				'icon' 			=> $item['icon'] ? FILEMANAGERTHUMBS.$item['icon'] : null,
				'active'		=> $currentMod == $item['db_name'] ? true : false
			];
		}
		return $data ?: false;
	}
	
	
	
	
	
	
	/**
	 * @param 
	 * @return 
	 */
	public function save($post = false) {
		if (!$post) return false;
		$fileData = $this->_readFile();
		$id = $post['id'];
		if ($id === false) return false;
		unset($post['id']);
		
		$post = $this->_copyModification($post);
		
		$fileData[$id] = $post;
		$this->_writeFile($fileData);
		return true;
	}
	
	
	
	
	
	/**
	 * @param 
	 * @return 
	 */
	public function update($post = false) {
		if (!$post) return false;
		$fileData = $this->_readFile();
		$id = $post['id'];
		if ($id === false) return false;
		unset($post['id']);
		
		$post = $this->_copyModification($post, false);
		
		$fileData[$id] = $post;
		$this->_writeFile($fileData);
		return true;
	}
	
	
	
	
	
	/**
	 * @param 
	 * @return 
	 */
	public function remove($id = false) {
		if ($id === false) return false;
		$fileData = $this->_readFile();
		unset($fileData[$id]);
		$this->_writeFile($fileData);
		return true;
	}
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * @param 
	 * @return 
	 */
	private function _copyModification($post = false, $noCopyAction = true) {
		if (!$post) return false;
		
		if ((!isset($post['copy']) || !$post['copy']) && $noCopyAction == false) {
			unset($post['copy']);
			return $post;
		}
		
		$donorDb = isset($post['copy']) ? $post['copy'] : config_item('db_name');
		
		
		$this->load->dbutil();
		
		$this->db->db_select($donorDb);
		$backup = $this->dbutil->backup([
	        'format'		=> 'txt',
	        'add_drop'		=> false,
	        'add_insert'	=> (isset($post['copy']) && $post['copy']) ? true : false,
	        'newline'		=> "\n"
		]);
		
		$backup = str_replace('   ', ' ', preg_replace('/\n/', ' ', $backup));
		$backup = array_values(array_filter(preg_split('/CREATE/', $backup)));
		$this->db->db_select($post['db_name']);
		
		foreach ($backup as $item) {
			$createInsert = array_filter(preg_split('/INSERT INTO/', $item));
			$create = array_shift($createInsert);
			$this->db->simple_query('CREATE '.trim($create));
			if ($createInsert) {
				foreach ($createInsert as $item) {
					$this->db->simple_query('INSERT INTO '.trim($item));
				}
			}
		}
		$this->db->db_select($this->input->cookie('modification'));
		unset($post['copy']);
		return $post;
	}
	
	
	
	
	
	
	
	private function _readFile() {
		if (!file_exists(MODIFICATIONS_FILE)) return false;
		$fileData = json_decode(file_get_contents(MODIFICATIONS_FILE) ?: '', true);
		return $fileData ?: false;
	}
	
	
	
	private function _writeFile($data = false) {
		if ($data === false) return false;
		if (!file_exists(MODIFICATIONS_FILE)) return false;
		$dataToWrite = json_encode(arrBringTypes($data));
		$fp = fopen(MODIFICATIONS_FILE, "w");
    	fwrite($fp, $dataToWrite);
    	fclose($fp);
    	return true;
	}

}