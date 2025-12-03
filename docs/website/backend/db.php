<?php
class SnippetDB {
    private $db;
    
    function __construct() {
        $db_path = __DIR__ . '/../../../../shared/data/snippets.db';
        
        // Create directory if it doesn't exist
        $dir = dirname($db_path);
        if (!is_dir($dir)) {
            mkdir($dir, 0775, true);
        }
        
        $this->db = new SQLite3($db_path);
        
        // Create table if not exists
        $this->db->exec('
            CREATE TABLE IF NOT EXISTS snippets (
                id TEXT PRIMARY KEY,
                code TEXT NOT NULL,
                created_at INTEGER DEFAULT (strftime("%s", "now")),
                last_accessed INTEGER DEFAULT (strftime("%s", "now")),
                execution_count INTEGER DEFAULT 1
            )
        ');
    }
    
    function generateUniqueId($length = 6) {
        $chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $max_attempts = 10;
        
        for ($attempt = 0; $attempt < $max_attempts; $attempt++) {
            $id = '';
            for ($i = 0; $i < $length; $i++) {
                $id .= $chars[random_int(0, 61)];
            }
            
            // Check if ID already exists
            if (!$this->exists($id)) {
                return $id;
            }
        }
        
        // If we couldn't find a unique ID in 10 attempts, try with one more character
        return $this->generateUniqueId($length + 1);
    }
    
    function exists($id) {
        $stmt = $this->db->prepare('SELECT 1 FROM snippets WHERE id = :id LIMIT 1');
        $stmt->bindValue(':id', $id, SQLITE3_TEXT);
        $result = $stmt->execute();
        return $result->fetchArray() !== false;
    }
    
    function save($id, $code) {
        $stmt = $this->db->prepare('
            INSERT INTO snippets (id, code) VALUES (:id, :code)
            ON CONFLICT(id) DO UPDATE SET 
                code = :code,
                last_accessed = strftime("%s", "now"),
                execution_count = execution_count + 1
        ');
        $stmt->bindValue(':id', $id, SQLITE3_TEXT);
        $stmt->bindValue(':code', $code, SQLITE3_TEXT);
        return $stmt->execute();
    }
    
    function get($id) {
        // Update last_accessed when retrieving
        $update = $this->db->prepare('
            UPDATE snippets SET last_accessed = strftime("%s", "now") 
            WHERE id = :id
        ');
        $update->bindValue(':id', $id, SQLITE3_TEXT);
        $update->execute();
        
        // Get the code
        $stmt = $this->db->prepare('SELECT code FROM snippets WHERE id = :id');
        $stmt->bindValue(':id', $id, SQLITE3_TEXT);
        $result = $stmt->execute();
        $row = $result->fetchArray(SQLITE3_ASSOC);
        return $row ? $row['code'] : null;
    }
    
    function cleanup() {
        // Delete snippets not accessed in 2 years
        $this->db->exec('DELETE FROM snippets WHERE last_accessed < strftime("%s", "now", "-2 years")');
        $this->db->exec('VACUUM');
    }
}
?>