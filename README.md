# odtp-component-example
This is a component used to test ODTP components. It uses Hugging face datasets, which you can download and save as `.csv.`

| Tool Info | Links |
| --- | --- |
| Original | [https://github.com/odtp-org/tool-example](https://github.com/odtp-org/tool-example) |
| Current Tool Version | [88f953f0aabbfb08189bdc3212aa1c209fbedb2d](https://github.com/odtp-org/tool-example/commit/88f953f0aabbfb08189bdc3212aa1c209fbedb2d) |

## ODTP command 

```
odtp new odtp-component-entry \
--name odtp-example \
--component-version v0.1.5 \
--repository https://github.com/odtp-org/odtp-component-example
``` 

## Tutorial
### Testing the component. 

This component can be tested in isolation with the following instructions.

1. Prepare manually a folder called volume containing the input files/folder needed:

2. Create your `.env` file with the parameters. 

```
HF_DATASET=rooten_tomatoes
```

3. Build the dockerfile.

```
docker build -t odtp-component-example .
```

4. Create an execution folder outside this repository and place the .env inside

```
mkdir odtp-component-example-execution
cd odtp-component-example-execution
mkdir odtp-input
mkdir odtp-output
mkdir odtp-logs
```

5. Run the following command. 

```
docker run -it --rm \
-v $(pwd)/odtp-input:/odtp/odtp-input \
-v $(pwd)/odtp-output:/odtp/odtp-output \
-v $(pwd)/odtp-logs:/odtp/odtp-logs \
--env-file .env odtp-component-example
```

## Changelog


- v0.1.5
    - Updated ODTP Client
    - Including workflows

- v0.1.4

- v0.1.3

- v0.1.2: Update `odtp-component-client` to v0.1.0

- v0.1.1: Change Dockerfile setup: use fixed versions for python and ubuntu

- v0.1.0: Basic functionality

## Development

Developed by SDSC
