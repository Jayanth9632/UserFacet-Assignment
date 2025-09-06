# --- Customize these for your environment ---

region             = "us-east-1"         # AWS region
key_name           = "My app1"            # your existing EC2 key pair name
allowed_ssh_cidr   = "49.37.183.63/32"    # replace with your IP
allowed_jenkins_cidr = "49.37.183.63/32"  # restrict Jenkins UI to your IP
instance_type      = "t3.small"          # instance size
volume_size_gb     = 20                  # root disk size
