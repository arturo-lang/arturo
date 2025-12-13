<?php
// =============================================================================
// DATABASE HANDLER
// =============================================================================
// Manages snippet storage, rate limiting, and visit tracking

class SnippetDB {
    private $db;
    
    function __construct() {
        $db_path = '/usr/local/www/arturo/main/shared/data/snippets.db';
        $this->db = new SQLite3($db_path);
        
        // Create snippets table
        $this->db->exec('
            CREATE TABLE IF NOT EXISTS snippets (
                id TEXT PRIMARY KEY,
                code TEXT NOT NULL,
                created_at INTEGER,
                last_accessed INTEGER,
                visit_count INTEGER DEFAULT 0,
                creator_ip TEXT
            )
        ');
        
        // Create rate limiting table
        $this->db->exec('
            CREATE TABLE IF NOT EXISTS rate_limits (
                ip TEXT,
                hour INTEGER,
                count INTEGER,
                PRIMARY KEY (ip, hour)
            )
        ');
    }
    
    // =========================================================================
    // SNIPPET MANAGEMENT
    // =========================================================================
    
    function generateUniqueId($length = 6) {
        $chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $max_attempts = 10;
        
        for ($attempt = 0; $attempt < $max_attempts; $attempt++) {
            $id = '';
            for ($i = 0; $i < $length; $i++) {
                $id .= $chars[random_int(0, 61)];
            }
            
            if (!$this->exists($id)) {
                return $id;
            }
        }
        
        return $this->generateUniqueId($length + 1);
    }
    
    function exists($id) {
        $stmt = $this->db->prepare('SELECT 1 FROM snippets WHERE id = :id LIMIT 1');
        $stmt->bindValue(':id', $id, SQLITE3_TEXT);
        $result = $stmt->execute();
        return $result->fetchArray() !== false;
    }
    
    function save($id, $code, $creator_ip) {
        $now = time();
        
        if ($this->exists($id)) {
            $stmt = $this->db->prepare('
                UPDATE snippets 
                SET code = :code,
                    last_accessed = :now
                WHERE id = :id
            ');
            $stmt->bindValue(':id', $id, SQLITE3_TEXT);
            $stmt->bindValue(':code', $code, SQLITE3_TEXT);
            $stmt->bindValue(':now', $now, SQLITE3_INTEGER);
        } else {
            $stmt = $this->db->prepare('
                INSERT INTO snippets (id, code, created_at, last_accessed, visit_count, creator_ip)
                VALUES (:id, :code, :now, :now, 0, :creator_ip)
            ');
            $stmt->bindValue(':id', $id, SQLITE3_TEXT);
            $stmt->bindValue(':code', $code, SQLITE3_TEXT);
            $stmt->bindValue(':now', $now, SQLITE3_INTEGER);
            $stmt->bindValue(':creator_ip', $creator_ip, SQLITE3_TEXT);
        }
        
        return $stmt->execute();
    }
    
    function get($id) {
        $stmt = $this->db->prepare('SELECT code FROM snippets WHERE id = :id');
        $stmt->bindValue(':id', $id, SQLITE3_TEXT);
        $result = $stmt->execute();
        $row = $result->fetchArray(SQLITE3_ASSOC);
        return $row ? $row['code'] : null;
    }
    
    function getCreatorIp($id) {
        $stmt = $this->db->prepare('SELECT creator_ip FROM snippets WHERE id = :id');
        $stmt->bindValue(':id', $id, SQLITE3_TEXT);
        $result = $stmt->execute();
        $row = $result->fetchArray(SQLITE3_ASSOC);
        return $row ? $row['creator_ip'] : null;
    }
    
    function recordVisit($id) {
        $stmt = $this->db->prepare('
            UPDATE snippets 
            SET visit_count = visit_count + 1,
                last_accessed = :now
            WHERE id = :id
        ');
        $stmt->bindValue(':id', $id, SQLITE3_TEXT);
        $stmt->bindValue(':now', time(), SQLITE3_INTEGER);
        return $stmt->execute();
    }
    
    function cleanup() {
        $cutoff = time() - (2 * 365 * 24 * 60 * 60);
        
        // Use prepared statement for safety
        $stmt = $this->db->prepare('DELETE FROM snippets WHERE last_accessed < :cutoff');
        $stmt->bindValue(':cutoff', $cutoff, SQLITE3_INTEGER);
        $stmt->execute();
        
        $this->db->exec('VACUUM');
    }
    
    // =========================================================================
    // RATE LIMITING
    // =========================================================================
    
    function checkRateLimit($ip, $limit = 60) {
        $current_hour = floor(time() / 3600);
        
        $stmt = $this->db->prepare('
            SELECT count FROM rate_limits 
            WHERE ip = :ip AND hour = :hour
        ');
        $stmt->bindValue(':ip', $ip, SQLITE3_TEXT);
        $stmt->bindValue(':hour', $current_hour, SQLITE3_INTEGER);
        $result = $stmt->execute();
        $row = $result->fetchArray(SQLITE3_ASSOC);
        
        if (!$row) {
            return true;
        }
        
        return $row['count'] < $limit;
    }
    
    function recordExecution($ip) {
        $current_hour = floor(time() / 3600);
        
        $stmt = $this->db->prepare('
            INSERT INTO rate_limits (ip, hour, count)
            VALUES (:ip, :hour, 1)
            ON CONFLICT(ip, hour) DO UPDATE SET count = count + 1
        ');
        $stmt->bindValue(':ip', $ip, SQLITE3_TEXT);
        $stmt->bindValue(':hour', $current_hour, SQLITE3_INTEGER);
        
        return $stmt->execute();
    }
    
    function cleanupRateLimits() {
        $cutoff_hour = floor(time() / 3600) - 24;
        
        // Use prepared statement for safety
        $stmt = $this->db->prepare('DELETE FROM rate_limits WHERE hour < :cutoff_hour');
        $stmt->bindValue(':cutoff_hour', $cutoff_hour, SQLITE3_INTEGER);
        $stmt->execute();
    }
}
?>