# odtp-component-template
This is a component used for testing ODTP components. It uses hugging face datasets, download it, and save it as `.csv`.

Please follow the next steps to adapt your tool. 

The component app is contained in `app>app.sh`, while the `odtp` is in `odtp-client`. 

## Testing the component. 

This component can be tested in isolation with the following instructions.

1. Prepare manually a folder called volume containing the input files/folder needed:

2. Create your `.env` file with the parameters. **If you do not have MONGODB and/or S3 activated omit don't declare the related variables**.

```
HF_DATASET=A

MONGODB_CLIENT=mongodb://.....
S3_SERVER=https://....
S3_ACCESS_KEY=Q0ISQ....
S3_SECRET_KEY=OoPthI....
S3_BUCKET_NAME=13301....

ODTP-USER-ID=
ODTP-DIGITAL-TWIN=
ODTP-EXCUTION=
ODTP-STEP=
ODTP-COMPONENT=
ODTP-COMPONENT-VERSION=
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