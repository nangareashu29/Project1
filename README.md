**Linux System User Management Script**

This Bash script provides a user-friendly command-line interface to manage user accounts, groups, and perform backups on a Linux system. The script includes options to add, delete, and modify user accounts, create and manage groups, and perform backups of specified directories.

**Usage**
Save this script to a file in Linux system and make it executable using

sudo chmod +x Linux-Project1.sh
You can then run it with different options to add, delete, or modify users, manage groups, and create backups.

**Creating a New User**
./Linux-Project1.sh -a
This option allows you to create a new user. The script will prompt you to enter the username and password for the new user.

**Deleting a User**
./Linux-Project1.sh -d
This option allows you to delete an existing user. The script will prompt you to enter the username of the user to be deleted.

**Modifying a User**
./Linux-Project1.sh -m -u
This option allows you to modify an existing user. The script will prompt you to enter the username, and then ask if you want to rename the user or add it to a specific group.

**Adding a New Group**
./Linux-Project1.sh -m -ga
This option allows you to add a new group. The script will prompt you to enter the group name and the group password.

**Removing a Group**
./Linux-Project1.sh -gd
This option allows you to remove an existing group. The script will prompt you to enter the name of the group to be removed.

**Performing a Backup**
./Linux-Project1.sh -b
This option allows you to perform a backup of a specified directory. The script will prompt you to enter the directory to be backed up.

**Functions to view the added users**
./Linux-Project1.sh -vu 
This option displays the added users.

Acknowledgments
This script is intended for educational purposes and may require further security considerations for production use.
Feel free to customize and enhance the script based on your specific requirements.
