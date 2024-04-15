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
--component-version 0.1.0 \
--repository https://github.com/odtp-org/odtp-component-example \
--commit a30858fe0997c839130f0e31583232caa143c79c
``` 

## Tutorial
### Testing the component. 

This component can be tested in isolation with the following instructions.

1. Prepare manually a folder called volume containing the input files/folder needed:

2. Create your `.env` file with the parameters. 

```
HF_DATASET=A
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
```

5. Run the following command. 

```
docker run -it --rm -v [Absolute Path to your input folder]:/odtp/odtp-input -v [Absolute Path to your output folder]:/odtp/odtp-output --env-file .env odtp-component-example
```

## Changelog

- v0.1.0: Basic functionality

## Development

Developed by SDSC
