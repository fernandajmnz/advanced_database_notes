-- Exercise 1

CREATE TABLE comments (
    id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    task_id    NUMBER        NOT NULL,
    user_id    NUMBER        NOT NULL,
    content    VARCHAR2(1000) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comments_task
        FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_user
        FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Questions
-- 1. Comment should have belongs_to Task and belongs_to user
-- 2. Yes, task should have comments = relationship("Comment", back_populates="task")
-- 3. Comments should be cascade deleted when a task is deleted

-- Exercise 2
CREATE TABLE comments (
    id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    task_id    NUMBER         NOT NULL,
    user_id    NUMBER         NOT NULL,
    content    VARCHAR2(1000) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comments_task FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT ck_comment_content_not_empty CHECK (content != '')
);

DROP TABLE comments;

-- Questions 
-- 1. Upgrade creates the comments table, adds to the db
-- 2. Reverses the migration
-- 3. The comments table gets dropped and all comment data is lost

-- Exercise 3
INSERT INTO teams (name, description) VALUES ('DevOps', 'Infrastructure and deployment team');

-- 2. Create diana_ops user
INSERT INTO users (username, email, full_name, team_id)
    VALUES ('diana_ops', 'diana@example.com', 'Diana Ops',
            (SELECT id FROM teams WHERE name = 'DevOps'));
INSERT INTO tasks (title, description, status, assigned_to)
    VALUES ('Setup CI/CD pipeline', 'Configure GitHub Actions', 'open',
            (SELECT id FROM users WHERE username = 'diana_ops'));
INSERT INTO tasks (title, description, status, assigned_to)
    VALUES ('Monitor prod servers', 'Set up Grafana dashboards', 'in_progress',
            (SELECT id FROM users WHERE username = 'diana_ops'));
INSERT INTO tasks (title, description, status, assigned_to)
    VALUES ('Cleanup old Docker images', 'Low priority maintenance', 'open',
            (SELECT id FROM users WHERE username = 'diana_ops'));

SELECT COUNT(*) AS task_count FROM tasks
WHERE assigned_to = (SELECT id FROM users WHERE username = 'diana_ops');

UPDATE tasks SET status = 'closed', updated_at = CURRENT_TIMESTAMP
WHERE title = 'Setup CI/CD pipeline';
DELETE FROM tasks WHERE title = 'Cleanup old Docker images';
COMMIT;

-- Exercise 4
ALTER TABLE tasks ADD estimated_hours NUMBER;
ALTER TABLE tasks DROP COLUMN estimated_hours;

COMMIT;

-- 1. The estimated_hours column is dropped from the tasks table
-- 2. All data stored in that column is permanently lost

--Exercise 5
-- 1. ORM allows developers to interact with Python objects rather than writing SQL queries directly, making the code easier to read, less prone to errors, and independent of a specific database system.
-- 2. Migrations provide version control for database schema modifications, ensuring that the database structure stays synchronized with the application code without requiring manual ALTER TABLE statements.
--3. A rollback is used when a migration causes issues, such as introducing bugs or breaking functionality in a production environment
--4. The `add()` method places an object in the session memory, while `commit()` saves those changes permanently to the database.
--5. Relationships make it possible to access and navigate related objects directly, eliminating the need to manually write JOIN queries.
