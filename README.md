# Copy Folder to Remote Server via SCP GitHub Action

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/pierrickdelrieu/scp-action/Copy%20Folder%20to%20Remote%20Server%20via%20SCP%20Action)
![GitHub](https://img.shields.io/github/license/pierrickdelrieu/scp-action)


This GitHub Action allows you to copy files from a specified directory in your repository to a remote server via SCP. It's a simple and convenient way to automate the deployment of your project files to a remote server.


## Usage

To use this action in your workflow, you can add the following configuration to your workflow YAML file (e.g., `.github/workflows/deploy.yml`):


```yaml
name: Copy files with SCP

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  copy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Copy to Remote Server
      uses: pierrickdelrieu/scp-action@v0.1.0
      with:
        host: ${{ secrets.DESTINATION_HOST }}
        ssh_port: ${{ secrets.DESTINATION_SSH_PORT }}
        ssh_username: ${{ secrets.SSH_USERNAME }}
        ssh_key: ${{ secrets.SSH_KEY }}
        ssh_passphrase: ${{ secrets.SSH_PASSPHRASE }}
        source_dir: ${{ secrets.SOURCE_FOLDER }}
        destination_dir: ${{ secrets.DESTINATION_FOLDER }}
        rm: true


```

## Input variables

This informations are also present in the [action.yml](./action.yml) file.

|        Options        | Type | Description | Default | Required |
|-----------------------|------|-------------|---------|----------|
| host | string | The remote host where you want to copy files. |  | X |
| ssh_port | integer | The remote port to use for SSH.  | 22 |  |
| ssh_username | string | Your SSH username for authentication. |  | X |
| ssh_key | string | Your SSH key for authentication. |  | X |
| ssh_passphrase | string | The passphrase for your SSH key (if applicable). |  |  |
| source_dir | string | The local source directory from your repository. | ./ |  |
| destination_dir | string | The remote destination directory on the server. |  | X |
| rm | boolean | Whether to remove the content of the target folder on the remote server before uploading data | false |  |


## Settings up SSH KEY

## License

This action is released under the [MIT License](LICENSE).

## Author

- [Pierrick Delrieu](https://pierrickdelrieu.com)


