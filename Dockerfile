FROM docker.io/rocm/pytorch:rocm5.2.3_ubuntu20.04_py3.7_pytorch_1.12.1

WORKDIR /sd

RUN apt-get update && \
    apt-get install -y wget git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./sd_requirements.txt /sd/
COPY ./requirements.txt /sd/
COPY ./ext_requirements.txt /sd/
COPY ./ui_requirements.txt /sd/

RUN pip install -r /sd/sd_requirements.txt \
 && pip install -r /sd/requirements.txt \
 && pip install -r /sd/ext_requirements.txt \
 && pip install -r /sd/ui_requirements.txt

# Install font for prompt matrix
COPY /data/DejaVuSans.ttf /usr/share/fonts/truetype/

ENV PYTHONPATH=/sd

EXPOSE 7860 8501

COPY . /sd
ENTRYPOINT /sd/entrypoint.sh