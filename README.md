# YouTube Spam Analysis

CSCI461 — Assignment 1

This project analyzes YouTube comments, classifies them as Ham or Spam, and explores similar comments using K-Means.

## Dataset

[YouTube Spam Collection — UCI](https://archive.ics.uci.edu/dataset/380/youtube+spam+collection)

Creators: T. C. Alberto and J. V. Lochter.  
License: CC BY 4.0.

The project combines five CSV files containing 1,956 original comments.

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

Both classifiers use the same split and TF-IDF features. Identical cleaned texts stay together in the training/test split, and TF-IDF learns from training text only.

Evaluation uses one held-out split from five videos. It does not establish performance on entirely new videos.

## Requirements

- Docker Desktop running with Linux containers.
- Windows PowerShell.
- A local copy of this repository, including its data and notebook.

Docker Hub image: `abdullrhman22/bd-project:v2`

## Create the Working Container

Open PowerShell inside the project folder containing `Dockerfile`, `data`, and `notebook`.

Run these commands once to create the container:

```powershell
docker pull abdullrhman22/bd-project:v2

$projectRoot = (Get-Location).Path

docker run -d --name bd-project-work-v2 -p 8888:8888 --mount "type=bind,source=$projectRoot,target=/home/jovyan/bd-project" abdullrhman22/bd-project:v2

docker exec bd-project-work-v2 jupyter server list
```

Open http://localhost:8888 and enter the token shown by the last command.

Open `notebook/analysis.ipynb`, then select **Restart Kernel and Run All Cells**.

If `bd-project-work-v2` already exists, use the resume commands below instead of creating it again.

## Saving Your Work

The whole project folder is mounted into the container.

- The Python environment comes from image `v2`.
- Working files come from the local project folder.
- **Ctrl + S** saves notebook changes directly to the host.
- Generated results are saved in the host's `output` folder.
- Saved host files remain available after stopping or removing the container.

Use the folder containing the project files. Mounting an empty folder would hide the project files packaged inside the image.

Saving local changes does not automatically update the Docker Hub image.

## Stop and Resume

To stop the working container:

```powershell
docker stop bd-project-work-v2
```

To resume later:

```powershell
docker start bd-project-work-v2

docker exec bd-project-work-v2 jupyter server list
```

Open http://localhost:8888 and use the current token.

## Docker Basics

- **Image:** packaged files and software environment.
- **Container:** an instance created from an image.
- **Port mapping `8888:8888`:** host port on the left, container port on the right.
- **Bind mount:** connects the local project folder to the container folder.

Rebuilding an image does not automatically update existing containers.

## Build and Publish

The following commands build and publish version `v2` from the local project:

```powershell
docker build -t abdullrhman22/bd-project:v2 .

docker login

docker push abdullrhman22/bd-project:v2
```

Python packages are installed from `requirements.txt` during the build.

For future project releases, use a new tag such as `v3`.

## Verify the Published Image

Another team member should test the image using a new, empty folder outside the source project.

Open PowerShell in that folder:

```powershell
New-Item -ItemType Directory -Path output

$testRoot = (Get-Location).Path

docker pull abdullrhman22/bd-project:v2

docker run -d --name bd-project-v2-test -p 8889:8888 --mount "type=bind,source=$testRoot\output,target=/home/jovyan/bd-project/output" abdullrhman22/bd-project:v2

docker exec bd-project-v2-test jupyter server list
```

Open http://localhost:8889 and enter the token. Use **8889** in the browser even if the server output shows port 8888.

Run the packaged notebook using **Restart Kernel and Run All Cells**.

Only `output` is mounted for this verification, so the notebook and dataset are loaded from the image. Confirm that all results appear in the host's `output` folder.

After the test, record the team member's name, date, image tag, and result.

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
docker logs --tail 40 bd-project-work-v2
docker inspect bd-project-work-v2
```

Save screenshots of the successful build, image, running container, and executed notebook in `screenshots/`.

## Bonus

The project compares Naive Bayes and Logistic Regression using the same split and TF-IDF features.

The comparison is saved in `output/model_comparison.csv`.