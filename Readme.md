# Terraform-Jenkins-EKS

The deployment process is based on https://youtu.be/wY8VFIAz_Og?si=twiKNx5E08eckjMt.

## Installation

 We need to setup the jenkins server first. 

 ```
 cd JenkinsServer
 terraform init
 terraform fmt
 terraform validate
 terraform plam
 terraform apply --auto-approve
 ```

 Open your jenkins and create a new project. 
 Setup EKS cluster in your project using Jenkinsfile.

CI/CD jenkins will provide your to deploy your application on EKS cluster.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/neerajkumar/terraform-jenkins-eks. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Terraform-Jenkins-EKS project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/neerajkumar/terraform-jenkins-eks/blob/master/CODE_OF_CONDUCT.md).