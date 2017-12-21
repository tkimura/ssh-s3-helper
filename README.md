ssh-s3-helper
====

What is this ?
----

* SSH authorization helper with AWS S3.
* Lookup user's public keys from AWS S3.

How to use ?
----

* Create your AWS S3 bucket.

* Enable static website hosting.

* Upload user's public keys to AWS S3 bucket.

* Deploy this script to your servers.

* Configure this script by /etc/default/ssh-s3-helper.

* Specifies to AuthorizedKeysCommand in /etc/ssh/sshd_config.

    ~~~
    AuthorizedKeysCommand /usr/local/bin/ssh-s3-helper %u
    AuthorizedKeysCommandUser nobody
    ~~~

    * AuthorizedKeysCommandUser is required. (man sshd_config)

Install
---

~~~
git clone git@github.com:tkimura/ssh-s3-helper.git
cd ssh-s3-helper
make
sudo make install
~~~

* If you have "go", install golang version.
* If you have't "go", install shell version.

Configure
----

**/etc/default/ssh-s3-helper**

~~~
s3_region=ap-northeast-1
s3_bucket=your_s3_bucket
s3_prefix=ssh/
~~~

* s3_region
    * Region of AWS S3 bucket
* s3_bucket
    * Name of AWS S3 bucket
* s3_prefix
    * Key prefix of user's public keys

Upload user's public keys
----

**Example of S3 URL**

~~~
s3://YOUR_S3_BUCKET/ssh/tkimura
~~~


S3 Bucket Policy
----

~~~
{
    "Version": "2012-10-17",
    "Id": "Policy1513788471347",
    "Statement": [
        {
            "Sid": "Stmt1513788469343",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::your_s3_bucket/*",
            "Condition": {
                "StringEquals": {
                    "aws:sourceVpc": "your_vpc_id"
                }
            }
        }
    ]
}
~~~

* Replace "your_s3_bucket"
* Replace "your_vpc_id" 


