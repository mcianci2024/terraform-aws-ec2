# NTTDATA - DIGITAL ARCHITECTURE - ENGENIEER
# Create: Marcos Cianci - mlopesci@emeal.nttdata.com
# Date: Qua 9 Mar 2022
# Terraform Module - AWS EC2


resource "aws_instance" "ec2" {

    count                       = var.create_instance && !var.create_instance_spot ? 1 :0 

    ami                         = var.ami
    instance_type               = var.instance_type

    cpu_core_count              = var.cpu_core_count
    cpu_threads_per_core        = var.cpu_threads_per_core

    user_data                   = var.user_data
    user_data_base64            = var.user_data_base64

    availability_zone           = var.availability_zone
    subnet_id                   = var.subnet_id
    vpc_security_group_ids      = var.vpc_security_group_ids

    key_name                    = var.key_name
    monitoring                  = var.monitoring
    get_password_data           = var.get_password_data
    iam_instance_profile        = var.iam_instance_profile

    associate_public_ip_address = var.associate_public_ip_address
    private_ip                  = var.private_ip
    secondary_private_ips       = var.secondary_private_ip

    ebs_optimized               = var.ebs_optimized

    dynamic "root_block_device" {

        for_each = var.root_block_device

        content {
            delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
            encrypted = lookup(root_block_device.value,"encrypted", null)
            iops = lookup(root_block_device.value,"iops", null)
            kms_key_id = lookup(root_block_device.value,"kms_key_id", null)
            volume_size = lookup(root_block_device.value,"volume_size", null)
            volume_type = lookup(root_block_device.value,"volume_type", null)
            trhoughput = lookup(root_block_device.value,"trhoughput", null)
            tags = lookup(root_block_device.value,"tags", null)
        }
    }

    tags = merge({ "Name" = var.name }, var.tags )
  
}