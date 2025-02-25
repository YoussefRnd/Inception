NAME = Inception

dirs= ~/data/wordpress ~/data/mariadb ~/data/grafana

all: $(NAME)

$(NAME):
	sudo mkdir -p $(dirs)
	docker compose -f srcs/docker-compose.yml up -d --build

clean:
	docker compose -f srcs/docker-compose.yml down

fclean: clean
	sudo rm -rf $(dirs)
	docker system prune -af
	
re: fclean all