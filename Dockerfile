FROM quay.io/jupyter/scipy-notebook:latest

RUN mkdir -p /home/jovyan/bd-project

WORKDIR /home/jovyan/bd-project

COPY --chown=jovyan:users requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=jovyan:users data/ ./data/

COPY --chown=jovyan:users notebook/ ./notebook/

RUN mkdir -p output/figures

CMD ["start-notebook.py", "--ServerApp.root_dir=/home/jovyan/bd-project"]