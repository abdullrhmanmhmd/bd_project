# YouTube Spam Analysis

CSCI461 — Assignment 1

This project analyzes YouTube comments, classifies them as Ham or Spam, and explores similar comments using K-Means.

## Dataset

[YouTube Spam Collection — UCI](https://archive.ics.uci.edu/dataset/380/youtube+spam+collection)

Creators: T. C. Alberto and J. V. Lochter.  
License: CC BY 4.0.

The dataset contains 1,956 comments from five videos. The project merges the five original CSV files.

- `CONTENT`: original comment text.
- `CLASS`: true label, where `0 = Ham` and `1 = Spam`.
- `VIDEO`: source video group.

## Analysis

The notebook includes:

- Missing-value and duplicate checks.
- Text cleaning while preserving the original comments.
- Token counts and word frequencies before and after stopword removal.
- Four numerical text features and a correlation heatmap.
- Transformations, `loc`/`iloc`, and three sampling methods.
- Ham/Spam comparisons and five written insights in Markdown cells.
- **Logistic Regression as the primary classifier.**
- Multinomial Naive Bayes as a baseline comparison.
- Accuracy, precision, recall, F1, and confusion matrices.
- K-Means with silhouette scores, top terms, and example comments.

Both classifiers use the same training/test split and TF-IDF features. Identical cleaned texts stay together in the split, and TF-IDF learns from training text only.

Evaluation uses one held-out split from five videos. It does not establish performance on entirely new videos.

## Requirements

- Docker Desktop running with Linux containers.
- Windows PowerShell.

Python packages are installed automatically from `requirements.txt`.

## Build and Run for Development

Open PowerShell inside the project folder:

```powershell
docker build -t bd-project:dev .

$projectRoot = (Get-Location).Path

docker run -d --name bd-project-container -p 8888:8888 --mount "type=bind,source=$projectRoot,target=/home/jovyan/bd-project" bd-project:dev

docker exec bd-project-container jupyter server list
```

Open http://localhost:8888 and enter the token shown by the last command.

Open `analysis.ipynb` inside the `notebook` folder, then select **Restart Kernel and Run All Cells**.

The whole project is mounted for development, so notebook changes and generated results are saved on the host.

Run `docker run` only when creating the container. For later sessions, use:

```powershell
docker start bd-project-container
docker exec bd-project-container jupyter server list
```

To stop it:

```powershell
docker stop bd-project-container
```

## Docker Basics

- **Image:** packaged project files and software environment.
- **Container:** an instance created from an image.
- **Port mapping `8888:8888`:** host port on the left, container port on the right.
- **Bind mount:** connects a host folder to a container folder and keeps saved files available on the host.

Rebuilding an image does not automatically update existing containers.

## Build and Push Version v2

Run these commands inside the project folder:

```powershell
docker build -t abdullrhman22/bd-project:v2 .

docker login

docker push abdullrhman22/bd-project:v2
```

Docker Hub image: `abdullrhman22/bd-project:v2`

## Run the Docker Hub Image

Open PowerShell in a new, empty test folder outside the source project:

```powershell
New-Item -ItemType Directory -Path output

$testRoot = (Get-Location).Path

docker pull abdullrhman22/bd-project:v2

docker run -d --name bd-project-v2-test -p 8889:8888 --mount "type=bind,source=$testRoot\output,target=/home/jovyan/bd-project/output" abdullrhman22/bd-project:v2

docker exec bd-project-v2-test jupyter server list
```

Open http://localhost:8889 and enter the token. Use port **8889** in the browser even if the server output shows port 8888.

Open the packaged notebook and select **Restart Kernel and Run All Cells**.

Only `output` is mounted during this test. The notebook and dataset are loaded from the image, and results are saved in the host's `output` folder.

For later sessions:

```powershell
docker stop bd-project-v2-test
docker start bd-project-v2-test
docker exec bd-project-v2-test jupyter server list
```

## Output Files

Results are saved under `output/`:

- `cleaned_data.csv`
- `model_metrics.txt`
- `naive_bayes_metrics.txt`
- `model_comparison.csv`
- `test_predictions.csv`
- `naive_bayes_predictions.csv`
- `cluster_summary.txt`
- `sampling_comparison.csv`
- `group_summary.csv`
- `top10_words_by_class.csv`
- `kmeans_k_comparison.csv`
- `figures/`: word-frequency charts, correlation heatmap, group comparison, and both confusion matrices.

The five written insights are included directly in the notebook as Markdown cells.

## Container Evidence

```powershell
docker images
docker ps
docker ps -a
docker logs --tail 40 bd-project-v2-test
docker inspect bd-project-v2-test
```

Save screenshots of the successful build, image, running container, and executed notebook in `screenshots/`.

## Teammate Verification

Another team member should follow the Docker Hub instructions, run the notebook successfully, and confirm that output files appear on their computer.

After the test, record the member's name, test date, image tag, and result here.

## Bonus

The project compares Naive Bayes and Logistic Regression using the same split and TF-IDF features. The comparison is saved in `output/model_comparison.csv`.