ssh-s3-helper
====

What is this ?
----

* SSH authorization helper with AWS S3.
* Lookup user's public keys from AWS S3.

How to use ?
----

* Create your AWS S3 bucket.

* Upload user's public keys to AWS S3 bucket.

* Deploy this script to your servers.

* Configure this script by /etc/default/ssh-s3-helper.

* Specifies to AuthorizedKeysCommand in /etc/ssh/sshd_config.

    ~~~
    AuthorizedKeysCommand /usr/local/bin/ssh-s3-helper.sh %u
    AuthorizedKeysCommandUser nobody
    ~~~

    * AuthorizedKeysCommandUser is required. (man sshd_config)

Configure
----

**/etc/default/ssh-s3-helper**

~~~
s3_bucket=your_s3_bucket
s3_region=ap-northeast-1
s3_prefix=ssh
awscmd=/path/to/aws
~~~

* s3_bucket
    * Name of AWS S3 bucket
* s3_region
    * Region of AWS S3 bucket
* s3_prefix
    * Key prefix of user's public keys
* awscmd
    * Path of aws command

Upload user's public keys
----

**Example of S3 URL**

~~~
s3://YOUR_S3_BUCKET/ssh/tkimura
~~~


Requirements
----

* [aws](https://github.com/aws/aws-cli)
    * ex) `sudo apt-get install awscli`
* [jq](https://github.com/stedolan/jq)
    * ex) `sudo apt-get install jq`

IAM Policy for AWS S3
----

~~~
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::your_s3_bucket/*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::your_s3_bucket"
        }
    ]
}
~~~

* Replace "your_s3_bucket" to your s3 bucket name.

