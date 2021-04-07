{
    "Version": "2012-10-17",
    "Statement": [
        %{ if length_bucket >= 1 }
        {   
            "Sid": "S3Access",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:ListBucketMultipartUploads",
                "s3:ListBucketVersions",
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": ${buckets_json_formated}
        },
        %{ endif }
        {   
            "Sid": "ElasticsearchService",
            "Effect": "Allow",
            "Action": [
                "es:*",
                "logs:PutLogEvents",
                "logs:PutLogEventsBatch"
            ],
            "Resource": ["arn:aws:es:${aws_region}:${aws_caller_identity}:domain/${domain_name}/*"],
            "Principal": {
                "Service": "es.amazonaws.com"
                "AWS": "*",
            },
        }
    ]
}