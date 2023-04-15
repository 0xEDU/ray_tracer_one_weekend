NAME = rt
IMAGE = image.ppm
PNG = image.png

FLAGS = -Wall -Wextra -Werror -g3

INCLUDES_PATH = ./includes/
SRCS_PATH = ./sources/
OBJS_PATH = ./objects/

SRCS = $(addprefix $(SRCS_PATH), main.cc)

OBJS = ${SRCS:$(SRCS_PATH)%.cc=$(OBJS_PATH)%.o}

all: $(NAME)

$(NAME): $(OBJS)
	@c++ $(FLAGS) $(OBJS) -o $(NAME)

$(OBJS_PATH)%.o: $(SRCS_PATH)%.cc
	@mkdir -p $(OBJS_PATH)
	@c++ $(FLAGS) -I$(INCLUDES_PATH) -c $< -o $@
	@echo -e "\033[1;92m[SUCCESS] Object creation done!\033[0m"

run: all
	@./rt > $(IMAGE)
	@convert $(IMAGE) $(PNG)
	@git add $(PNG)
	@git commit -m "added image from Makefile"
	@git push origin master

clean:
	@rm -rf $(OBJS_PATH)
	@echo -e "\033[1;93m[SUCCESS] Objects removed!\033[0m"

fclean: clean
	@rm -rf $(NAME)
	@rm -rf $(IMAGE)
	@echo -e "\033[1;93m[SUCCESS] Full clean done!\033[0m"

re: fclean all

.PHONY: all clean fclean re
