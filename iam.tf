
resource "aws_iam_role" "our-iam-role" {
    name = "Terraform-Admin"
    assume_role_policy = <<EOF  //<<EOF ek delimiter (marker) hai jo multi-line content ki shuruaat karta hai.
{
   "Version": "2012-10-17",        // JSON policy ka version
   "Statement": [                 // Ek ya ek se zyada rules define karne ke liye
     {
       "Sid": "",                 // Statement ID (optional)
       "Effect": "Allow",         // "Allow" action ko enable kar raha hai
       "Principal": {             // Role ka user ya service kaun hai?
         "Service": [             // AWS service define karte hain
           "ec2.amazonaws.com"    // Sirf EC2 service ko ye role use karne ki permission di
         ]
       },
       "Action": "sts:AssumeRole" // Role ko assume karne ka action define karta hai
     }
   ]
 }

EOF
}
  


resource "aws_iam_role_policy_attachment" "ec2-policy" {
    role = aws_iam_role.our-iam-role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

/*
 data "aws_iam_roles" "my-available-role"{
    filter {
        name = "role-name"
        values = ["admin"]
    }
}

*/

resource "aws_iam_instance_profile" "our-instance-profile" {
    name = "jenkins-instance-profile"
    role = aws_iam_role.our-iam-role.name
   # role = data.aws_iam_roles.my-available-role.name
  
}

/*
resource "aws_iam_policy" "my-iam-policy" {
    name = "my-iam-policy"
    policy = 
    path = "/role.json"
   # role = "${aws_iam_role.our-iam-role.name}"
}
*/