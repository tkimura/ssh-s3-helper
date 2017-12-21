#!/bin/sh

s3_region=ap-northeast-1
s3_bucket=your_s3_bucket
s3_prefix=ssh

[ -f /etc/default/ssh-s3-helper ] && . /etc/default/ssh-s3-helper

user=$1

if [ -z "$user" ]; then
	exit 1
fi

sshkey_url="https://s3-${s3_region}.amazonaws.com/${s3_bucket}/${s3_prefix}${user}"

curl -s $sshkey_url

exit 0
