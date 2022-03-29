#WebVms
vm_hostname  = ["oemwebvm01","oemwebvm02","otmwebvm01","otmwebvm02"]
image_shape = "VM.Standard.E3.Flex"
vm_shape = ["VM.Standard.E3.Flex","VM.Standard.E3.Flex","VM.Standard.E3.Flex","VM.Standard.E3.Flex"]
boot_volume_size_in_gbs = ["50","50","50","50"]
vm_state =["RUNNING","RUNNING","RUNNING","RUNNING"]
memoery_in_gbs = ["64","64","64","64"]
ocpus  = ["1","1","1","1"]                    

#AppVMS
app_vm_hostname = ["obiappvm01","obiappvm02","otmappvm01","otmappvm02","oeappvm01","oeappvm02"]
app_vm_shape = ["VM.Standard.E4.Flex","VM.Standard.E4.Flex","VM.Standard.E4.Flex","VM.Standard.E4.Flex","VM.Standard.E4.Flex","VM.Standard.E4.Flex"]
app_boot_volume_size_in_gbs = ["50","50","50","50","50","50"]
app_vm_state = ["RUNNING","RUNNING","RUNNING","RUNNING","RUNNING","RUNNING"]
app_memoery_in_gbs = ["64","64","64","64","64","64"]
app_ocpus = ["1","1","1","1","1","1"]     