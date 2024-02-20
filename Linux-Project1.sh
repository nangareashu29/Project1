#!/bin/bash

# Function to display available options

options() 
{
echo "Options:"
echo " -a,      --create       Create a new user account."
echo " -d,      --delete       Delete a existing user account."
echo " -g,      --group        Create a new group account."
echo " -m -u    --modify       Modify the existing username."
echo " -m -ga   --groupadd     User is added to the group."
echo " -gd      --groupdelete  Delete a existing group."
echo " -b,      --backup       Backup the scripts files."
echo " -vu      --viewuser     View added users."
}

# Function to create a new user account

add_user() 
{
read -p "Enter your username:" username

	# Check if the username already exists

	if id "$username" &>/dev/null; then
		echo "Error: The username '$username' already exists. Please choose a different username."
		return 1
	fi

# Prompt for password

read -s -p "Enter your password:" password

echo

	if 
		# Create the user account using sudo

		sudo useradd -m -p "$(openssl passwd -1 $password)" $username; then
		echo
		echo "$username added successfully"
	else
		echo "Error: Failed to create user account '$username'."
		return 1
	fi
}

# Function to delete an existing user account 

del_user() 
{
read -p "Which username you want to delete ?" username

echo
 	
	if sudo userdel -r $username; then
		echo "$username deleted successfully"
	else
		echo "Error: Failed to delete '$username'."
	fi

}

# Function to create a group name

add_grp() 
{
echo
read -p "Enter a groupname: " groupname
echo
	if sudo groupadd $groupname; then
		echo "$groupname is created"
	else
		echo "Error: Failed to create a '$groupname'."
	fi
}

# Function to delete an existing group

del_grp()
{
read -p "Which group you want to delete? " groupname

echo
	if sudo groupdel $groupname; then		
		echo "$groupname deleted successfully"
	else
		echo "Error: Failed to delete '$groupname'."
	fi

}

# Functions to modify the username and add the users to the group

mod_user() {

 echo
    if [ "$1" == "-u" ]; then
        read -p "Which user you want to modify? " oldusername
        read -p "What name you want? " newusername
        echo
        echo "Modifying user..."
        sudo usermod -l $newusername $oldusername
        if [ $? -eq 0 ]; then
            echo "User modified from ${oldusername} to ${newusername}"
            cat /etc/passwd
            echo "Folder name is changing.."
            cd ../.. && sudo mv $oldusername $newusername
            echo "Folder name is changed"
            echo "Group name is changing.."
            sudo groupmod -n $newusername $oldusername
            echo "Group name changed"
            cat /etc/group
            echo "The process of user modification is completed successfully"
        else
            echo "Error: Failed to modify username of $oldusername to $newusername"
        fi
    elif [ "$1" == "-ga" ]; then
        read -p "In which group you want to add? " groupname
        read -p "Which user you want to add? " username
        echo "User adding to the group..."
        sudo usermod -aG $groupname $username
        if [ $? -eq 0 ]; then
            echo "$username added to the $groupname"
            cat /etc/group
        else
            echo "Error: Failed to add '$username' to '$groupname'."
        fi
    else
        echo "Error: Invalid option. Use '-u' to modify a user or '-ga' to add a user to a group."
    fi
               
}

# Functions to take a backup from 'scripts' folder to 'backups' folder

backup() 
{
echo
	
	trg="/home/ubuntu/backups"
	src="/home/ubuntu/scripts"

	filename="scripts_backup_$(date +%Y-%m-%d-%H-%M-%S).tar.gz"

	echo "backup for $filename is in process..."
	echo "."
	echo "."
	echo "."
	echo "."
	echo "backup $filename completed"	
	echo
	tar -czvf ${trg}/${filename} ${src}

}

# Functions to view the added users

viewuser() {

		
		echo "View added user below:"
		echo 
		cd ../.. && ls
		cat /etc/passwd


}

# List of calling the functions 

if [ "$1" == "-a" ]; then

	add_user

elif [ "$1" == "-d" ]; then

	del_user

elif [ "$1" == "-g" ]; then

	add_grp

elif [ "$1" == "-gd" ]; then
	
	del_grp

elif [ "$1" == "-m" ]; then

	mod_user $2  

elif [ "$1" == "-b" ]; then

	backup

elif [ "$1" == "-vu" ]; then

	viewuser 

else options

fi
