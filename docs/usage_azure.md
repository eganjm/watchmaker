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
