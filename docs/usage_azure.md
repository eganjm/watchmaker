## `watchmaker` in Azure

### `watchmaker` as Custom Script Extension

Custom Script Extension downloads and executes scripts on Azure virtual
machines. For Linux, you run the bash script shown in the section on
[Linux](#linux). You can store the bash script in Azure Storage or a publicly
available url (such as with S3). Then you execute the stored script with a
command. For example, a JSON string could contain

```json
{
  "fileUris": ["https://path-to-bash-script/run_watchmaker.sh"],
  "commandToExecute": "./run_watchmaker.sh"
}
```

These parameters can be passed in via Azure CLI or within a Resource Management
Template. For more in-depth information, see Microsoft's
[documentation on Linux](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-linux).

For Windows, you would execute a PowerShell script in a similar manner as for
[Windows](#windows) (but without the powershell tags). Then you would have the
following parameters:

```json
{
  "fileUris": ["https://path-to-bash-script/run_watchmaker.ps1"],
  "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File run_watchmaker.ps1"
}
```

For more in-depth information on using Custom Script Extension for Windows, see
Microsoft's [documentation on Windows](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows).

#### Linux

For **Linux**, you must ensure `pip` is installed, and then you can install
`watchmaker` from PyPi. After that, run `watchmaker` using any option available
on the [CLI](#watchmaker-from-the-cli). Here is an example:

```shell
#!/bin/sh
PYPI_URL=https://pypi.org/simple

# Setup terminal support for UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Install pip
python3 -m ensurepip

# Install setup dependencies
python3 -m pip install --index-url="$PYPI_URL" --upgrade pip setuptools

# Install Watchmaker
python3 -m pip install --index-url="$PYPI_URL" --upgrade watchmaker

# Run Watchmaker
watchmaker --log-level debug --log-dir=/var/log/watchmaker
```

Alternatively, cloud-config directives can also be used on **Linux**:

```yaml
#cloud-config

runcmd:
  - |
    PYPI_URL=https://pypi.org/simple

    # Setup terminal support for UTF-8
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    # Install pip
    python3 -m ensurepip

    # Install setup dependencies
    python3 -m pip install --index-url="$PYPI_URL" --upgrade pip setuptools

    # Install Watchmaker
    python3 -m pip install --index-url="$PYPI_URL" --upgrade watchmaker

    # Run Watchmaker
    watchmaker --log-level debug --log-dir=/var/log/watchmaker
```

#### Windows

For **Windows**, the first step is to install Python. `Watchmaker` provides a
simple bootstrap script to do that for you. After installing Python, install
`watchmaker` using `pip` and then run it.

```shell
<powershell>
$BootstrapUrl = "https://watchmaker.cloudarmor.io/releases/latest/watchmaker-bootstrap.ps1"
$PythonUrl = "https://www.python.org/ftp/python/3.6.8/python-3.6.8-amd64.exe"
$PypiUrl = "https://pypi.org/simple"

# Download bootstrap file
$BootstrapFile = "${Env:Temp}\$(${BootstrapUrl}.split('/')[-1])"
(New-Object System.Net.WebClient).DownloadFile("$BootstrapUrl", "$BootstrapFile")

# Install python
& "$BootstrapFile" -PythonUrl "$PythonUrl" -Verbose -ErrorAction Stop

# Install Watchmaker
python -m pip install --index-url="$PypiUrl" --upgrade pip setuptools
pip install --index-url="$PypiUrl" --upgrade watchmaker

# Run Watchmaker
watchmaker --log-level debug --log-dir=C:\Watchmaker\Logs
</powershell>
```