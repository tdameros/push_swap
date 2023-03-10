#*******************************  VARIABLES  **********************************#

NAME			=	push_swap
CHECKER			=	checker

# --------------- FILES --------------- #

LIST_SRC		=	main.c \
					stack.c \
					stack_instruction.c \
					instruction.c \
					push_swap_sort.c \
					quick_sort.c \
					merge_sort.c \
					push.c \
					optimization.c \
					simplification.c \
					parser.c \
					print.c \
					utils.c

LIST_CHECKER_SRC =	checker.c \
					stack.c \
					stack_instruction.c \
					parser.c \
					merge_sort.c \
					utils.c

# ------------ DIRECTORIES ------------ #

DIR_BUILD		=	.build/
DIR_SRC 		=	src/
DIR_INCLUDE		=	include/
DIR_LIB			=	lib/
DIR_LIBFT		=	$(addprefix $(DIR_LIB), libft/)

# ------------- SHORTCUTS ------------- #

OBJ				=	$(patsubst %.c, $(DIR_BUILD)%.o, $(SRC))
CHECKER_OBJ		=	$(patsubst %.c, $(DIR_BUILD)%.o, $(CHECKER_SRC))
DEP				=	$(patsubst %.c, $(DIR_BUILD)%.d, $(SRC))
SRC				=	$(addprefix $(DIR_SRC),$(LIST_SRC))
CHECKER_SRC		=	$(addprefix $(DIR_SRC),$(LIST_CHECKER_SRC))
LIBFT			=	$(addprefix $(DIR_LIBFT), libft.a)

# ------------ COMPILATION ------------ #

CFLAGS			=	-Wall -Wextra -Werror
DEP_FLAGS		=	-MMD -MP

# -------------  COMMANDS ------------- #

RM				=	rm -rf
MKDIR			=	mkdir -p

#***********************************  RULES  **********************************#

.PHONY: all
all:			$(NAME)

.PHONY: bonus
bonus:			$(CHECKER)

# ---------- VARIABLES RULES ---------- #

$(NAME):		$(LIBFT) $(OBJ)
				$(CC) $(CFLAGS) -o $(NAME) $(OBJ) -L $(DIR_LIBFT) -lft

$(CHECKER):		$(LIBFT) $(CHECKER_OBJ)
				$(CC) $(CFLAGS) -o $(CHECKER) $(CHECKER_OBJ) -L $(DIR_LIBFT) -lft

$(LIBFT): FORCE
	$(MAKE) -C $(DIR_LIBFT)

# ---------- COMPILED RULES ----------- #

-include $(DEP)

$(DIR_BUILD)%.o: %.c
				mkdir -p $(shell dirname $@)
				$(CC) $(CFLAGS) $(DEP_FLAGS) -I $(DIR_INCLUDE) -c $< -o $@

.PHONY: clean
clean:
				$(MAKE) -C $(DIR_LIBFT) clean
				$(RM) $(DIR_BUILD)

.PHONY: fclean
fclean: clean
				$(MAKE) -C $(DIR_LIBFT) fclean
				$(RM) $(NAME)
				$(RM) $(CHECKER)

.PHONY: re
re:				fclean
				$(MAKE) all

.PHONY: FORCE
FORCE:
