{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EsHttp",
            "Effect": "Allow",
            "Action": [
                "es:ESHttp*"
            ],
            "Resource": ${es_arn}
        }
    ]
}