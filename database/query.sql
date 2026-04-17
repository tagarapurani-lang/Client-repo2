CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    
    username VARCHAR(50) NOT NULL UNIQUE,
    
    password_hash VARCHAR(255) NOT NULL,
    
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Fast login lookups
CREATE INDEX idx_users_username ON users(username);

-- Optional: filter active users
CREATE INDEX idx_users_active ON users(is_active);
$passwordHash = password_hash($password, PASSWORD_DEFAULT);

INSERT INTO users (username, password_hash)
VALUES ('john_doe', '$passwordHash');
SELECT password_hash
FROM users 
WHERE username = :username AND is_active = true;
password_verify($enteredPassword, $dbPasswordHash);
ALTER TABLE users
ADD CONSTRAINT username_length_chk CHECK (length(username) >= 3);
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(30) UNIQUE NOT NULL
);
ALTER TABLE users
ADD COLUMN role_id INT REFERENCES roles(role_id);
``
CREATE TABLE login_audit (
    audit_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    login_time TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    ip_address INET,
    success BOOLEAN
);

