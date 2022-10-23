# ms-sql-server_by_docker-compose

# Для запуска контейнера в командной строке введите

git clone https://github.com/Goloseev/ms-sql-server_by_docker-compose.git
cd ms-sql-server_by_docker-compose
docker-compose up

# неудачный запуск с проблемой доступа к каталогу _vol_msSQL остановить, 
# назначить макс права каталогу созданной при первом запуске папке _vol_msSQL

sudo chmod 777 -R ./_vol_msSQL

# повторно запустить контейнер

docker-compose up