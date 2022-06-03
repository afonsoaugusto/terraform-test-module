{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Sid": "AllowBucketToPipeline",
         "Effect": "Allow",
         "Principal": {
            "AWS": ${list_role_arns}
         },
         "Action": [
            "s3:GetBucketLocation",
            "s3:ListBucket",
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:DeleteObject",
            "s3:PutObjectTagging"
         ],
         "Resource": [
            "arn:aws:s3:::${bucket_name}",
            "arn:aws:s3:::${bucket_name}/*"
         ]
      }
   ]
}
