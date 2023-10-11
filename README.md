#  📄 Transfer file to Remote Server via SCP GitHub Action

![Version](https://img.shields.io/github/v/release/pierrickdelrieu/scp-action)
![Issues](https://img.shields.io/github/issues/pierrickdelrieu/scp-action)
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
| host | string | The remote host where you want to copy files. |  | **X** |
| ssh_port | integer | The remote port to use for SSH.  | 22 |  |
| ssh_username | string | Your SSH username for authentication. |  | **X** |
| ssh_key | string | Your SSH key for authentication. |  | **X** |
| ssh_passphrase | string | The passphrase for your SSH key (if applicable). |  |  |
| source_dir | string | The local source directory from your repository. | ./ |  |
| destination_dir | string | The remote destination directory on the server. |  | **X** |
| rm | boolean | Whether to remove the content of the target folder on the remote server before uploading data | false |  |

💡 It is recommended to put the variables that you define as secrets in the repository. To do this, head to `settings/Security/Secrets and Variables/Actions`.

[Github Action Secrets](https://docs.github.com/en/rest/actions/secrets)


## Settings up SSH KEY
Here's a step-by-step tutorial on how to set up an SSH key after creating a user on a machine:

**- Step 1: Create a New User (if not already created)**
If you haven't already created a user on the machine, you can do so with the following command (replace <username> with your desired username):
```bash
Copy code
sudo adduser <username>
```

**-Step 2: Log In as the New User**
You can log in as the new user using the following command (replace <username> with the username you created):
```bash
su - <username>
```

**-Step 3: Generate SSH Key Pair**
Now, let's generate an SSH key pair. The key pair consists of a private key (which you keep on your local machine) and a public key (which you copy to the remote machine).
Run the following command to generate the key pair. Make sure to replace <your_email@example.com> :
```bash
Copy code
ssh-keygen -t rsa -b 4096 -C "<your_email@example.com>"
```
This command will prompt you to enter a file where you want to save the key. By default, it will be saved in ~/.ssh/id_rsa or /home/<username>/.ssh/id_rsa. You can leave it as the default or specify a custom location.


**- Step 4:**
You'll need to copy the public key to the remote machine where you want to log in.
```bash
cat .ssh/id_rsa.pub | ssh <username>@<remote_host> 'cat >> .ssh/authorized_keys'
```

After that, you can disbale the authentification with password and enable the authentification with key in `/etc/ssh/sshd_config`.


Finish ! You can copy the private key (id_rsa) to the INPUT `ssh_key`


## License

This action is released under the [MIT License](LICENSE).

## Author

[Pierrick Delrieu](https://pierrickdelrieu.com)


