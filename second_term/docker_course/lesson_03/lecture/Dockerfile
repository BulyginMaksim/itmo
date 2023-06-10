FROM ubuntu:20.04

RUN apt-get update && apt-get install -y vim wget curl git

WORKDIR /home/maksim

COPY ./script.sh ./script.sh

RUN touch hello.sh && echo "echo 'Hello for container'" > hello.sh

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p https://github.com/zsh-users/zsh-autosuggestions

ENV ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg-#dedede,bg=#9c9c9c,bold,underline"

ENTRYPOINT ["zsh"]
CMD ["hello.sh"]

#docker run custom_ubuntu
#>> zsh hello.sh
#
#docker run node
#>> docker-entrypoint.sh node
#
#docker run -it node bash
#>> docker-entrypoint.sh bash
#
#docker run custom_ubuntu script.sh
#>> zsh script.sh
#
#docker run node bash  # bash here overwrites CMD ["node"]
#>> docker-entrypoint.sh bash
#
#docker run -it --entrypoint=zsh custom_ubuntu
#>> zsh