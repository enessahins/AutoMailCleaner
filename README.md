# AutoMailCleaner

AutoMailCleaner is a Bash script designed to automatically delete old emails from specified user accounts in Zimbra. It searches for emails older than a specified number of days and removes them based on specific criteria.

## Features

- Searches for emails older than a specified number of days
- Deletes emails based on sender and subject criteria
- Supports multiple user accounts

## Requirements

- Zimbra command line tools must be installed and accessible
- Appropriate permissions to delete emails from user accounts

## Installation

1. Place the script in a suitable directory on your Zimbra server.
2. Modify the `path` variable in the script to point to the Zimbra binary directory if needed.
3. Update the `haric_kullanici` variable to specify any users whose emails should not be deleted.
4. Modify the `kimden` and `konu` variables to set the criteria for emails to delete.

## Usage

To run the script, execute the following command:

```bash
bash AutoMailCleaner.sh
```
The script will process all user accounts under the specified domain, searching for emails older than 15 days that match the specified criteria.

## Outputs

During execution, the script will:

* Display the user account being processed.
* Show the number of emails detected for deletion.
* Log the IDs of the deleted messages in a file named `eskiMesajlar.txt`.
* Report the total number of deleted emails for each user account.

## Contributing

Feel free to submit a pull request or open an issue for any contributions or suggestions.
