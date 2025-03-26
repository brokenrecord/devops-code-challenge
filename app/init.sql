CREATE TABLE IF NOT EXISTS greetings (
    id SERIAL PRIMARY KEY,
    message TEXT NOT NULL
);

INSERT INTO greetings (message) VALUES
('Hello from your RDS database!'),
('Bonjour du cloud!'),
('Hola desde AWS!'),
('Ciao dal database!'),
('Hallo von der Datenbank!'),
('こんにちは、データベースから！'),
('👋 Greetings from your containerized backend!');