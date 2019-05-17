CREATE TABLE comment (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(127),
    email VARCHAR(255),
    created_at DATETIME,
    text TEXT,
    post_id INT(1)
);
