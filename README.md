# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Usage](#usage)
- [Delivery date](#delivery-date)
- [Dockerfile](#dockerfile)
- [Terraform] (#terraform)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)
- azure-identity (version 1.15.0)
- azure-keyvault-secrets (version 4.7.0)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

# DevOps Pipeline Architecture 


## Delivery Date


## Dockerfile
Developing a Dockerfile for the application involves encapsulating all essential dependencies and configuration settings. This containerization process ensures uniform application packaging and streamlines the deployment process.
### step 1
**Base Image Selection:**
Begin by selecting an official Python runtime as the parent image. For a Flask application, python:3.8-slim is a suitable choice. 

**Set the Working Directory:**
Utilize the WORKDIR instruction to establish the working directory in the container. Set it to /app, a commonly used directory for web applications.

**Copy Application Files:**
Utilise the COPY instruction to transfer the contents of your local directory into the container's /app directory. This ensures accessibility of your application code and files within the container.

**Install Python Packages from requirements.txt:**
Install the Python packages outlined in your requirements.txt file. This file should encompass all the necessary packages for the successful execution of the application. Execute the command `pip install --trusted-host pypi.python.org -r requirements.txt` to install these packages.

**Expose Port 5000:**
Facilitate external access to your Flask application from outside the container by specifying the exposure of port 5000.

**Define Startup Command:**
Employ the CMD instruction to specify the command executed upon container launch. In this case, the command should run the file initiating the Flask application.

### step 2 
Proceed to build your Docker image as it stands by executing the following command: docker build -t <name_of_the_image> .

### step 3 
Run a local Docker container to verify the proper functioning of the application within the containerized environment. Initiate the Docker container by executing the following command: docker run -p 5000:5000 <name_of_the_image>. This command maps port 5000 from your local machine to the container, facilitating access to the containerized application from your local development environment. Access the application within the Docker container by opening a web browser and navigating to http://127.0.0.1:5000. Confirm the expected functionality of the application by testing its features within the containerized environment.

### step 4 
Label your Docker image with pertinent details. Specify the image name, version, and Docker Hub repository using the following format: docker tag <name_of_the_image> <docker_hub_username>/<image_name>:<tag>. Employ the `docker push` command to upload the Docker image to Docker Hub. To ensure accessibility, perform a test by pulling the image from Docker Hub, preferably in your local development environment. After successfully pulling the image, run the container and confirm that the application functions as expected.

## Terraform
This will serve as the foundation for provisioning an Azure Kubernetes Service (AKS) cluster using infrastructure as code (IaC)

### Define the networking module 
### variable.tf
The following two variables should of type string, and one show be of type list (string)
Create the following variables:
- Resource_group_name variable: A container that includes the relevant Azure resources to be managed and deployed.
- Location variable: the location where the AKS cluster service will be situated. 
- vnet_address_space: a defined range of virtual addressed allocated to communicate among tasks within the resource group. 

### main.tf
Establish the fundamental networking resources required for an AKS cluster. This encompasses the creation of an Azure Resource Group, a VNet, two subnets (for the control plane and worker nodes), and a Network Security Group (NSG). 
Assign the following names to these resources:
1. **Azure Resource Group:** variable created earlier (container that includes relevant Azure resoucers to be managed and deployed).
2. **Virtual Network (VNet):** (Allows resources to communicate with each other).
3. **Control Plane Subnet:** (Manages the resources and clusters such as nodes and pods).
4. **Worker Node Subnet:** (A virtual machine that processes a portion of an application's workload).
5. **Network Security Group (NSG):** (Security rules that manage inbound and outbound traffic for several types of Azure resources)

### outputs.tf
Define the following output variables:
1. **vnet_id:** (Stores the ID of the previously created VNet, facilitating connection to the cluster module).
2. **control_plane_subnet_id:** (Holds the ID of the control plane subnet within the VNet, specifying the subnet for AKS cluster control plane components).
3. **worker_node_subnet_id:** (Stores the ID of the worker node subnet within the VNet, specifying the subnet for AKS cluster worker nodes).
4. **networking_resource_group_name:** (Provides the name of the Azure Resource Group where networking resources were provisioned, ensuring alignment with the cluster module resources).
5. **aks_nsg_id:** (Stores the ID of the Network Security Group (NSG), facilitating association with the AKS cluster for security rule enforcement and traffic filtering).

Finally, you would now use the following command terraform init to initalise the directory. 

## Defining and AKS cluster
Define the subsequent input variables:
1. **aks_cluster_name:** (Represents the name of the AKS cluster to be created).
2. **cluster_location:** (Specifies the Azure region where the AKS cluster will be deployed).
3. **dns_prefix:** (Defines the DNS prefix of the cluster).
4. **kubernetes_version:** (Specifies the Kubernetes version the cluster will use).
5. **service_principal_client_id:** (Provides the Client ID for the service principal associated with the cluster).
6. **service_principal_secret:** (Supplies the Client Secret for the service principal).

Additionally, you would include the output variables as input variables in this module. 
1. **resource_group_name:** (The name of the Azure Resource Group where networking resources were provisioned).
2. **vnet_id:** (The ID of the previously created VNet).
3. **control_plane_subnet_id:** (The ID of the control plane subnet within the VNet).
4. **worker_node_subnet_id:** (The ID of the worker node subnet within the VNet).

### cluster module output variables 
output variables:
1. **aks_cluster_name:** (Stores the name of the provisioned cluster).
2. **aks_cluster_id:** (Stores the ID of the cluster).
3. **aks_kubeconfig:** (Captures the Kubernetes configuration file of the cluster, crucial for interacting with and managing the AKS cluster using kubectl).
Once you've configured the settings, initiate the directory using `terraform init`. The setup will be on the main branch within the aks-cluster directory.

## Creating an AKS cluster 
Integrate the networking resources previously defined in their respective module so they are accessible in the main project.
Ensure that you supply the specified input variables when invoking the module:
- Set `resource_group_name` to a descriptive name, for instance, "networking-rg."
- Set `location` to an Azure region geographically close to you to enhance latency (e.g., "UK South").
- Set `vnet_address_space` to ["10.0.0.0/16"].
## integrate the cluster module 
Assign the following values to the specified input variables when invoking the module:
- Set `cluster_name` to "terraform-aks-cluster."
- Set `location` to an Azure region geographically close to you to enhance latency (e.g., "UK South").
- Set `dns_prefix` to "myaks-project."
- Set `kubernetes_version` to a supported Kubernetes version by AKS, such as "1.26.6."
- Set `service_principal_client_id` and `service_principal_secret` to your service principal credentials.
- Utilise variables referencing the output variables from the networking module for the remaining input variables required by the cluster module, including `resource_group_name`, `vnet_id`, `control_plane_subnet_id`, `worker_node_subnet_id`, and `aks_nsg_id`.

After configuring the settings, initialise the directory using `terraform init`. The setup will be on the main branch within the aks-terraform directory. Once all configurations are initialised, execute `terraform apply` to create the cluster in Azure using AKS (Azure Kubernetes Services).

### service principal 
Ensure you create a service principle to do this follow the command below, this ensures restriction to sensitive information
az ad sp create-for-rbac --name {name} --role contributor --scopes /subscriptions/{your-subscription-id}

## Kubernetes Deployment to AKS 






## Contributors 

- [Maya Iuga]([https://github.com/yourusername](https://github.com/maya-a-iuga))
- [Anishah Hussain] (https://github.com/anishah78/Web-App-DevOps-Project.git)

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.
