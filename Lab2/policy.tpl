{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "ec2:DescribeInstance", "ec2:DescribeImages",
            "ec2:DescribeTags", "ec:DescribeSnapshots"    
        ],
        "Resource": "${arn}
    }
    ]
}