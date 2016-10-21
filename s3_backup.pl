#!/usr/bin/perl
## Program to take S3 backup
#Author: Vinod.N K
#Usage: AWS S3 Backup.
#Distro : Linux -Centos, Rhel, and any fedora
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
use File::stat;
use POSIX qw(strftime);
use Net::Amazon::S3;

my $aws_access_key_id     = 'xxxxxxxxxxxxxxx';
my $aws_secret_access_key = 'xxxxxxxxxxxxxxxxxxxxx';

  my $s3 = Net::Amazon::S3->new(
      {   aws_access_key_id     => $aws_access_key_id,
          aws_secret_access_key => $aws_secret_access_key,
          retry                 => 1,
      }
  );
my $bucketname = 'Server_backup';
$bucket = $s3->bucket($bucketname);

(@date)=localtime;
$date[5]+=1900;$date[4]++;
$log_date=sprintf("%0.2d-%0.2d-%0.2d",$date[3],$date[4]++, $date[5]);

$dirname = '/newbackup/CLIENTNAME/DB/';
$timediff=0;
opendir (DIR, $dirname) or die $!;
while (my $file = readdir(DIR))
{
    if($file =~ m/\S+\.ip-10-253-175-66\.$log_date/)
    {
       print "Hai\nnnnn";
       print " Uploading data ......\n";
       $log_fname = $dirname."/".$file;
       $s3_key = "AIEP/mysql/".$file;
       $bucket->add_key_filename( $s3_key,$log_fname ) or die $s3->err . ": " . $s3->errstr;
       print "Upload Completed ...\n";
       print "$s3->errstr;";
    }
}
