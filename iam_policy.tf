resource "aws_iam_policy" "WebAppS3" {

  depends_on = [
    aws_s3_bucket.my_s3_bucket
  ]

  name = "WebAppS3"

  #   policy = "${file("s3-policy.json")}"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject"
          ],
          "Effect" : "Allow",

          "Resource" : [
            "arn:aws:s3:::${aws_s3_bucket.my_s3_bucket.bucket}",
            "arn:aws:s3:::${aws_s3_bucket.my_s3_bucket.bucket}/*"
          ]
        }
      ]
    }
  )

}

resource "aws_iam_role" "EC2-CSYE6225" {
  name = "EC2-CSYE6225"

  depends_on = [
    aws_s3_bucket.my_s3_bucket
  ]

  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
            }
        ]
    }
    EOF



  tags = {
    "Name" = "csye6225_ec2_role"
  }
}

resource "aws_iam_role" "cloud_watch_role" {
  
  name = "cloud_watch_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

}


resource "aws_iam_role_policy_attachment" "attach_role_policy" {

  depends_on = [
    aws_iam_policy.WebAppS3
  ]

  role       = aws_iam_role.EC2-CSYE6225.name
  policy_arn = aws_iam_policy.WebAppS3.arn
}

resource "aws_iam_role_policy_attachment" "attach_role_policy_2" {
  role = aws_iam_role.EC2-CSYE6225.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}



# resource "aws_iam_role_policy_attachment" "cloud_watch_policy" {
#   role = aws_iam_role.cloud_watch_role.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
# }


# data "aws_iam_policy_document" "allow_access" {

#   statement {
#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket"
#     ]
#     resources = [
#       aws_s3_bucket.my_s3_bucket.arn,
#       "${aws_s3_bucket.my_s3_bucket.arn}/*"
#     ]
#   }
# }


# resource "aws_iam_role" "test_role" {
#   name = "test_role"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "tag-value"
#   }
# }