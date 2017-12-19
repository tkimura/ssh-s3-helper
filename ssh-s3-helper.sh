#!/bin/sh

s3_bucket=your_s3_bucket
s3_region=ap-northeast-1
s3_prefix=ssh
awscmd=/path/to/aws

[ -f /etc/default/ssh-s3-helper ] && . /etc/default/ssh-s3-helper

user=$1

if [ -z "$user" ]; then
	exit 1
fi

user_home=`awk -v u=$user -F':' '$1 ~ u {print $6}' < /etc/passwd`

aws_opts="--region $s3_region"
aws="$awscmd $aws_opts"

s3_key=`$aws s3api list-objects --bucket $s3_bucket --prefix $s3_prefix | jq -r ".Contents[] | select(.Key==\"${s3_prefix}/${user}\")|.Key"`

if [ -n "$s3_key" ]; then
	sshkey=`$aws s3api get-object --bucket $s3_bucket --key $s3_key /dev/stdout 2> /dev/null | grep '^ssh'`
	echo "$sshkey"
fi

exit 0
