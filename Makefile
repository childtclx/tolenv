default: usage

.FORCE:

usage: .FORCE
	@echo "make pull \t拉取开发环境，拉取 Docker 映像"
	@echo "make up \t创建开发环境，构建 Docker 容器"
	@echo "make down \t移除开发环境，删除构建的 Docker 容器"
	@echo "make start \t启用开发环境，启用构建的 Docker 容器"
	@echo "make stop \t停用开发环境，停用构建的 Docker 容器"
	@echo "make pause \t暂停开发环境，暂停构建的 Docker 容器"
	@echo "make unpause \t取消暂停开发环境，取消暂停构建的 Docker 容器"
	@echo "\n\nHave a good time!"

pull: .FORCE
	@docker pull hikalium/ubuntu-with-libc-i386

up: .FORCE
	@[ $$(docker ps -f "name=tolenv" --format '{{.Names}}') = tolenv ] && echo "Already up" || \
		( docker run -d -it --name tolenv -v "$$(pwd)":"/home/$${USER}/tolenv" hikalium/ubuntu-with-libc-i386 && echo "OK!" )

down: .FORCE
	@docker stop tolenv && docker rm tolenv && echo "tolenv container deleted" || echo "Already down"

start: .FORCE
	@docker start tolenv

stop: .FORCE
	@docker stop tolenv

pause: .FORCE
	@docker pause tolenv

unpause: .FORCE
	@docker unpause tolenv

clean: .FORCE
