<?php
function useradd($splitLine)
{

	$log="user ".$splitLine[1]." created\n";
	global $loggedon, $rootMade, $numUsers, $users, $logMessage;
	if ($loggedon==1)
	{
		addingUser($splitLine);
	}
	else if ($rootMade==0 && $splitLine[1]=="root")
	{
		addingUser($splitLine);
		$rootMade=1;
	}
	else if ($loggedon != 1)
	{
		$log="Must log in as root, loggedon is ".(string)$loggedon."\n";
	}
	else
	{
		$log="Must create root\n";
	}
	$logMessage=$logMessage.$log;
}

function addingUser($command)
{
	global $numUsers, $users;
	$users[2*$numUsers]=$command[1];
	$users[2*$numUsers+1]=$command[2];
	$numUsers++;
}

function login($splitLine)
{

	global $loggedon, $user, $numUsers, $users, $logMessage;
	$log=$splitLine[0]." ".$splitLine[1]."\n";
	if ($loggedon==0)
	{
		if ($numUsers>0)
		{
			$data = finduser($splitLine[1]);//returns password and array position
			if ($data[0]==$splitLine[2])
			{
				$user=$splitLine[1];
				$loggedon=2;
				if ($splitLine[1]=="root")
				{
					$loggedon=1;
				}
			}
			else
				$log="cannot log in as ".$splitLine[1]." passwords don't match \n";
		}
		else
			$log="Cannot log in with no users\n";
	}
	else
		$log="Cannot log more than 1 user at a time\n";

	$logMessage=$logMessage.$log;
}

function finduser($name)//returns user and array index of user
{

	$data[0]=-1;
	$data[1]=-1;
	global $numUsers, $users;
	for ($i=0; $i<$numUsers*2; $i=$i+2)
	{
		if($name==$users[$i])
		{
			$data[0]=$users[$i+1];
			$data[1]=$i;
		}
	}
	return $data;
}
//======================LOGOUT================
function logout($splitLine)
{

        global $loggedon, $user, $numUsers, $users, $logMessage;
        $log=$splitLine[0]."\n";
        if ($loggedon==0)
        {
		$log="Already logged out\n";
	}
        else
	{
		$loggedon=0;
	}
        $logMessage=$logMessage.$user." ".$log;
}
//====================GROUPADD===============
function groupadd($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $log="Group ".$splitLine[1]." created\n";
        if ($loggedon==1)
	{
		$exists=findgroup($splitLine[1]);
		if ($exists[1]<0)
		{
			if ($splitLine[1]!="nil")
			{
				$groups[$numGroups][0]=$splitLine[1];
				$groups[$numGroups][1]=0;
				$numGroups++;
				echo $numGroups. " ";
			}
			else
				$log="cannot create a group called 'nil'\n";
		}
		else
			$log="group exists\n";
	}
	else
		$log="Must be on root to create groups \n";

        $logMessage=$logMessage.$log;
}

function findgroup($name)
{
	$data[0]=-1;
	$data[1]=-1;
	$data[2]=-1;
        global $numGroups, $groups;
        for ($i=0; $i<$numGroups; $i++)
        {
                if($name==$groups[$i][0])
                {
                        $data[0]=$groups[$i][0];
                        $data[1]=$i;
			$data[2]=$groups[$i][1];
                }
        }
        return $data;
}
//=======================USERGRP==========================
function usergrp($splitLine)
{

        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $log="Added ".$splitLine[1]." to group ".$splitLine[2]."\n";
        if ($loggedon==1)
        {
                $exists=findgroup($splitLine[2]);
                if ($exists[1]>=0)
                {
			$groups[$exists[1]][$groups[$exists[1]][1]+2]=$splitLine[1];
			$groups[$exists[1]][1]++;
                }
                else
                        $log="group does not exist\n";
        }
        else
                $log="Must be on root to create groups \n";
        $logMessage=$logMessage.$log;
}
//========================MKFILE========================
function mkfile($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $log="Created file ".$splitLine[1]."\n";
	if($splitLine[1]=="files.txt"||$splitLine[1]=="audit.txt"||$splitLine[1]=="accounts.txt"||$splitLine[1]=="groups.txt")
	{
		echo "Cannot make the file\n";
		$log="Cannot make the file. It is reserved\n";
	}
        elseif ($loggedon>0)
        {
                $exists=findFile($splitLine[1]);
                if ($exists[1]<0)
                {
			$files[$numFiles*6]=$splitLine[1];
			$files[$numFiles*6+1]=$user;
			$files[$numFiles*6+2]="nil";
			$files[$numFiles*6+3]="rw-";
			$files[$numFiles*6+4]="---";
			$files[$numFiles*6+5]="---";
			$makeFile=fopen($splitLine[1],'w');
			fclose($makeFile);
			$numFiles++;
                }
                else
                        $log="file exists\n";
        }
        else
                $log="Must be on to create groups \n";

        $logMessage=$logMessage.$log;
}

function findFile($name)//returms filename, index, owner
{
        $data[0]=-1;
        $data[1]=-1;
        $data[2]=-1;
        global $numFiles, $files;
        for ($i=0; $i<$numFiles*6; $i=$i+6)
        {
                if($name==$files[$i])
                {
                        $data[0]=$files[$i];
                        $data[1]=$i;
                        $data[2]=$files[$i+1];
			$data[3]=$files[$i+2];
                }
        }
        return $data;
}
//=======================CHMOD=============================
function chmod1($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $log="Permissions for ".$splitLine[1]." set to ".$splitLine[2]." ".$splitLine[3]." ".$splitLine[4]." by ".$user."\n"; 
        if ($loggedon>0)
        {
                $exists=findFile($splitLine[1]);
                if ($exists[2]==$user || "root"==$user)
                {
                        $files[$exists[1]+3]=$splitLine[2];
                        $files[$exists[1]+4]=$splitLine[3];
                        $files[$exists[1]+5]=$splitLine[4];
                }
                else
                        $log="Invalid user to change file ".$splitLine[1]."\n";
        }
        else
                $log="Must be on to create groups \n";

        $logMessage=$logMessage.$log;
}
//==========================CHOWN===============================
function chown1($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $log="Owner of file ".$splitLine[1]." changed to ".$splitLine[2]."\n";
        if ($loggedon==1)
        {
                $exists=findFile($splitLine[1]);
		$index=$exists[2];
                if ($exists[1]>=0)
                {
			$exists=finduser($splitLine[2]);
			if ($exists[1]>0)
			{
				$files[index+1]=$splitLine[2];
                	}
			else
				$log="user does not exist\n";
		}
                else
                        $log="File does not exist to change owners\n";
        }
        else
                $log="Must be root to create groups \n";

        $logMessage=$logMessage.$log;
}
//==========================CHGRP===============================
function chgrp1($splitLine)
{

        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $log="Group associated with file ".$splitLine[1]." changed to ".$splitLine[2]."\n";
        if ($loggedon>0)
        {
		$exists=findFile($splitLine[1]);
		$index=$exists[1];
		$name=$exists[2];
                if ($exists[1]>=0)
                {
                        $fxists=findGroup($splitLine[2]);
                        if ($fxists[1]>=0 || $splitLine[2]=="nil")
                        {
				if ($user==$name || $user=="root")
				{
                                	$files[index+2]=$splitLine[2];
				}
				else
					$log="must be owner or root to change association=n";
                        }
                        else
                                $log="Group does not does exist to change group association\n";
                }
                else
                        $log="File does not exist to change group association\n";

        }
        else
                $log="Must be logged in to change file group \n";

        $logMessage=$logMessage.$log;
}
//=============================READ=================================
function read1($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $log= $user. " failed to read the file, ".$splitLine[1]."\n";
	$exists=findFile($splitLine[1]);
	$inGroup=0;
	$groupLoc=findGroup($files[$exists[1]+2]);
	for ($i=0; $i<$groups[$groupLoc[1]][1];$i++)
	{
        	if ($groups[$groupLoc[1]][2+i]==$user)
			$inGroup=1;
	}
	if ($exists[1]>=0)
	{
		if ($user==$exists[2])
		{
			if($files[$exists[1]+3][0]=="r")
			{
				$log=$user." successfully read: ".readFile1($splitLine);
			}
			else
				$log="Owner does not have permission to open file ".$splitLine[0]."\n";
		}
		else
		{
			if ($inGroup==1)
			{
				if ($files[$exists[1]+4][0]=="r")
				{
					$log=$user." successfully read: ".readFile1($splitLine);
				}
				else
					$log="Group does not have permission to open this file ".$splitLine[0]."\n";
			}
			else
				if ($files[$exists[1]+5][0]=="r")
				{
					$log=$user. " successfully read:".readFile1($splitLine);
				}
				else
					$log="Public does not have permission to open this file ".$splitLine[0]."\n";
		}
	}
	else
		$log="File does not exist for reading\n";

	$logMessage=$logMessage.$log;
}
//================================================WRITE=====================================
function write1($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
	$message="";
	$log=$user." successfully entered text in ".$splitLine[2];
	for ($i=2; $i<count($splitLine);$i++)
	{
		$message=$message.$splitLine[$i]." ";
	}
	$inGroup=0;
	$theGroup=findFile($splitLine[1]);
	$sGroup=findGroup($theGroup[2]);
	$exists=findFile($splitLine[1]);
	for ($i=2;$i<($groups[$sGroup[1]][1]+2);$i++)
	{
		if ($user == $groups[$sGroup[1]][$i])
		{
			$inGroup=1;
		}
	}
        if ($exists[1]>=0)
        {
                if ($user==$exists[2])
                {
                        if($files[$exists[1]+3][1]=="w")
                        {
				writeFile($splitLine);
                        }
                        else
			{
                                $log="Owner does not have permission to write to the file ".$splitLine[0]."\n";
			}
		 }
		else
                {
                        if ($inGroup==1)
                        {
                                if ($files[$exists[1]+4][1]=="w")
                                {
					writeFile($splitLine);
                                }
                                else
                                        $log="Group does not have permission to write to the file ".$splitLine[0]."\n";
                        }
                        else
                                if ($files[$exists[1]+5][1]=="w")
					writeFile($splitLine);
                                else
                                        $log="Public does not have permission to write to the file ".$splitLine[1]."\n";
                }
        }
       else
               $log="File does not exist for writing\n";

	$logMessage=$logMessage.$log.": ".$message."\n";
}
function writeFile($splitLine)
{
	$wFile=fopen($splitLine[1],'a');
	for ($i=2; $i<count($splitLine); $i++)
		fwrite($wFile,$splitLine[$i]." ");
	fwrite($wFile,"\n");
	fclose($wFile);
}
function readFile1($splitLine)
{
	$log="";
	$rSize=count(file($splitLine[1]));
	$rFile=fopen($splitLine[1],'r') or die("");
	for($line=1; $line<=$rSize; $line++)
		$log=$log.fgets($rFile);
	fclose($rFile);
	return $log;
}
//===================EXECUTE=================
function execute1($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $log= $user. " executed the prog successfully\n";
        $exists=findFile($splitLine[1]);
        $inGroup=0;
        $groupLoc=findGroup($files[$exists[1]+2]);
        for ($i=0; $i<$groups[$groupLoc[1]][1];$i++)
        {
                if ($groups[$groupLoc[1]][2+i]==$user)
                        $inGroup=1;
        }
        if ($exists[1]>=0)
        {
                if ($user==$exists[2])
                {
                        if($files[$exists[1]+3][2]=="x")
                        {
                        }
                        else
                        {
                                $log="Owner does not have permission to execute file ".$splitLine[0]."\n";
                        }
                 }
                else
                {
                        if ($inGroup==1)
                        {
                                if ($files[$exists[1]+4][2]=="x")
                                {
                                }
                                else
                                        $log="Group does not have permission to execute file ".$splitLine[0]."\n";
                        }
                        else
                                if ($files[$exists[1]+5][2]=="x")
				{
				}
                               else
                                        $log="Public does not have permission to execute file ".$splitLine[0]."\n";
                }
        }
        else
                $log="File does not exist for execution\n";

        $logMessage=$logMessage.$log;
}
//========================LS===============================
function ls($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
        $index=findFile($splitLine[1]);
	$log= $files[$index[1]]." ".$files[$index[1]+1]." ".$files[$index[1]+2]." ".$files[$index[1]+3]." ".$files[$index[1]+4]." ".$files[$index[1]+5]."\n";
        $exists=findFile($splitLine[1]);
	if ($exists[1]<0)
                $log="File does not exist for reading\n";

        $logMessage=$logMessage.$log;
}
//========================end===============================
function end1($splitLine)
{
        global $groups, $files,$numGroups, $numFiles, $loggedon, $user, $numUsers, $users, $logMessage;
	$filesOut=fopen("files.txt",'w');
	for($i=0; $i<($numFiles*6); $i=$i+6)
	{
		fwrite($filesOut, $files[$i].": ".$files[$i+1]." ".$files[$i+2]." ".$files[$i+3]." ".$files[$i+4]." ".$files[$i+5]."\n");
	}
	fclose($filesOut);

        $groupsOut=fopen("groups.txt",'w');
        for($i=0; $i<$numGroups; $i++)
        {
		fwrite($groupsOut,$groups[$i][0].":");
        	for($j=2; $j<($groups[$i][1]+2); $j++)
		{
			fwrite($groupsOut," ".$groups[$i][$j]);
		}
		fwrite($groupsOut,"\n");
        }
        fclose($groupsOut);
}
//=======================READ COMMAND INPUT================
function readInput()
{
	global $inVar, $inLines;
	for($line=1; $line<=$inLines; $line++)
	{
		$getLine=substr(fgets($inVar),0,-1);//reads line without new line
		$splitLine=explode(' ',$getLine);
		$command=$splitLine[0];
		if ($command=="useradd")
			useradd($splitLine);
		if ($command=="login")
			login($splitLine);
		if ($command=="logout")
			logout($splitLine);
		if ($command=="groupadd")
			groupadd($splitLine);
		if ($command=="usergrp")
			usergrp($splitLine);
		if ($command=="mkfile")
			mkfile($splitLine);
		if ($command=="chmod")
			chmod1($splitLine);
		if ($command=="chown")
			chown1($splitLine);
		if ($command=="chgrp")
			chgrp1($splitLine);
		if ($command=="read")
			read1($splitLine);
		if ($command=="write")
			write1($splitLine);
		if ($command=="execute")
			execute1($splitLine);
		if ($command=="ls")
			ls($splitLine);
		if ($command=="end")
			end1($splitLine);
	}
}
$rootMade=0; //flag for if root account was created
$loggedon=0; //0=logged off, 1=root, 2=users
$user="nil"; //user name
$numUsers=0; //number of users
$numGroups=0; //number of groups
$numFiles=0; //Number of Files
$users[0]="";
$files[0]=""; //files array
$groups[0][0]=""; //groups array
$inName="commands";
$logMessage="";
$inLines=count(file($inName));
$inVar=fopen($inName,'r') or die("File DNE");
readInput();
$audit=fopen("audit.txt",'w');
fwrite($audit,$logMessage);
fclose($audit);
fclose($inVar);//end
?>
