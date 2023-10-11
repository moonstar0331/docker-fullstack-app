#FROM --platform=linux/x86_64 mysql:5.7
FROM mysql:5.7

# 한글이 깨지지 않도록 하는 설정 정보를 실제 mysql 설정을 해주는 my.cnf 파일로 덮어씌어준다.
COPY ./sqls/initialize.sql /docker-entrypoint-initdb.d/
ADD ./my.cnf etc/mysql/conf.d/my.cnf