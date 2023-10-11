# GRANT ALL PRIVILEGES on *.* TO 'root'@'172.18.0.%' WITH GRANT OPTION;
# flush privileges;

# GRANT ALL PRIVILEGES on *.* TO 'root'@'%' WITH GRANT OPTION;

# 데이터베이스와 테이블을 만들어줍니다.

DROP DATABASE IF EXISTS myapp;

CREATE DATABASE myapp;

USE myapp;

CREATE TABLE lists (
    id INTEGER AUTO_INCREMENT,
    value TEXT,
    PRIMARY KEY (id)
);
