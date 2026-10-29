# YouTube Spam Analysis

CSCI461 - Assignment 1

This project analyzes YouTube comments, classifies them as spam or ham,
and groups similar comments using K-Means.

## Dataset

[YouTube Spam Collection](https://archive.ics.uci.edu/dataset/380/youtube+spam+collection)

Creators: T. C. Alberto and J. V. Lochter.  
License: CC BY 4.0.

The project combines five CSV files. Each row represents one comment.

- CONTENT: original comment.
- CLASS: 0 = Ham, 1 = Spam.
- VIDEO: source video group.

The original dataset contains 1,956 rows.
After removing three exact duplicates and eight empty cleaned comments,
1,945 rows remain.

## Requirements

- Docker Desktop running with Linux containers.
- Windows PowerShell.

Python packages are installed from requirements.txt during the build.

## Build and Run

Open PowerShell inside the project folder:

```powershell
docker build -t bd-project:dev .

$projectRoot = (Get-Location).Path

docker run -d --name bd-project-container -p 8888:8888 --mount "type=bind,source=$projectRoot,target=/home/jovyan/bd-project" bd-project:dev

docker exec bd-project-container jupyter server list
```

Open http://localhost:8888 and enter the token from the last command.

Open notebook/analysis.ipynb and select:
**Kernel → Restart Kernel and Run All Cells**.

The docker run command creates the container once.
For later sessions, use docker start.

## Stop and Resume

```powershell
docker stop bd-project-container
docker start bd-project-container
docker exec bd-project-container jupyter server list
```

## Docker Explanation

- Image: the packaged project files and software environment.
- Container: an instance created from the image.
- Port mapping 8888:8888: host port on the left, container port on the right.
- Bind mount: connects the host project folder to the container.
  Notebook changes and output files remain on the host.

Rebuilding an image does not update an existing container automatically.

## Analysis

The notebook includes:

- Missing values, duplicates, and text cleaning.
- Token counts and word frequencies before and after stopword removal.
- Ham/Spam comparisons and numerical text features.
- Transformations, loc/iloc examples, and three sampling methods.
- A correlation heatmap and written insights.
- TF-IDF with Multinomial Naive Bayes.
- Accuracy, precision, recall, F1, and a confusion matrix.
- K-Means with silhouette scores, top terms, and example comments.

Identical cleaned texts stay together in the training/test split.
TF-IDF learns from training text only.

The dataset contains only five video groups, so evaluation does not
establish performance on entirely new videos.

## Output Files

Results are saved under output/:

- cleaned_data.csv
- model_metrics.txt
- cluster_summary.txt
- insights.md
- figures/ containing word-frequency charts, group comparison,
  correlation heatmap, and confusion matrix.

## Docker Evidence

```powershell
docker images
docker ps
docker ps -a
docker logs --tail 40 bd-project-container
docker inspect bd-project-container
```

Screenshots of the build, image, container, and executed notebook
are stored in screenshots/.

## Docker Hub

```powershell
docker build -t bd-project:dev .
docker login
docker tag bd-project:dev abdullrhman22/bd-project:v1
docker push abdullrhman22/bd-project:v1
```

Published image: yourusername/bd-project:v1

## Teammate Verification

On another team member's computer, open PowerShell in an empty test folder:

```powershell
New-Item -ItemType Directory -Force -Path output

$testRoot = (Get-Location).Path

docker pull yourusername/bd-project:v1

docker run -d --name bd-project-verify -p 8888:8888 --mount "type=bind,source=$testRoot\output,target=/home/jovyan/bd-project/output" yourusername/bd-project:v1

docker exec bd-project-verify jupyter server list
```

Open Jupyter and run the packaged notebook from beginning to end.

Only output is mounted, so the notebook and dataset inside the image
remain visible. Confirm that results appear in the host output folder.

## Bonus

Compared Multinomial Naive Bayes and Logistic Regression using the same
training/test split and TF-IDF features. Results are saved in
output/model_comparison.csv and output/model_metrics.txt.