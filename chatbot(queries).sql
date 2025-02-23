CREATE DATABASE chatbot;

USE chatbot;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Conversations (
    conversation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP,
    status ENUM('active', 'completed', 'timeout', 'error') DEFAULT 'active',
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    conversation_id INT NOT NULL,
    sender ENUM('user', 'bot') NOT NULL,
    message_text TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES Conversations(conversation_id)
);

CREATE TABLE Query_Patterns (
    query_id INT AUTO_INCREMENT PRIMARY KEY,
    query_text TEXT NOT NULL,
    frequency INT DEFAULT 0,
    last_asked TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Chatbot_Responses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    query_id INT NOT NULL,
    response_text TEXT NOT NULL,
    response_time FLOAT,
    accuracy_score FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (query_id) REFERENCES Query_Patterns(query_id)
);

CREATE TABLE AI_Model_Integration (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    model_version VARCHAR(50) NOT NULL,
    model_type VARCHAR(50),
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT
);

-- Insert Sample Data
INSERT INTO Users (user_name, email, phone_number, created_at, updated_at) VALUES
('Alice Smith', 'alice.smith@example.com', '12345', NOW(), NOW()),
('Bob Johnson', 'bob.johnson@example.com', '12346', NOW(), NOW());

INSERT INTO Conversations (user_id, start_time, status) VALUES
(1, NOW(), 'active'),
(2, NOW(), 'completed');

INSERT INTO Messages (conversation_id, sender, message_text, timestamp) VALUES
(1, 'user', 'Hello, chatbot!', NOW()),
(1, 'bot', 'Hello Alice! How can I help you today?', NOW());

-- Sample Queries
SELECT * FROM Conversations WHERE user_id = 1;
SELECT * FROM Messages WHERE conversation_id = 1;
SELECT * FROM Query_Patterns ORDER BY frequency DESC LIMIT 5;
SELECT * FROM Chatbot_Responses WHERE query_id = 1;
SELECT * FROM AI_Model_Integration ORDER BY update_date DESC;

COMMIT;
