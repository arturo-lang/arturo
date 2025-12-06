<?php
class SnippetDB {
    private $db;
    
    function __construct() {
        $db_path = '/usr/local/www/arturo/main/shared/data/snippets.db';
        $this->db = new SQLite3($db_path);
        
        // Create table if not exists
        $this->db->exec('
            CREATE TABLE IF NOT EXISTS snippets (
                id TEXT PRIMARY KEY,
                code TEXT NOT NULL,
                created_at INTEGER,
                last_accessed INTEGER,
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
        $now = time();
        
        // Check if snippet exists
        if ($this->exists($id)) {
            // Update existing snippet
            $stmt = $this->db->prepare('
                UPDATE snippets 
                SET code = :code,
                    last_accessed = :now,
                    execution_count = execution_count + 1
                WHERE id = :id
            ');
            $stmt->bindValue(':id', $id, SQLITE3_TEXT);
            $stmt->bindValue(':code', $code, SQLITE3_TEXT);
            $stmt->bindValue(':now', $now, SQLITE3_INTEGER);
        } else {
            // Insert new snippet
            $stmt = $this->db->prepare('
                INSERT INTO snippets (id, code, created_at, last_accessed, execution_count)
                VALUES (:id, :code, :now, :now, 1)
            ');
            $stmt->bindValue(':id', $id, SQLITE3_TEXT);
            $stmt->bindValue(':code', $code, SQLITE3_TEXT);
            $stmt->bindValue(':now', $now, SQLITE3_INTEGER);
        }
        
        return $stmt->execute();
    }
    
    function get($id) {
        $now = time();
        
        // Update last_accessed when retrieving
        $update = $this->db->prepare('
            UPDATE snippets SET last_accessed = :now WHERE id = :id
        ');
        $update->bindValue(':id', $id, SQLITE3_TEXT);
        $update->bindValue(':now', $now, SQLITE3_INTEGER);
        $update->execute();
        
        // Get the code
        $stmt = $this->db->prepare('SELECT code FROM snippets WHERE id = :id');
        $stmt->bindValue(':id', $id, SQLITE3_TEXT);
        $result = $stmt->execute();
        $row = $result->fetchArray(SQLITE3_ASSOC);
        return $row ? $row['code'] : null;
    }
    
    function cleanup() {
        // Delete snippets not accessed in 2 years (63072000 seconds)
        $cutoff = time() - (2 * 365 * 24 * 60 * 60);
        $this->db->exec("DELETE FROM snippets WHERE last_accessed < $cutoff");
        $this->db->exec('VACUUM');
    }
}
?>