#FROM docker
#FROM docker:latest
FROM sreesha575/tensorflow-serving:latest
COPY . .

WORKDIR .

RUN mkdir -p /models/model
RUN mkdir -p /models/model1

ADD ./half_plus_three /models/model/
ADD ./half_plus_two /models/model1/
ADD ./model_config /models/

EXPOSE 8500
EXPOSE 8501 

RUN apt-get update && apt-get install -y curl 
RUN apt-get update && apt-get install -y vim

ENTRYPOINT tensorflow_model_server --port=8500 --rest_api_port=8501 --model_config_file=/models/model_config --model_config_file_poll_wait_seconds=60 
