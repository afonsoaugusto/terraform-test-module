{
    "Version": "2012-10-17",
    "Statement": [
        {   
            "Sid": "IamPassRole",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": [
                "arn:aws:es:${aws_region}:${aws_caller_identity}:role/${role_name}"
            ]
        },
        {
            "Sid": "SQSSendMesssage",
            "Effect": "Allow",
            "Action": "sqs:SendMessage",
            "Resource": ${list_sqs_arn}
        }
    ]
}